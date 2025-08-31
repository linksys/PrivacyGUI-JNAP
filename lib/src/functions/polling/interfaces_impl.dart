import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:riverpod/riverpod.dart';

class PollingConfigImpl extends PollingConfig {
  PollingConfigImpl({
    super.refreshInterval = const Duration(seconds: 60),
    super.pollFirstDelayInSec = 1,
    super.isPaused = false,
  });

  @override
  PollingConfig copyWith({
    Duration? refreshInterval,
    int? pollFirstDelayInSec,
    bool? isPaused,
  }) {
    return PollingConfigImpl(
      refreshInterval: refreshInterval ?? this.refreshInterval,
      pollFirstDelayInSec: pollFirstDelayInSec ?? this.pollFirstDelayInSec,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

class PollingCacheManagerImpl implements PollingCacheManager {
  @override
  Map<String, dynamic> fetchCacheData() {
    return DataCacheManager().data;
  }
}

class PollingAdditionalTasksImpl implements PollingAdditionalTasks {
  final Ref _ref;
  PollingAdditionalTasksImpl(this._ref);

  @override
  Future<void> additionalPolling() async {
    logger.d('additional polling');
  }
}

class PollingCompletedNotifierImpl implements PollingCompletedNotifier {
  @override
  void onPollingFailed() {
    logger.d('polling failed');
  }

  @override
  void onPollingSuccess() {
    logger.d('polling success');
  }
}
