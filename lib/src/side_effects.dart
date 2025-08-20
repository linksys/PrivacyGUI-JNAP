import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';

class SideEffectMaxRetryException implements Exception {
  final Object? attached;
  final Object? lastResult;
  final String message;

  SideEffectMaxRetryException(this.lastResult, {this.attached})
      : message = 'Exceed to MAX retry! last result: $lastResult';
}

class SideEffectHandler {
  final String? cachedSerialNumber;
  late final int startTime;

  SideEffectHandler({this.cachedSerialNumber}) {
    startTime = DateTime.now().millisecondsSinceEpoch;
  }

  Future<bool> pollForRouterReconnected() {
    return poll(
      pollFunc: testRouterReconnected,
      maxRetry: 10,
      timeDelayStartInSec: 10,
      retryDelayInSec: 10,
      maxPollTimeInSec: 120,
    );
  }

  Future<bool> pollForRouterFullyBootedUp() {
    return poll(
      pollFunc: testRouterFullyBootedUp,
      maxRetry: 10,
      timeDelayStartInSec: 10,
      retryDelayInSec: 10,
      maxPollTimeInSec: 120,
    );
  }

  Future<bool> poll({
    required Future<bool> Function() pollFunc,
    int retryDelayInSec = 5,
    int maxRetry = -1,
    int maxPollTimeInSec = -1,
    int timeDelayStartInSec = 3,
  }) async {
    // Log poll config
    logger.d('''[SideEffect] Start Poll with config:
        retry delay: $retryDelayInSec,
        max retry: $maxRetry,
        max poll time: $maxPollTimeInSec,
        start time delay: $timeDelayStartInSec,
        ''');
    if (timeDelayStartInSec > 0) {
      await Future.delayed(Duration(seconds: timeDelayStartInSec));
    }
    var result = false;
    final strategy = FixedRetryStrategy(
      maxRetries: maxRetry,
      initialDelay: Duration(seconds: retryDelayInSec),
      maxExecutionTime:
          maxPollTimeInSec == -1 ? null : Duration(seconds: maxPollTimeInSec),
    );

    result = await strategy
        .execute(
      () => pollFunc.call().onError((error, stackTrace) => false),
      shouldRetry: (result) => !result,
      onRetry: (retryAttempt) {
        logger.d('[SideEffect] retry <${retryAttempt + 1}> times');
      },
    )
        .catchError((error) {
      logger.e('[SideEffect] exceed to MAX retry! error: $error');
      throw SideEffectMaxRetryException(error.lastResult);
    }, test: (error) => error is MaxRetriesExceededException);
    return result;
  }

  Future<bool> testRouterReconnected() async {
    return Jnap.instance
        .send(
          action: GetDeviceInfo.instance,
          data: {},
          overrides: JNAPConfigOverrides(timeoutMs: 5000, retries: 0),
        )
        .then(
          (devceInfo) => devceInfo.output['serialNumber'] == cachedSerialNumber,
        )
        .then(
          (value) async => (value ? await testRouterFullyBootedUp() : false),
        )
        .onError((error, stackTrace) => false);
  }

  Future<bool> testRouterFullyBootedUp() async {
    return Jnap.instance
        .send(
      action: GetWANStatus.instance,
      data: {},
      overrides: JNAPConfigOverrides(timeoutMs: 5000, retries: 0),
    )
        .then((status) {
      final wanConnected = status.output['wanStatus'] == 'Connected' ||
          status.output['wanIPv6Status'] == 'Connected';
      final isRouterRespondingLongEnough =
          DateTime.now().millisecondsSinceEpoch > startTime + 20 * 1000;
      logger.d(
        '[SideEffect] wanConnected: $wanConnected, isRouterRespondingLongEnough: $isRouterRespondingLongEnough',
      );
      logger.d(
        '[SideEffect] start time: ${startTime + 20 * 1000}, current time: ${DateTime.now().millisecondsSinceEpoch}',
      );
      return wanConnected && isRouterRespondingLongEnough;
    }).onError((error, stackTrace) => false);
  }
}
