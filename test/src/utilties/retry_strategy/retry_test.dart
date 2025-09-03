import 'package:fake_async/fake_async.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:test/test.dart';

void main() {
  group('RetryStrategy', () {
    test('should execute successfully on first attempt', () async {
      final strategy = ExponentialBackoffRetryStrategy(maxRetries: 3);
      final result = await strategy.execute(() async => 'success');
      expect(result, 'success');
    });

    test('should retry until success', () async {
      int attempt = 0;
      final strategy = ExponentialBackoffRetryStrategy(maxRetries: 3);

      final result = await strategy.execute(
        () async {
          if (attempt++ < 2) {
            throw Exception('Temporary failure');
          }
          return 'success';
        },
      );

      expect(result, 'success');
      expect(attempt, 3);
    });

    test('should throw MaxRetriesExceededException when max retries reached',
        () async {
      final strategy = ExponentialBackoffRetryStrategy(maxRetries: 2);

      expect(
        () => strategy.execute(
          () async => throw Exception('Permanent failure'),
        ),
        throwsA(isA<MaxRetriesExceededException>()),
      );
    });

    test(
        'should throw MaxRetriesExceededException when maxExecutionTime is reached',
        () async {
      fakeAsync((async) async {
        final strategy = FixedRetryStrategy(
            maxExecutionTime: const Duration(seconds: 5),
            maxDelay: const Duration(seconds: 1),
            maxRetries: -1); // Added maxRetries: -1

        // This future will continuously throw an exception,
        // causing the strategy to retry until the max execution time is exceeded.
        final future = strategy.execute(
          () async {
            // This simulates a failed attempt. The strategy will retry.
            throw Exception('simulated failure');
          },
        );

        // Now, we expect the future to have thrown the specific exception.
        // We use expect with a function to correctly catch the asynchronous exception.
        expect(
          future,
          throwsA(isA<MaxRetriesExceededException>()),
        );
        // We must elapse enough time to exceed the strategy\'s maxExecutionTime.
        // The strategy will keep retrying and failing until it runs out of time.
        async.elapse(const Duration(seconds: 10));
        async.flushMicrotasks(); // Added to ensure all microtasks are processed
      });
    });

    test('should call onRetry callback for each retry', () async {
      int retryCount = 0;
      final strategy = ExponentialBackoffRetryStrategy(maxRetries: 3);

      try {
        await strategy.execute(
          () async => throw Exception('Failure'),
          onRetry: (attempt) => retryCount++,
        );
      } catch (_) {}

      expect(retryCount, 3);
    });
  });

  group('ExponentialBackoffRetryStrategy', () {
    test('should calculate correct delays', () {
      final strategy = ExponentialBackoffRetryStrategy(
        initialDelay: const Duration(seconds: 1),
        maxDelay: const Duration(seconds: 30),
      );

      expect(strategy.calculateDelay(0).inSeconds, 1); // 1 * 2^0 = 1
      expect(strategy.calculateDelay(1).inSeconds, 2); // 1 * 2^1 = 2
      expect(strategy.calculateDelay(2).inSeconds, 4); // 1 * 2^2 = 4
      expect(strategy.calculateDelay(3).inSeconds, 8); // 1 * 2^3 = 8
    });

    test('should respect maxDelay', () {
      final strategy = ExponentialBackoffRetryStrategy(
        initialDelay: const Duration(seconds: 10),
        maxDelay: const Duration(seconds: 15),
      );

      expect(strategy.calculateDelay(0).inSeconds, 10); // 10 * 2^0 = 10
      expect(strategy.calculateDelay(1).inSeconds,
          15); // 10 * 2^1 = 20, but capped at 15
      expect(strategy.calculateDelay(2).inSeconds,
          15); // 10 * 2^2 = 40, but capped at 15
    });
  });

  group('ExponentialBackoffWithJitterRetryStrategy', () {
    test('should return delay within expected range', () {
      final strategy = ExponentialBackoffWithJitterRetryStrategy(
        initialDelay: const Duration(seconds: 1),
        maxDelay: const Duration(seconds: 30),
      );

      for (int i = 0; i < 10; i++) {
        final delay =
            strategy.calculateDelay(2); // 1 * 2^2 = 4 seconds theoretical max
        expect(delay.inSeconds, greaterThanOrEqualTo(0));
        expect(delay.inSeconds, lessThanOrEqualTo(4));
      }
    });
  });

  group('LinearBackoffRetryStrategy', () {
    test('should calculate correct delays', () {
      final strategy = LinearBackoffRetryStrategy(
        initialDelay: const Duration(seconds: 1),
        increment: const Duration(seconds: 2),
        maxDelay: const Duration(seconds: 10),
      );

      expect(strategy.calculateDelay(0).inSeconds, 1); // 1 + (2 * 0) = 1
      expect(strategy.calculateDelay(1).inSeconds, 3); // 1 + (2 * 1) = 3
      expect(strategy.calculateDelay(2).inSeconds, 5); // 1 + (2 * 2) = 5
    });
  });

  group('FibonacciBackoffRetryStrategy', () {
    test('should calculate correct delays', () {
      final strategy = FibonacciBackoffRetryStrategy(
        initialDelay: const Duration(seconds: 1),
        maxDelay: const Duration(seconds: 100),
      );

      // Fibonacci sequence: 0, 1, 1, 2, 3, 5, 8, 13...
      // We use retryAttempt + 1 to get: 1, 1, 2, 3, 5, 8, 13...
      expect(strategy.calculateDelay(0).inSeconds, 1); // 1 * 1 = 1
      expect(strategy.calculateDelay(1).inSeconds, 1); // 1 * 1 = 1
      expect(strategy.calculateDelay(2).inSeconds, 2); // 1 * 2 = 2
      expect(strategy.calculateDelay(3).inSeconds, 3); // 1 * 3 = 3
      expect(strategy.calculateDelay(4).inSeconds, 5); // 1 * 5 = 5
    });
  });

  group('PolynomialGrowthRetryStrategy', () {
    test('should calculate correct delays with power of 2', () {
      final strategy = PolynomialGrowthRetryStrategy(
        initialDelay: const Duration(seconds: 1),
        power: 2.0,
        maxDelay: const Duration(seconds: 100),
      );

      expect(strategy.calculateDelay(0).inSeconds, 1); // 1 * (0+1)^2 = 1
      expect(strategy.calculateDelay(1).inSeconds, 4); // 1 * (1+1)^2 = 4
      expect(strategy.calculateDelay(2).inSeconds, 9); // 1 * (2+1)^2 = 9
      expect(strategy.calculateDelay(3).inSeconds, 16); // 1 * (3+1)^2 = 16
    });

    test('should respect custom power value', () {
      final strategy = PolynomialGrowthRetryStrategy(
        initialDelay: const Duration(seconds: 1),
        power: 3.0, // Cubic growth
        maxDelay: const Duration(seconds: 100),
      );

      expect(strategy.calculateDelay(0).inSeconds, 1); // 1 * (0+1)^3 = 1
      expect(strategy.calculateDelay(1).inSeconds, 8); // 1 * (1+1)^3 = 8
      expect(strategy.calculateDelay(2).inSeconds, 27); // 1 * (2+1)^3 = 27
    });
  });

  test('should use shouldRetry callback to determine retry', () async {
    int attempt = 0;
    final strategy = ExponentialBackoffRetryStrategy(maxRetries: 3);

    final result = await strategy.execute(
      () async => attempt++,
      shouldRetry: (result) => result < 2, // Retry if result is less than 2
    );

    expect(result, 2); // Should stop when result is 2 (3rd attempt: 0, 1, 2)
    expect(attempt, 3);
  });

  test('should throw ShouldRetryException when shouldRetry returns true',
      () async {
    final strategy = ExponentialBackoffRetryStrategy(maxRetries: 0);

    expect(
      () => strategy.execute(
        () async => 'retry',
        shouldRetry: (result) => result == 'retry',
      ),
      throwsA(isA<MaxRetriesExceededException>()),
    );
  });

  test(
      'should throw MaxRetriesExceededException when max execution time reached',
      () async {
    final strategy = ExponentialBackoffRetryStrategy(
        maxRetries: -1, maxExecutionTime: const Duration(seconds: 1));
    expect(
      () => strategy.execute(
        () async => 'retry',
        shouldRetry: (result) => result == 'retry',
      ),
      throwsA(isA<MaxRetriesExceededException>()),
    );
  });

  group('executeStream', () {
    test('should emit one value and close on first success', () {
      final strategy = FixedRetryStrategy(maxRetries: 3);
      final stream = strategy.executeStream(() async => 'success');

      expect(
        stream,
        emitsInOrder(<dynamic>[
          'success',
          emitsDone,
        ]),
      );
    });

    test('should stream attempts until shouldRetry is false', () {
      int attempt = 0;
      final strategy = FixedRetryStrategy(
        maxRetries: 5, // More than enough retries
        initialDelay:
            const Duration(milliseconds: 10), // Short delay for test speed
      );

      final stream = strategy.executeStream(
        () async => attempt++,
        shouldRetry: (result) => result < 3, // Poll until result is 3
      );

      expect(
        stream,
        emitsInOrder(<dynamic>[
          0, // Emitted, shouldRetry is true
          1, // Emitted, shouldRetry is true
          2, // Emitted, shouldRetry is true
          3, // Emitted, shouldRetry is false, stream closes
          emitsDone,
        ]),
      );
    });

    test('should emit error when max retries exceeded', () {
      final strategy = FixedRetryStrategy(
        maxRetries: 2,
        initialDelay: const Duration(milliseconds: 10),
      );

      final stream = strategy.executeStream<String>(
        () async => throw Exception('Permanent failure'),
      );

      expect(
        stream,
        emitsInOrder(<dynamic>[
          emitsError(isA<MaxRetriesExceededException>()),
          emitsDone,
        ]),
      );
    });

    test('should emit error when max execution time exceeded', () {
      final strategy = FixedRetryStrategy(
        maxRetries: -1, // Infinite retries
        maxExecutionTime: const Duration(milliseconds: 50),
        initialDelay: const Duration(milliseconds: 20),
      );

      final stream = strategy.executeStream<String>(
        () async => throw Exception('Failure'),
      );

      expect(
        stream,
        emitsInOrder(<dynamic>[
          emitsError(isA<MaxRetriesExceededException>()),
          emitsDone,
        ]),
      );
    });

    test('should emit successful results despite intermittent failures', () {
      int attempt = 0;
      final strategy = FixedRetryStrategy(
        maxRetries: 5,
        initialDelay: const Duration(milliseconds: 10),
      );

      final stream = strategy.executeStream<String>(
        () async {
          attempt++;
          if (attempt == 2 || attempt == 4) {
            throw Exception('Intermittent failure on attempt $attempt');
          }
          return 'success #$attempt';
        },
        shouldRetry: (result) => attempt < 5,
      );

      // It should skip emitting anything for attempts 2 and 4 (the failures)
      // and emit successes for 1, 3, and 5.
      // The stream closes after attempt 5 because shouldRetry becomes false.
      expect(
        stream,
        emitsInOrder(<dynamic>[
          'success #1',
          'success #3',
          'success #5',
          emitsDone,
        ]),
      );
    });

    test(
        'MaxRetriesExceededException from executeStream should contain last result when failure is from shouldRetry',
        () async {
      final strategy = FixedRetryStrategy(maxRetries: 1);
      Object? exception;

      await strategy
          .executeStream(
            () async => 'a result',
            shouldRetry: (result) => true, // always retry
          )
          .drain()
          .catchError((e) {
        exception = e;
      });

      expect(exception, isA<MaxRetriesExceededException>());
      expect((exception as MaxRetriesExceededException).lastResult, 'a result');
    });

    test(
        'MaxRetriesExceededException from executeStream should contain last error when failure is from operation',
        () async {
      final strategy = FixedRetryStrategy(maxRetries: 1);
      Object? exception;
      final failure = Exception('Permanent failure');

      await strategy
          .executeStream(
            () async => throw failure,
          )
          .drain()
          .catchError((e) {
        exception = e;
      });

      expect(exception, isA<MaxRetriesExceededException>());
      expect((exception as MaxRetriesExceededException).lastResult, failure);
    });
  });

  group('onProgress callback', () {
    test('should be called for each attempt in execute', () async {
      final strategy = FixedRetryStrategy(maxRetries: 2);
      final progress = <(int, dynamic, dynamic)>[];

      try {
        await strategy.execute(
          () async {
            if (progress.length < 2) {
              throw Exception('Failure');
            }
            return 'Success';
          },
          onProgress: (attempt, result, error) {
            progress.add((attempt, result, error));
          },
        );
      } catch (_) {}

      expect(progress.length, 3);
      expect(progress[0].$1, 0); // attempt
      expect(progress[0].$3, isA<Exception>()); // error
      expect(progress[1].$1, 1); // attempt
      expect(progress[1].$3, isA<Exception>()); // error
      expect(progress[2].$1, 2); // attempt
      expect(progress[2].$2, 'Success'); // result
    });

    test('should be called for each attempt in executeStream', () async {
      final strategy = FixedRetryStrategy(maxRetries: 2);
      final progress = <(int, dynamic, dynamic)>[];

      await strategy
          .executeStream(
            () async {
              if (progress.length < 2) {
                throw Exception('Failure');
              }
              return 'Success';
            },
            onProgress: (attempt, result, error) {
              progress.add((attempt, result, error));
            },
          )
          .drain()
          .catchError((_) {});

      expect(progress.length, 3);
      expect(progress[0].$1, 0); // attempt
      expect(progress[0].$3, isA<Exception>()); // error
      expect(progress[1].$1, 1); // attempt
      expect(progress[1].$3, isA<Exception>()); // error
      expect(progress[2].$1, 2); // attempt
      expect(progress[2].$2, 'Success'); // result
    });
  });

  group('onComplete callback', () {
    test('should be called on successful completion of executeStream',
        () async {
      final strategy = FixedRetryStrategy(maxRetries: 1);
      dynamic onCompleteResult;
      dynamic onCompleteError;

      await strategy.executeStream(
        () async => 'Success',
        onComplete: (result, error) {
          onCompleteResult = result;
          onCompleteError = error;
        },
      ).drain();

      expect(onCompleteResult, 'Success');
      expect(onCompleteError, isNull);
    });

    test('should be called on error completion of executeStream', () async {
      final strategy = FixedRetryStrategy(maxRetries: 1);
      dynamic onCompleteResult;
      dynamic onCompleteError;

      await strategy
          .executeStream(
            () async => throw Exception('Failure'),
            onComplete: (result, error) {
              onCompleteResult = result;
              onCompleteError = error;
            },
          )
          .drain()
          .catchError((_) {});

      expect(onCompleteResult, isNull);
      expect(onCompleteError, isA<MaxRetriesExceededException>());
    });

    test('should be called last after all other callbacks', () async {
      final strategy = FixedRetryStrategy(maxRetries: 2);
      final events = <String>[];

      await strategy
          .executeStream(
            () async {
              if (events.where((e) => e.startsWith('onProgress')).length < 2) {
                throw Exception('Failure');
              }
              return 'Success';
            },
            onProgress: (attempt, result, error) {
              events.add('onProgress');
            },
            onRetry: (attempt) {
              events.add('onRetry');
            },
            onComplete: (result, error) {
              events.add('onComplete');
            },
          )
          .drain()
          .catchError((_) {});

      expect(events.last, 'onComplete');
      expect(events, [
        'onProgress',
        'onRetry',
        'onProgress',
        'onRetry',
        'onProgress',
        'onComplete'
      ]);
    });

    test('onComplete should be the last call if shouldRetry returns false',
        () async {
      final strategy = FixedRetryStrategy(maxRetries: 5);
      final events = <String>[];
      int attempt = 0;

      await strategy
          .executeStream(
            () async {
              return attempt++;
            },
            shouldRetry: (result) => result < 2, // Stop when result is 2
            onProgress: (attempt, result, error) {
              events.add('onProgress');
            },
            onRetry: (attempt) {
              events.add('onRetry');
            },
            onComplete: (result, error) {
              events.add('onComplete');
            },
          )
          .drain();

      expect(events.last, 'onComplete');
      expect(events, [
        'onProgress', // attempt 0, result 0, shouldRetry true
        'onRetry',
        'onProgress', // attempt 1, result 1, shouldRetry true
        'onRetry',
        'onProgress', // attempt 2, result 2, shouldRetry false
        'onComplete',
      ]);
    });
  });
}
