import 'dart:async';

import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:riverpod/riverpod.dart';

class PollingService {
  final Ref _ref;
  late final List<MapEntry<JNAPAction, Map<String, dynamic>>>
      pollingTransactions;
  final Jnap _jnap;

  PollingService(this._ref,
      {Jnap? jnap,
      List<MapEntry<JNAPAction, Map<String, dynamic>>>? pollingTransactions})
      : _jnap = jnap ?? Jnap.instance,
        pollingTransactions =
            pollingTransactions ?? PollingService.buildCoreTransaction();

  Map<JNAPAction, JNAPSuccess>? fetchCacheData() {
    final cache = _ref.read(cacheManagerProvider).fetchCacheData();
    final commands = pollingTransactions;
    final checkCacheDataList =
        commands.where((command) => cache.keys.contains(command.key.command));
    // Have not done any polling yet
    if (checkCacheDataList.length != commands.length) return null;

    final cacheDataList = checkCacheDataList
        .where((command) => cache[command.key.command]['data'] != null)
        .map((command) => MapEntry(command.key,
            JNAPSuccess.fromJson(cache[command.key.command]['data'])))
        .toList();
    return Map.fromEntries(cacheDataList);
  }

  Future<JNAPTransactionSuccessWrap> doPolling({bool force = false}) {
    return _jnap.transaction(
      transactionBuilder:
          JNAPTransactionBuilder(commands: pollingTransactions, auth: true),
      overrides: JNAPConfigOverrides(forceRemote: force),
    );
  }

  static Future<String> checkSmartMode({Jnap? jnap}) async {
    final jnapClient = jnap ?? Jnap.instance;
    return await jnapClient
        .send(
          action: GetDeviceMode.instance,
          overrides: JNAPConfigOverrides(forceRemote: true),
        )
        .then((value) => value.output['mode'] ?? 'Unconfigured');
  }

  static List<MapEntry<JNAPAction, Map<String, dynamic>>> buildCoreTransaction(
      {String? mode}) {
    List<MapEntry<JNAPAction, Map<String, dynamic>>> commands = [
      MapEntry(GetNodesWirelessNetworkConnections.instance, {}),
      MapEntry(GetNetworkConnections.instance, {}),
      MapEntry(GetRadioInfo.instance, {}),
      if (JNAPServiceList.isSupport('GuestNetwork'))
        MapEntry(GetGuestRadioSettings.instance, {}),
      MapEntry(GetDevices.instance, {}),
      MapEntry(GetFirmwareUpdateSettings.instance, {}),
      if ((mode ?? 'Unconfigured') == 'Master')
        MapEntry(GetBackhaulInfo.instance, {}),
      MapEntry(GetWANStatus.instance, {}),
      MapEntry(GetEthernetPortConnections.instance, {}),
      MapEntry(GetSystemStats.instance, {}),
      MapEntry(GetPowerTableSettings.instance, {}),
      MapEntry(GetLocalTime.instance, {}),
      MapEntry(GetDeviceInfo.instance, {}),
    ];
    if (JNAPServiceList.isSupport('Setup')) {
      commands.add(
        MapEntry(GetInternetConnectionStatus.instance, {}),
      );
    }
    if (JNAPServiceList.isSupport('HealthCheckManager')) {
      commands.add(MapEntry(GetHealthCheckResults.instance, {
        'includeModuleResults': true,
        "lastNumberOfResults": 5,
      }));
      commands.add(MapEntry(GetSupportedHealthCheckModules.instance, {}));
    }
    if (JNAPServiceList.isSupport('FirmwareUpdate')) {
      commands.add(
        MapEntry(NodeGetFirmwareUpdateStatus.instance, {}),
      );
    } else {
      commands.add(
        MapEntry(GetFirmwareUpdateStatus.instance, {}),
      );
    }
    if (JNAPServiceList.isSupport('Product')) {
      commands.add(MapEntry(GetSoftSKUSettings.instance, {}));
    }

    // For additional features
    if (JNAPServiceList.isSupport('LedMode')) {
      commands.add(MapEntry(GetLedNightModeSetting.instance, {}));
    }
    commands.add(MapEntry(GetMACFilterSettings.instance, {}));

    return commands;
  }
}
