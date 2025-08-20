import 'dart:async';
import 'dart:math';

import 'package:jnap/logger.dart';

class RetryException implements Exception {
  final String message;

  RetryException(this.message);
}

class MaxRetriesExceededException implements Exception {
  final String message;
  final Object? lastResult;

  MaxRetriesExceededException({this.lastResult})
      : message = 'Max retries exceeded';
}

class ShouldRetryException implements Exception {
  final String message;
  final dynamic result;

  ShouldRetryException(this.result)
      : message = 'Should retry check failed! $result';
}

abstract class RetryStrategy {
  final int maxRetries;
  final Duration initialDelay;
  final Duration maxDelay; // Maximum delay duration
  final Duration? maxExecutionTime; // Maximum execution time

  RetryStrategy({
    this.maxRetries = 5,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay =
        const Duration(seconds: 60), // Default max delay of 60 seconds
    this.maxExecutionTime, // Default max execution time of 60 seconds
  });

  /// Calculates the next wait time based on the retry attempt.
  Duration calculateDelay(int retryAttempt);  
  
  /// Simulates an asynchronous operation that retries based on the strategy.
  Future<T> execute<T>(
    Future<T> Function() operation, {
    bool Function(T result)? shouldRetry,
    Function(int retryAttempt)? onRetry,
    Function(int attempt, T? result, Object? error)? onProgress,
  }) async {
    int retryAttempt = 0;
    final startTime = DateTime.now();
    while (maxRetries == -1 || retryAttempt <= maxRetries) {
      try {
        final result = await operation();
        if (shouldRetry?.call(result) ?? false) {
          throw ShouldRetryException(result);
        } else {
          onProgress?.call(retryAttempt, result, null);
          return result;
        }
      } catch (e) {
        onProgress?.call(retryAttempt, null, e);
        if (maxExecutionTime != null &&
            DateTime.now().difference(startTime).inSeconds >
                maxExecutionTime!.inSeconds) {
          logger.e(
              'Max execution time reached. Giving up. Last result: ${e is ShouldRetryException ? e.result : e}');
          final lastResult = e is ShouldRetryException ? e.result : e;
          throw MaxRetriesExceededException(lastResult: lastResult);
        }
        if (maxRetries != -1 && retryAttempt == maxRetries) {
          logger.e(
              'Max retry attempts reached. Giving up. Last result: ${e is ShouldRetryException ? e.result : e}');
          final lastResult = e is ShouldRetryException ? e.result : e;
          throw MaxRetriesExceededException(lastResult: lastResult);
        }

        final delay = calculateDelay(retryAttempt);
        logger.i(
            'Attempt ${retryAttempt + 1} failed. Retrying in ${delay.inSeconds} seconds...');
        onRetry?.call(retryAttempt);
        await Future.delayed(delay);
        retryAttempt++;
      }
    }
    throw Exception(
        'Unknown error: Failed to execute operation.'); // Should not be reached
  }

  Stream<T> executeStream<T>(
    Future<T> Function() operation, {
    bool Function(T result)? shouldRetry,
    Function(int retryAttempt)? onRetry,
    Function(int attempt, T? result, Object? error)? onProgress,
  }) {
    final controller = StreamController<T>();
    final startTime = DateTime.now();

    void start() async {
      int retryAttempt = 0;
      Object? lastError;

      while (maxRetries == -1 || retryAttempt <= maxRetries) {
        if (controller.isClosed) return;

        // Check for max execution time
        if (maxExecutionTime != null &&
            DateTime.now().difference(startTime).inSeconds >
                maxExecutionTime!.inSeconds) {
          logger.e('Max execution time reached. Giving up.');
          final error = MaxRetriesExceededException(
              lastResult: lastError ?? 'Max execution time exceeded');
          onProgress?.call(retryAttempt, null, error);
          controller.addError(error);
          controller.close();
          return;
        }

        try {
          final result = await operation();
          onProgress?.call(retryAttempt, result, null);
          controller.add(result);

          if (!(shouldRetry?.call(result) ?? false)) {
            // Success and no need to retry, we are done.
            controller.close();
            return;
          }
          // If shouldRetry is true, we loop again after a delay.
        } catch (e) {
          lastError = e;
          onProgress?.call(retryAttempt, null, e);
          // Operation failed, we loop again after a delay.
        }

        // If we are here, it means we need to retry.
        // Check if we have exceeded max retries *before* the next attempt.
        if (maxRetries != -1 && retryAttempt == maxRetries) {
          logger.e('Max retry attempts reached. Giving up.');
          final error = MaxRetriesExceededException(
              lastResult: lastError ?? 'Max retries exceeded');
          controller.addError(error);
          controller.close();
          return;
        }

        final delay = calculateDelay(retryAttempt);
        logger.i(
            'Attempt ${retryAttempt + 1} requires another attempt. Retrying in ${delay.inSeconds} seconds...');
        onRetry?.call(retryAttempt);
        await Future.delayed(delay);
        retryAttempt++;
      }
    }

    start();
    return controller.stream;
  }
}

