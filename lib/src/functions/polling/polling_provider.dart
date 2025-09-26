import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/functions/polling/polling_service.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/utilties/bench_mark.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

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
  @visibleForTesting
  Timer? timer;
  late PollingService _pollingService;

  @override
  FutureOr<CoreTransactionData> build() {
    _pollingService = PollingService(ref, jnap: ref.read(jnapProvider));
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
    await _pollingService
        .checkSmartMode()
        .then((mode) {
          _pollingService.pollingTransactions =
              _pollingService.buildCoreTransaction(mode: mode);
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
              '[Polling]: Check Smart Mode failed, Error: $error, \n$stackTrace');
          throw error ?? '';
        });
  }

  stopPolling() {
    logger.d('[Polling]: stop polling data');
    if ((timer?.isActive ?? false)) {
      timer?.cancel();
    }
  }

  void checkAndStartPolling([bool force = false]) {
    final hasAuth = Config.auth.isNotEmpty;
    if (!hasAuth) {
      return;
    }
    if (!force && (timer?.isActive ?? false)) {
      return;
    } else {
      stopPolling();
      startPolling();
    }
  }

  Future forcePolling() async {
    return await _polling(force: true).then((_) => _setTimePeriod());
  }

  _setTimePeriod() {
    timer?.cancel();
    timer = Timer.periodic(ref.read(pollingConfigProvider).refreshInterval,
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
      ref.read(pollingCompletedNotifierProvider).onPollingFailed();

      throw error ?? '';
    });

    state = await AsyncValue.guard(
      () => fetchFuture.then(
        (result) async {
          await _additionalPolling();
          ref.read(pollingCompletedNotifierProvider).onPollingSuccess();
          return result.copyWith(isReady: true);
        },
      ).onError((e, stackTrace) {
        logger.e('[Polling]: Error: $e, \n$stackTrace');
        throw e ?? '';
      }),
    );

    benchMark.end();
  }

  Future _additionalPolling() async {
    await ref.read(pollingAdditionalTasksProvider).additionalPolling();
  }
}
