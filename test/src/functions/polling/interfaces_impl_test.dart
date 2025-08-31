import 'package:jnap/src/functions/polling/interfaces_impl.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

void main() {
  group('PollingConfigImpl', () {
    test('default values', () {
      final config = PollingConfigImpl();
      expect(config.refreshInterval, const Duration(seconds: 60));
      expect(config.pollFirstDelayInSec, 1);
      expect(config.isPaused, false);
    });

    test('copyWith returns a new instance with updated values', () {
      final config = PollingConfigImpl();
      final newConfig = config.copyWith(
        refreshInterval: const Duration(seconds: 30),
        pollFirstDelayInSec: 5,
        isPaused: true,
      );
      expect(newConfig.refreshInterval, const Duration(seconds: 30));
      expect(newConfig.pollFirstDelayInSec, 5);
      expect(newConfig.isPaused, true);

      final newConfig2 = config.copyWith();
      expect(newConfig2.refreshInterval, config.refreshInterval);
      expect(newConfig2.pollFirstDelayInSec, config.pollFirstDelayInSec);
      expect(newConfig2.isPaused, config.isPaused);
    });
  });

  group('PollingCacheManagerImpl', () {
    test('fetchCacheData returns normally', () {
      final manager = PollingCacheManagerImpl();
      // This is hard to test without a real DataCacheManager instance.
      // We just check if it runs without error.
      expect(() => manager.fetchCacheData(), returnsNormally);
    });
  });

  group('PollingAdditionalTasksImpl', () {
    test('additionalPolling completes', () async {
      final container = ProviderContainer();
      final ref = container.read(Provider((ref) => ref));
      final tasks = PollingAdditionalTasksImpl(ref);
      await expectLater(tasks.additionalPolling(), completes);
    });
  });

  group('PollingCompletedNotifierImpl', () {
    test('onPollingFailed runs without error', () {
      final notifier = PollingCompletedNotifierImpl();
      expect(() => notifier.onPollingFailed(), returnsNormally);
    });

    test('onPollingSuccess runs without error', () {
      final notifier = PollingCompletedNotifierImpl();
      expect(() => notifier.onPollingSuccess(), returnsNormally);
    });
  });
}
