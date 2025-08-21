import 'package:test/test.dart';
import 'package:jnap/src/utilties/logger/logger.dart';
import 'package:logger/logger.dart';

void main() {
  group('LoggerHooks', () {
    // Clear hooks before each test to ensure isolation
    setUp(() {
      LoggerHooks.clearHooks();
    });

    test('addHook adds a hook to the list', () {
      void testHook(OutputEvent event) {}
      LoggerHooks.addHook(testHook);
      expect(LoggerHooks.hooks, contains(testHook));
    });

    test('removeHook removes a hook from the list', () {
      void testHook(OutputEvent event) {}
      LoggerHooks.addHook(testHook);
      LoggerHooks.removeHook(testHook);
      expect(LoggerHooks.hooks, isNot(contains(testHook)));
    });

    test('addHook adds multiple hooks', () {
      void testHook1(OutputEvent event) {}
      void testHook2(OutputEvent event) {}
      LoggerHooks.addHook(testHook1);
      LoggerHooks.addHook(testHook2);
      expect(LoggerHooks.hooks, containsAll([testHook1, testHook2]));
    });

    test('removeHook handles non-existent hook gracefully', () {
      void testHook(OutputEvent event) {}
      void nonExistentHook(OutputEvent event) {}
      LoggerHooks.addHook(testHook);
      LoggerHooks.removeHook(nonExistentHook);
      expect(LoggerHooks.hooks, contains(testHook)); // Should still contain the original hook
      expect(LoggerHooks.hooks.length, 1);
    });
  });

  group('AppLogger', () {
    test('AppLogger is a singleton', () {
      final instance1 = AppLogger.instance;
      final instance2 = AppLogger.instance;
      expect(instance1, same(instance2));
    });

    test('logger getter returns a Logger instance', () {
      final appLogger = AppLogger.instance;
      expect(appLogger.logger, isA<Logger>());
    });

    test('logger instance is configured correctly', () {
      final appLogger = AppLogger.instance;
      final logger = appLogger.logger;

      // These properties are private in Logger, so direct testing is hard.
      // We can only infer configuration from behavior or public API if available.
      // For now, just check if it's a Logger instance.
      expect(logger, isA<Logger>());
    });
  });
}
