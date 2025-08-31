import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/interfaces_impl.dart';
import 'package:jnap/src/functions/polling/polling_service.dart';
import 'package:jnap/src/utilties/bench_mark.dart';
import 'package:riverpod/riverpod.dart';

final pollingConfigProvider =
    Provider<PollingConfig>((ref) => PollingConfigImpl());
final cacheManagerProvider =
    Provider<PollingCacheManager>((ref) => PollingCacheManagerImpl());
final additionalTasksProvider =
    Provider<PollingAdditionalTasks>((ref) => PollingAdditionalTasksImpl(ref));
final completedNotifierProvider =
    Provider<PollingCompletedNotifier>((ref) => PollingCompletedNotifierImpl());

final pollingProvider =
    AsyncNotifierProvider<PollingNotifier, CoreTransactionData>(
        () => PollingNotifier());

class CoreTransactionData extends Equatable {
  final int lastUpdate;
  final bool isReady;
  final Map<JNAPAction, JNAPResult> data;

  const CoreTransactionData({
    required this.lastUpdate,
    required this.isReady,
    required this.data,
  });

  @override
  List<Object> get props => [lastUpdate, isReady, data];

  CoreTransactionData copyWith({
    int? lastUpdate,
    bool? isReady,
    Map<JNAPAction, JNAPResult>? data,
  }) {
    return CoreTransactionData(
      lastUpdate: lastUpdate ?? this.lastUpdate,
      isReady: isReady ?? this.isReady,
      data: data ?? this.data,
    );
  }
}

class PollingNotifier extends AsyncNotifier<CoreTransactionData> {
  static Timer? _timer;
  late final PollingService _pollingService;

  @override
  FutureOr<CoreTransactionData> build() {
    return const CoreTransactionData(lastUpdate: 0, isReady: false, data: {});
  }

  init() {
    state = AsyncValue.data(
        const CoreTransactionData(lastUpdate: 0, isReady: false, data: {}));
  }

  startPolling() async {
    if (ref.read(pollingConfigProvider).isPaused) {
      return;
    }
    logger.d('[Polling]: prepare start polling data');
    PollingService.checkSmartMode()
        .then((mode) {
          _pollingService = PollingService(
              pollingTransactions:
                  PollingService.buildCoreTransaction(mode: mode));
          fetchFirstLaunchedCacheData();
        })
        .then(
          (value) => Future.delayed(
              Duration(
                  seconds: ref.read(pollingConfigProvider).pollFirstDelayInSec),
              () {
            _polling();
          }).then(
            (_) {
              _setTimePeriod();
            },
          ),
        )
        .onError((error, stackTrace) {
          logger.e(
              '[Polling]: Check Smart Mode failed, Error: $error, $stackTrace');
          throw error ?? '';
        });
  }

  stopPolling() {
    logger.d('[Polling]: stop polling data');
    if ((_timer?.isActive ?? false)) {
      _timer?.cancel();
    }
  }

  void checkAndStartPolling([bool force = false]) {
    final hasAuth = Config.auth.isNotEmpty;
    if (!hasAuth) {
      return;
    }
    if (!force && (_timer?.isActive ?? false)) {
      return;
    } else {
      stopPolling();
      startPolling();
    }
  }

  Future forcePolling() {
    return _polling(force: true).then((_) => _setTimePeriod());
  }

  _setTimePeriod() {
    _timer?.cancel();
    _timer = Timer.periodic(ref.read(pollingConfigProvider).refreshInterval,
        (timer) {
      _polling();
    });
  }

  fetchFirstLaunchedCacheData() {
    final previousSnapshot = state.value;
    state = AsyncValue.data(CoreTransactionData(
      lastUpdate: 0,
      isReady: previousSnapshot?.isReady ?? false,
      data: _pollingService.fetchCacheData() ?? {},
    ));
  }

  Future _polling({bool force = false}) async {
    final benchMark = BenchMarkLogger(name: 'Polling provider');
    benchMark.start();
    final previousSnapshot = state.value;
    state = const AsyncValue.loading();
    final fetchFuture = _pollingService
        .doPolling(force: force)
        .then((successWrap) => successWrap.data)
        .then((data) => CoreTransactionData(
              lastUpdate: DateTime.now().millisecondsSinceEpoch,
              isReady: previousSnapshot?.isReady ?? false,
              data: Map.fromEntries(data),
            ))
        .onError((error, stackTrace) {
      logger.e('[Polling]: Error: $error, $stackTrace');
      logger.f('[Polling]: Polling failed');
      ref.read(completedNotifierProvider).onPollingFailed();

      throw error ?? '';
    });

    state = await AsyncValue.guard(
      () => fetchFuture.then(
        (result) async {
          await _additionalPolling();
          return result.copyWith(isReady: true);
        },
      ).onError((e, stackTrace) {
        logger.e('[Polling]: Error: $e, $stackTrace');
        throw e ?? '';
      }),
    );

    benchMark.end();
  }

  Future _additionalPolling() async {
    await ref.read(additionalTasksProvider).additionalPolling();
  }
}
