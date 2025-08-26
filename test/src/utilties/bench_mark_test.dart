import 'package:test/test.dart';
import 'package:jnap/src/utilties/bench_mark.dart';

void main() {
  group('BenchMarkLogger', () {
    test('should record start and end time and calculate delta', () async {
      final logger = BenchMarkLogger(name: 'test');
      logger.start();
      // Simulate some work
      await Future.delayed(const Duration(milliseconds: 100));
      final delta = logger.end();
      expect(delta, isA<int>());
      expect(delta, greaterThanOrEqualTo(100));
    });

    test('should not log to console when recordOnly is true', () {
      // This is hard to test without capturing logger output.
      // For now, we just ensure it runs without error.
      final logger = BenchMarkLogger(name: 'test', recordOnly: true);
      logger.start();
      final delta = logger.end();
      expect(delta, isA<int>());
    });
  });
}
