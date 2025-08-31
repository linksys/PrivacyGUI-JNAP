abstract class PollingConfig {
  Duration refreshInterval;
  int pollFirstDelayInSec;
  bool isPaused;

  PollingConfig({
    required this.refreshInterval,
    required this.pollFirstDelayInSec,
    required this.isPaused,
  });

  PollingConfig copyWith({
    Duration? refreshInterval,
    int? pollFirstDelayInSec,
    bool? isPaused,
  });
}

abstract class PollingCacheManager {
  Map<String, dynamic> fetchCacheData();
}

abstract class PollingAdditionalTasks {
  Future<void> additionalPolling();
}

abstract class PollingCompletedNotifier {
  void onPollingFailed();
  void onPollingSuccess();
}