/// Fixed delay retry strategy by initial delay
class FixedRetryStrategy extends RetryStrategy {
  FixedRetryStrategy({
    super.maxRetries,
    super.initialDelay,
    super.maxDelay,
    super.maxExecutionTime,
  });

  @override
  Duration calculateDelay(int retryAttempt) {
    return initialDelay;
  }
}

class ExponentialBackoffRetryStrategy extends RetryStrategy {
  final double base; // Base for the exponential calculation

  ExponentialBackoffRetryStrategy({
    super.maxRetries,
    super.initialDelay,
    super.maxDelay,
    super.maxExecutionTime,
    this.base = 2.0, // Default base of 2
  });

  @override
  Duration calculateDelay(int retryAttempt) {
    // Delay = Initial Delay * (Base ^ Retry Attempt)
    // Ensure the calculated delay does not exceed the maximum delay.
    final calculatedDelaySeconds =
        initialDelay.inSeconds * pow(base, retryAttempt);
    return Duration(
      seconds: min(calculatedDelaySeconds.toInt(), maxDelay.inSeconds),
    );
  }
}

class ExponentialBackoffWithJitterRetryStrategy extends RetryStrategy {
  final double base;
  final Random _random = Random(); // Used for generating random numbers

  ExponentialBackoffWithJitterRetryStrategy({
    super.maxRetries,
    super.initialDelay,
    super.maxDelay,
    super.maxExecutionTime,
    this.base = 2.0,
  });

  @override
  Duration calculateDelay(int retryAttempt) {
    final theoreticalDelaySeconds =
        initialDelay.inSeconds * pow(base, retryAttempt);

    // Full Jitter: Random value between [0, theoreticalDelay]
    final delayWithJitter = _random.nextDouble() * theoreticalDelaySeconds;

    // Alternatively, implement Equal Jitter:
    // final halfTheoreticalDelay = theoreticalDelaySeconds / 2;
    // final delayWithJitter = halfTheoreticalDelay + _random.nextDouble() * halfTheoreticalDelay;

    return Duration(
      seconds: min(delayWithJitter.toInt(), maxDelay.inSeconds),
    );
  }
}

class LinearBackoffRetryStrategy extends RetryStrategy {
  final Duration increment; // Duration to add each time

  LinearBackoffRetryStrategy({
    super.maxRetries,
    super.initialDelay,
    super.maxDelay,
    super.maxExecutionTime,
    this.increment =
        const Duration(seconds: 2), // Default increment of 2 seconds
  });

  @override
  Duration calculateDelay(int retryAttempt) {
    // Delay = Initial Delay + (Increment * Retry Attempt)
    final calculatedDelaySeconds =
        initialDelay.inSeconds + (increment.inSeconds * retryAttempt);
    return Duration(
      seconds: min(calculatedDelaySeconds, maxDelay.inSeconds),
    );
  }
}

class FibonacciBackoffRetryStrategy extends RetryStrategy {
  FibonacciBackoffRetryStrategy({
    super.maxRetries,
    super.initialDelay,
    super.maxDelay,
    super.maxExecutionTime,
  });

  // Calculates the nth Fibonacci number
  int _fibonacci(int n) {
    if (n <= 1) return n;
    int a = 0;
    int b = 1;
    for (int i = 2; i <= n; i++) {
      int next = a + b;
      a = b;
      b = next;
    }
    return b;
  }

  @override
  Duration calculateDelay(int retryAttempt) {
    // Delay = Initial Delay * Fibonacci(Retry Attempt + 1)
    // We use retryAttempt + 1 because Fibonacci(0) = 0, Fibonacci(1) = 1.
    // We want the factor for the first retry (retryAttempt = 0) to be at least 1.
    final fibValue = _fibonacci(retryAttempt + 1);
    final calculatedDelaySeconds = initialDelay.inSeconds * fibValue;
    return Duration(
      seconds: min(calculatedDelaySeconds, maxDelay.inSeconds),
    );
  }
}

class PolynomialGrowthRetryStrategy extends RetryStrategy {
  final double power; // The exponent

  PolynomialGrowthRetryStrategy({
    super.maxRetries,
    super.initialDelay,
    super.maxDelay,
    super.maxExecutionTime,
    this.power = 2.0, // Default to squared
  });

  @override
  Duration calculateDelay(int retryAttempt) {
    // Delay = Initial Delay * (Retry Attempt + 1)^Power
    // (Retry Attempt + 1) ensures the factor is at least 1 for the first retry.
    final calculatedDelaySeconds =
        initialDelay.inSeconds * pow(retryAttempt + 1, power);
    return Duration(
      seconds: min(calculatedDelaySeconds.toInt(), maxDelay.inSeconds),
    );
  }
}
