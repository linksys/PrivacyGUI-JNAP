import 'dart:async';
import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/src/models/firmware_update_settings.dart';
import 'package:jnap/src/models/firmware_update_status.dart';
import 'package:jnap/src/models/firmware_update_status_nodes.dart';
import 'package:jnap/http.dart';
import 'package:jnap/src/providers/firmware_update_state.dart';
import 'package:jnap/src/providers/polling_provider.dart';
import 'package:jnap/src/utilties/extension.dart';
import 'package:jnap/src/utilties/logger/bench_mark_logger.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:jnap/src/providers/side_effect_provider.dart';
import 'package:jnap/logger.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class FirmwareUpdateManager {
  FirmwareUpdateSettings? fwUpdateSettings;
  List<FirmwareUpdateStatus>? resultStatusList;

  FirmwareUpdateManager(this.fwUpdateSettings, this.resultStatusList);

  
}

final firmwareUpdateProvider =
    NotifierProvider<FirmwareUpdateNotifier, FirmwareUpdateState>(
        () => FirmwareUpdateNotifier());

class FirmwareUpdateNotifier extends Notifier<FirmwareUpdateState> {
  StreamSubscription? _sub;

  @override
  FirmwareUpdateState build() {
    final fwUpdateSettingsRaw = ref.watch(pollingProvider.select<JNAPResult?>(
        (value) => value.value?.data[GetFirmwareUpdateSettings.instance]));
    final nodesFwUpdateCheckRaw = ref.watch(pollingProvider.select(
        (value) => value.value?.data[NodeGetFirmwareUpdateStatus.instance]));

    FirmwareUpdateSettings? fwUpdateSettings;
    if (fwUpdateSettingsRaw is JNAPSuccess) {
      fwUpdateSettings =
          FirmwareUpdateSettings.fromMap(fwUpdateSettingsRaw.output);
    }

    List<FirmwareUpdateStatus>? resultStatusList =
        nodesFwUpdateCheckRaw is JNAPSuccess
            ? List.from(nodesFwUpdateCheckRaw.output['firmwareUpdateStatus'])
                .map((e) => NodesFirmwareUpdateStatus.fromMap(e))
                .toList()
            : [];
    final fwUpdateStatusRecord = _examineStatusResult(resultStatusList);

    final state = FirmwareUpdateState(
      settings: fwUpdateSettings ??
          FirmwareUpdateSettings(
            updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
            autoUpdateWindow: FirmwareAutoUpdateWindow.simple(),
          ),
      nodesStatus: fwUpdateStatusRecord.$1,
      isWaitingChildrenAfterUpdating: fwUpdateStatusRecord.$2,
    );
    logger.d('[FIRMWARE]: Build: state = ${state.toJson()}');
    return state;
  }

  Future<void> setFirmwareUpdatePolicy(String policy) {
    final newSettings = state.settings.copyWith(updatePolicy: policy);
    return Jnap.instance
        .send(
      action: SetFirmwareUpdateSettings.instance,
      data: newSettings.toMap(),
      overrides: JNAPConfigOverrides(cached: false),
    )
        .then((_) async {
      await Jnap.instance.send(action: GetFirmwareUpdateSettings.instance, overrides: JNAPConfigOverrides(forceRemote: true),);
    }).then((_) {
      state = state.copyWith(settings: newSettings);
    });
  }

  Future fetchAvailableFirmwareUpdates() {
    logger.i('[FIRMWARE]: Examine if there are firmware updates available');
    final benchmark = BenchMarkLogger(name: 'FirmwareUpdate');
    benchmark.start();
    return fetchFirmwareUpdateStream(force: true, retry: 2)
        .last
        .onError((error, stackTrace) => [])
        .then((resultList) {
      benchmark.end();
      // In addition to the build function, state updates here should also be examined
      final statusRecord = _examineStatusResult(resultList);
      logger.d(
          '[FIRMWARE]: Fetch available firmware updates: saved status list = $statusRecord');
      state = state.copyWith(
        nodesStatus: statusRecord.$1,
        isWaitingChildrenAfterUpdating: statusRecord.$2,
      );
    });
  }

