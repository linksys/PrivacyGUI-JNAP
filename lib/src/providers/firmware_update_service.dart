import 'package:jnap/jnap.dart';

class FirmwareUpdateService {
  final Jnap _jnap;
  FirmwareUpdateService(this._jnap);

  Future<void> updateFirmwareUpdateSettings(Map<String, dynamic> data) {
    return _jnap
        .send(
      action: SetFirmwareUpdateSettings.instance,
      data: data,
      overrides: JNAPConfigOverrides(cached: false),
    )
        .then((_) async {
      await _jnap.send(
        action: GetFirmwareUpdateSettings.instance,
        overrides: JNAPConfigOverrides(forceRemote: true),
      );
    });
  }

  Future<JNAPResult> checkAvailableFirmwareUpdates() async {
    return await _jnap.send(
      action: NodeUpdateFirmwareNow.instance,
      data: {'onlyCheck': true},
      overrides: JNAPConfigOverrides(
        retries: 0,
        cached: false,
        forceRemote: true,
      ),
    );
  }

  Stream<JNAPResult> scheduleCheckFirmwareUpdateStatus({
    int? retryTimes,
    int? retryDelayInMilliSec,
    bool Function(JNAPResult)? stopCondition,
    Function(JNAPResult?, Object?)? onCompleted,
  }) async* {
    yield* _jnap.scheduled(
      action: NodeGetFirmwareUpdateStatus.instance,
      maxRetry: retryTimes ?? -1,
      retryDelayInMilliSec: retryDelayInMilliSec ?? 2000,
      condition: stopCondition,
      onComplete: onCompleted,
      requestTimeoutOverride: 3000,
    );
  }

  Future<JNAPResult> updateFirmwareNow() async {
    return await _jnap.send(
      action: NodeUpdateFirmwareNow.instance,
      data: {'onlyCheck': false},
      overrides: JNAPConfigOverrides(
        retries: 0,
        cached: false,
        forceRemote: true,
      ),
    );
  }
}