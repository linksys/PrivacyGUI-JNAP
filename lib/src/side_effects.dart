import 'package:equatable/equatable.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:meta/meta.dart';

class JNAPSideEffectOverrides extends Equatable {
  final int? retryDelayInSec;
  final int? maxRetry;
  final int? maxPollTimeInSec;
  final int? timeDelayStartInSec;
  final bool Function()? beforeHandle;
  final bool Function()? afterHandle;
  const JNAPSideEffectOverrides({
    this.retryDelayInSec,
    this.maxRetry,
    this.maxPollTimeInSec,
    this.timeDelayStartInSec,
    this.beforeHandle,
    this.afterHandle,
  });

  JNAPSideEffectOverrides copyWith({
    int? retryDelayInSec,
    int? maxRetry,
    int? maxPollTimeInSec,
    int? timeDelayStartInSec,
    bool Function()? beforeHandle,
    bool Function()? afterHandle,
  }) {
    return JNAPSideEffectOverrides(
      retryDelayInSec: retryDelayInSec ?? this.retryDelayInSec,
      maxRetry: maxRetry ?? this.maxRetry,
      maxPollTimeInSec: maxPollTimeInSec ?? this.maxPollTimeInSec,
      timeDelayStartInSec: timeDelayStartInSec ?? this.timeDelayStartInSec,
      beforeHandle: beforeHandle ?? this.beforeHandle,
      afterHandle: afterHandle ?? this.afterHandle,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        retryDelayInSec,
        maxRetry,
        maxPollTimeInSec,
        timeDelayStartInSec,
        beforeHandle,
        afterHandle,
      ];
}

class SideEffectMaxRetryException implements Exception {
  final Object? attached;
  final Object? lastResult;
  final String message;

  SideEffectMaxRetryException(this.lastResult, {this.attached})
      : message = 'Exceed to MAX retry! last result: $lastResult';
}

class _PollConfig {
  final Future<bool> Function() pollFunc;
  final int defaultMaxRetry;
  final int defaultTimeDelayStartInSec;
  final int defaultRetryDelayInSec;
  final int defaultMaxPollTimeInSec;

  const _PollConfig({
    required this.pollFunc,
    required this.defaultMaxRetry,
    required this.defaultTimeDelayStartInSec,
    required this.defaultRetryDelayInSec,
    required this.defaultMaxPollTimeInSec,
  });
}

class SideEffectHandler {
  final String? cachedSerialNumber;
  late final int startTime;
  final Jnap _jnap;
  int Function()? timeGetter;

  late final Map<String, _PollConfig> _configs;
  late final _PollConfig _defaultConfig;

  SideEffectHandler({
    String? cachedSerialNumber,
    Jnap? jnap,
    this.timeGetter,
  })  : _jnap = jnap ?? Jnap.instance,
        this.cachedSerialNumber =
            cachedSerialNumber ?? DataCacheManager().lastSerialNumber {
    startTime = DateTime.now().millisecondsSinceEpoch;

    _configs = <String, _PollConfig>{
      'DeviceRestart': _PollConfig(
        pollFunc: testRouterReconnected,
        defaultMaxRetry: -1,
        defaultTimeDelayStartInSec: 20,
        defaultRetryDelayInSec: 10,
        defaultMaxPollTimeInSec: 240,
      ),
      'WirelessInterruption': _PollConfig(
        pollFunc: testRouterReconnected,
        defaultMaxRetry: -1,
        defaultTimeDelayStartInSec: 20,
        defaultRetryDelayInSec: 10,
        defaultMaxPollTimeInSec: 120,
      ),
    };

    _defaultConfig = _PollConfig(
      pollFunc: testRouterFullyBootedUp,
      defaultMaxRetry: 10,
      defaultTimeDelayStartInSec: 20,
      defaultRetryDelayInSec: 15,
      defaultMaxPollTimeInSec: -1,
    );
  }

  @visibleForTesting
  void setTimeGetter(int Function() getter) {
    timeGetter = getter;
  }

  Future<JNAPResult> handleSideEffect(
    JNAPResult result, {
    JNAPSideEffectOverrides? overrides,
  }) async {
    if (result is! SideEffectGetter) return result;

    try {
      final sideEffects = (result as SideEffectGetter).getSideEffects() ?? [];
      if (sideEffects.isEmpty) {
        logger.d('[SideEffect] No side effect need to be handled');
        return result;
      }
      logger.d('[SideEffect] handleSideEffect: $result');
      overrides?.beforeHandle?.call();

      final config = sideEffects
          .map((effect) => _configs[effect])
          .firstWhere((config) => config != null, orElse: () => _defaultConfig)!;

      await poll(
        pollFunc: config.pollFunc,
        maxRetry: overrides?.maxRetry ?? config.defaultMaxRetry,
        timeDelayStartInSec:
            overrides?.timeDelayStartInSec ?? config.defaultTimeDelayStartInSec,
        retryDelayInSec:
            overrides?.retryDelayInSec ?? config.defaultRetryDelayInSec,
        maxPollTimeInSec:
            overrides?.maxPollTimeInSec ?? config.defaultMaxPollTimeInSec,
      );
      return result;
    } on MaxRetriesExceededException catch (e) {
      throw _wrapMaxRetriesExceededException(result, e);
    } finally {
      overrides?.afterHandle?.call();
    }
  }

  SideEffectMaxRetryException _wrapMaxRetriesExceededException(
      JNAPResult result, MaxRetriesExceededException exception) {
    return SideEffectMaxRetryException(exception.lastResult, attached: result);
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
    final strategy = FixedRetryStrategy(
      maxRetries: maxRetry,
      initialDelay: Duration(seconds: retryDelayInSec),
      maxExecutionTime:
          maxPollTimeInSec == -1 ? null : Duration(seconds: maxPollTimeInSec),
    );

    final result = await strategy.execute(
      () => pollFunc.call().onError((error, stackTrace) => false),
      shouldRetry: (result) => !result,
      onRetry: (retryAttempt) {
        logger.d('[SideEffect] retry <${retryAttempt + 1}> times');
      },
    );
    return result;
  }

  Future<bool> testRouterReconnected() async {
    try {
      final devceInfo = await _jnap.send(
        action: GetDeviceInfo.instance,
        data: {},
        overrides: JNAPConfigOverrides(timeoutMs: 5000, retries: 0),
      );
      if (devceInfo.output['serialNumber'] != cachedSerialNumber) {
        return false;
      }
      return await testRouterFullyBootedUp();
    } catch (e) {
      return false;
    }
  }

  Future<bool> testRouterFullyBootedUp() async {
    try {
      final status = await _jnap.send(
        action: GetWANStatus.instance,
        data: {},
        overrides: JNAPConfigOverrides(timeoutMs: 5000, retries: 0),
      );
      final wanConnected = status.output['wanStatus'] == 'Connected' ||
          status.output['wanIPv6Status'] == 'Connected';
      final isRouterRespondingLongEnough =
          (timeGetter?.call() ?? DateTime.now().millisecondsSinceEpoch) >
              startTime + 20 * 1000;
      logger.d(
        '[SideEffect] wanConnected: $wanConnected, isRouterRespondingLongEnough: $isRouterRespondingLongEnough',
      );
      logger.d(
        '[SideEffect] start time: ${startTime + 20 * 1000}, current time: ${timeGetter?.call() ?? DateTime.now().millisecondsSinceEpoch}',
      );
      return wanConnected && isRouterRespondingLongEnough;
    } catch (e) {
      return false;
    }
  }
}