  Stream<List<FirmwareUpdateStatus>> fetchFirmwareUpdateStream(
      {bool force = false, int retry = 3}) async* {
    final lastCheckTime =
        (state.nodesStatus?.map((e) => e.lastSuccessfulCheckTime).toList() ??
                    [])
                .map((e) => DateTime.tryParse(e))
                .map((e) => e?.millisecondsSinceEpoch ?? 0)
                .maxOrNull ??
            0;
    if (!_isNeedDoFetch(lastCheckTime: lastCheckTime) && !force) {
      logger.i(
          '[FIRMWARE]: Skip checking firmware update avaliable: last check time {${DateTime.fromMillisecondsSinceEpoch(lastCheckTime)}}');
      yield [];
    } else {
      await Jnap.instance
          .send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': true},
            overrides: JNAPConfigOverrides(retries: 0, cached: false, forceRemote: true,),
          )
          .then((_) {});
      yield* _startCheckFirmwareUpdateStatus(
          retryTimes: retry, onCompleted: (result, error) {});
    }
  }

  Future updateFirmware() async {
    logger.i('[FIRMWARE]: Update firmware: Start');
    final benchmark = BenchMarkLogger(name: 'FirmwareUpdate');
    benchmark.start();
    state = state.copyWith(isUpdating: true);
    // Save the current status list
    // Note: Before the update process, the nodes should not be null
    final statusRecords = state.nodesStatus ?? [];
    ref.read(firmwareUpdateCandidateProvider.notifier).state = statusRecords;
    logger.d('[FIRMWARE]: Saved current status records: $statusRecords');
    
    await Jnap.instance.send(
      action: NodeUpdateFirmwareNow.instance,
      data: {'onlyCheck': false},
      overrides: JNAPConfigOverrides(cached: false, forceRemote: true,),
    );
    _sub?.cancel();
    ref.read(pollingProvider.notifier).stopPolling();
    _sub = _startCheckFirmwareUpdateStatus(
      retryTimes: 60 * getAvailableUpdateNumber(),
      stopCondition: (result) =>
          _checkFirmwareUpdateComplete(result, state.nodesStatus ?? []),
      onCompleted: (result, error) {
        final hasExceededMaxRetry = result is MaxRetriesExceededException;
        state = state.copyWith(isRetryMaxReached: hasExceededMaxRetry);
        if (hasExceededMaxRetry) {
          logger.e(
              '[FIRMWARE]: Firmware update halts due to exceeding the maximum retry limit');
          // If the client does not reconnect to the router, the requests will continue to fail up to the maximum limit
          // Update ended with exception
          state = state.copyWith(isUpdating: false);
          _sub?.cancel();
          benchmark.end();
        } else {
          logger.i('[FIRMWARE]: Firmware update: Done!');
          finishFirmwareUpdate().then((_) {
            _sub?.cancel();
            benchmark.end();
          });
        }
      },
    ).listen((statusList) {
      // The updated list here will be continuously rendered on different screens
      // No need to examine the node status number
      state = state.copyWith(nodesStatus: statusList);
    });
  }

  Future finishFirmwareUpdate() {
    final polling = ref.read(pollingProvider.notifier);
    return polling
        .forcePolling()
        .then((_) => fetchAvailableFirmwareUpdates())
        .then((_) {
      state = state.copyWith(isUpdating: false);
      //TODO: Removed SharedPreferences in JNAP repo, need to implement in PrivacyGUI
      // SharedPreferences.getInstance().then((pref) {
      //   pref.setBool(pFWUpdated, true);
      // });

      polling.startPolling();
    });
  }

  bool _checkFirmwareUpdateComplete(
    JNAPResult result,
    List<FirmwareUpdateStatus> records,
  ) {
    if (result is JNAPSuccess) {
      final statusList = List.from(result.output['firmwareUpdateStatus'])
          .map((e) => NodesFirmwareUpdateStatus.fromMap(e))
          .toList();
      final isDone =
          !statusList.any((status) => status.pendingOperation != null);
      logger.i('[FIRMWARE]: Check if all updates are finished: $isDone');
      return isDone;
    } else {
      logger.e('[FIRMWARE]: Error: $result - Maybe rebooting');
      return false;
    }
  }

