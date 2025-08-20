import 'package:test/test.dart';
import 'package:jnap/src/side_effects.dart';

// Mock for the poll function to simulate different scenarios
class MockPollFunction {
  int callCount = 0;
  final List<Future<bool> Function()> responses = [];

  Future<bool> call() async {
    if (callCount < responses.length) {
      return responses[callCount++]();
    }
    return false;
  }

  void whenCall(Future<bool> Function() response) {
    responses.add(response);
  }

  void reset() {
    callCount = 0;
    responses.clear();
  }
}

// Mock for the condition function
class MockConditionFunction {
  int callCount = 0;
  final List<bool> responses = [];

  bool call() {
    if (callCount < responses.length) {
      return responses[callCount++];
    }
    return false;
  }

  void whenCall(bool response) {
    responses.add(response);
  }

  void reset() {
    callCount = 0;
    responses.clear();
  }
}

void main() {
  late SideEffectHandler sideEffectHandler;
  late MockPollFunction mockPollFunc;
  late MockConditionFunction mockCondition;

  setUp(() {
    sideEffectHandler = SideEffectHandler();
    mockPollFunc = MockPollFunction();
    mockCondition = MockConditionFunction();
  });

  tearDown(() {
    mockPollFunc.reset();
    mockCondition.reset();
  });

  group('poll function tests', () {
    test('should succeed on first attempt', () async {
      mockPollFunc.whenCall(() async => true);

      final result = await sideEffectHandler.poll(
        pollFunc: mockPollFunc,
        retryDelayInSec: 0, // No delay for tests
      );

      expect(result, isTrue);
      expect(mockPollFunc.callCount, 1);
    });

    test('should retry and eventually succeed', () async {
      mockPollFunc.whenCall(() async => false); // First attempt fails
      mockPollFunc.whenCall(() async => false); // Second attempt fails
      mockPollFunc.whenCall(() async => true); // Third attempt succeeds

      final result = await sideEffectHandler.poll(
        pollFunc: mockPollFunc,
        retryDelayInSec: 0,
        maxRetry: 5,
      );

      expect(result, isTrue);
      expect(mockPollFunc.callCount, 3);
    });

    test('should respect maxRetry limit', () async {
      mockPollFunc.whenCall(() async => false);
      mockPollFunc.whenCall(() async => false);
      mockPollFunc.whenCall(() async => false);
      mockPollFunc.whenCall(() async => false);

      await expectLater(
        sideEffectHandler.poll(
          pollFunc: mockPollFunc,
          maxRetry: 3,
          retryDelayInSec: 0,
        ),
        throwsA(isA<SideEffectMaxRetryException>()),
      );

      expect(mockPollFunc.callCount, 4); // Initial + maxRetry
    });

    test('should respect maxPollTime', () async {
      mockPollFunc.whenCall(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return false;
      });
      mockPollFunc.whenCall(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return false;
      });
      mockPollFunc.whenCall(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return false;
      });
      mockPollFunc.whenCall(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return false;
      });
      mockPollFunc.whenCall(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return false;
      });
      mockPollFunc.whenCall(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return false;
      });

      await expectLater(
        () => sideEffectHandler.poll(
          pollFunc: mockPollFunc,
          maxPollTimeInSec: 1, // 1 second max time
          retryDelayInSec: 1,
        ),
        throwsA(isA<SideEffectMaxRetryException>()),
      );

      // Should have made multiple attempts within the 1 second window
      expect(mockPollFunc.callCount, greaterThan(1));
    });

    test('should respect initial delay', () async {
      mockPollFunc.whenCall(() async => true);
      final stopwatch = Stopwatch()..start();

      await sideEffectHandler.poll(
        pollFunc: mockPollFunc,
        timeDelayStartInSec: 1,
        retryDelayInSec: 0,
      );

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(1000));
      expect(mockPollFunc.callCount, 1);
    });

    test('should respect retry delay with fixed delay', () async {
      mockPollFunc.whenCall(() async => false);
      mockPollFunc.whenCall(() async => false);
      mockPollFunc.whenCall(() async => true);

      final stopwatch = Stopwatch()..start();

      await sideEffectHandler.poll(
        pollFunc: mockPollFunc,
        retryDelayInSec: 1,
        maxRetry: 5,
      );

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(3000));
      expect(mockPollFunc.callCount, 3);
    });


    test('should throw SideEffectMaxRetryException with last result is false', () async {
      final error = Exception('Test error');
      mockPollFunc.whenCall(() => Future.error(error));
      mockPollFunc.whenCall(() => Future.error(error));
      mockPollFunc.whenCall(() => Future.error(error));

      try {
        await sideEffectHandler.poll(
          pollFunc: mockPollFunc,
          maxRetry: 2,
          retryDelayInSec: 0,
        );
        fail('Expected SideEffectMaxRetryException');
      } on SideEffectMaxRetryException catch (e) {
        expect(e.lastResult, isFalse);
      }
    });
  });
}