/* TODO: Modify all callers
  // Get records of nodes' update status and their device IDs
  List<(String, FirmwareUpdateStatus)> getIDStatusRecords() {
    return (state.nodesStatus ?? []).map((nodeStatus) {
      final nodes = ref.read(deviceManagerProvider).nodeDevices;
      LinksysDevice? node;
      try {
        node = nodeStatus is NodesFirmwareUpdateStatus
            ? nodes.firstWhere((node) => node.deviceID == nodeStatus.deviceUUID)
            : ref.read(deviceManagerProvider).masterDevice;
      } catch (error) {
        // If the node is not found, use null to indicate that the node is not found
        // Note: This may happen in Pinnacle's CF production firmware
        logger.e('[FIRMWARE]: Error finding corresponding node: $error');
        node = null;
      }
      return (node, nodeStatus);
    }).toList();
  }
  */

  int getAvailableUpdateNumber() {
    return (state.nodesStatus ?? [])
        .where((e) => e.availableUpdate != null)
        .length;
  }

  bool isFailedCheckFirmwareUpdate() {
    return state.nodesStatus?.any((e) => e.lastOperationFailure != null) ??
        false;
  }

  (List<FirmwareUpdateStatus>, bool) _examineStatusResult(
      List<FirmwareUpdateStatus> resultList) {
    // After fw updating and router restarting, the child nodes will be offline for a while
    // During this period, the polling will only obtain the status of the master node
    // In order to maintain the integrity of the list on the page, the status list should not be overwritten in state
    final cachedCandidates = ref.read(firmwareUpdateCandidateProvider);
    if (cachedCandidates != null) {
      // Get the list of status objects from the cached candidates
      if (_isRecordConsistent(resultList, cachedCandidates)) {
        logger.d('[FIRMWARE]: Fetched status is correct - nodes have resumed');
        return (resultList, false);
      } else {
        logger.d('[FIRMWARE]: Fetched status mismatch! - show the cached list');
        // These cached nodes used to temporarily display nodes after updating
        // need to clear availableUpdate to indicate that these nodes have been updated
        final updatedCachedList = cachedCandidates.map((e) {
          return e.copyWith(availableUpdate: () => null);
        }).toList();
        return (updatedCachedList, true);
      }
    }
    // Initial state - no updates in progress
    logger.d('[FIRMWARE]: No cached node status list');
    return (resultList, false);
  }



  ///
  /// Check all nodes connect back
  ///
  @visibleForTesting
  bool isRecordConsistent(
    List<FirmwareUpdateStatus> list,
    List<FirmwareUpdateStatus> records,
  ) =>
      _isRecordConsistent(list, records);

  bool _isRecordConsistent(
    List<FirmwareUpdateStatus> list,
    List<FirmwareUpdateStatus> records,
  ) {
    checkExist(FirmwareUpdateStatus status) {
      if (status is NodesFirmwareUpdateStatus) {
        return list
            .map((e) => e as NodesFirmwareUpdateStatus)
            .map((e) => e.deviceUUID)
            .contains(status.deviceUUID);
      } else {
        return list.length == 1;
      }
    }

    return records.fold<bool>(
        true, (value, element) => value & checkExist(element));
  }

  Stream<List<FirmwareUpdateStatus>> _startCheckFirmwareUpdateStatus({
    int? retryTimes = 1,
    int? retryDelayInMilliSec,
    bool Function(JNAPResult)? stopCondition,
    Function(JNAPResult?, Object?)? onCompleted,
  }) {
    return Jnap.instance.scheduled(action: NodeGetFirmwareUpdateStatus.instance,
    maxRetry: retryTimes ?? -1,
    retryDelayInMilliSec: retryDelayInMilliSec ?? 2000,
    condition: stopCondition,
    onComplete: onCompleted,
    requestTimeoutOverride: 3000,
    ).map((result) {
      if (result is! JNAPSuccess) {
        throw result;
      }
      return List.from(result.output['firmwareUpdateStatus'])
          .map((e) => NodesFirmwareUpdateStatus.fromMap(e))
          .toList();
    });
  }

  bool _isNeedDoFetch({required int lastCheckTime}) {
    final period = Duration(minutes: 5).inMilliseconds;
    return (DateTime.now().millisecondsSinceEpoch - lastCheckTime) >= period;
  }

  Future<bool> manualFirmwareUpdate(String filename, List<int> bytes, String localPwd) async {
    final client = HttpClient()
      ..timeoutMs = 300000
      ..retries = 0;
    //TODO: Have changed the way to get the local password
    // final localPwd = ref.read(authProvider).value?.localPassword ??
    //     await const FlutterSecureStorage().read(key: pLocalPassword) ??
    //     '';
    final multiPart = MultipartFile.fromBytes(
      'upload',
      bytes,
      filename: filename,
      contentType: MediaType('application', 'octet-stream'),
    );
    final log = BenchMarkLogger(name: 'Manual FW update');
    log.start();
    await ref.read(pollingProvider.notifier).stopPolling();
    return client.upload(Uri.parse('https://${getLocalIp(ref)}/jcgi/'), [
      multiPart,
    ], fields: {
      kJNAPAction: 'updatefirmware',
      kJNAPAuthorization: 'Basic ${('admin:$localPwd').base64Encode()}'
    }).then((response) {
      final result = (response.body.base64Decode() as Map<String, dynamic>)['result'];
      log.end();
      if (result == 'OK') {
        return true;
      }
      // error
      final error = response.headers['X-Jcgi-Result'];
      throw ManualFirmwareUpdateException(error);
    }).onError((error, stackTrace) {
      log.end();
      if (error is ErrorResponse && error.code == '500') {
        return true;
      }
      logger.e('[FIRMWARE]: Manual firmware update: Error: $error');
      throw ManualFirmwareUpdateException('UnknownError');
    });
  }

  Future waitForRouterBackOnline() {
    return ref
        .read(sideEffectProvider.notifier)
        .manualDeviceRestart()
        .whenComplete(() {
      ref.read(pollingProvider.notifier).startPolling();
    });
  }
}

class ManualFirmwareUpdateException implements Exception {
  final String? result;
  ManualFirmwareUpdateException(this.result);
}

// This provider is used to save the original list of all their fw status
// when the firmware update right started
final firmwareUpdateCandidateProvider =
    StateProvider<List<FirmwareUpdateStatus>?>((ref) {
  return null;
});
