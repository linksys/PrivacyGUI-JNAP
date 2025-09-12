import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/health_check_result.dart';

void main() {
  group('SpeedTestResult', () {
    const speedTestResult = SpeedTestResult(
      resultID: 1,
      exitCode: 'Success',
      serverID: 'server1',
      latency: 10,
      uploadBandwidth: 100,
      downloadBandwidth: 200,
    );

    final Map<String, dynamic> speedTestResultMap = {
      'resultID': 1,
      'exitCode': 'Success',
      'serverID': 'server1',
      'latency': 10,
      'uploadBandwidth': 100,
      'downloadBandwidth': 200,
    };

    test('toMap returns a valid map', () {
      expect(speedTestResult.toMap(), speedTestResultMap);
    });

    test('fromMap creates a valid object', () {
      expect(SpeedTestResult.fromMap(speedTestResultMap), speedTestResult);
    });

    test('toJson returns a valid JSON string', () {
      expect(speedTestResult.toJson(), json.encode(speedTestResultMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SpeedTestResult.fromJson(json.encode(speedTestResultMap)), speedTestResult);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedResult = speedTestResult.copyWith(
        latency: 20,
        uploadBandwidth: 150,
      );
      expect(updatedResult.latency, 20);
      expect(updatedResult.uploadBandwidth, 150);
      expect(updatedResult.exitCode, speedTestResult.exitCode);
    });

    test('props are correct', () {
      final result1 = SpeedTestResult(resultID: 1, exitCode: 'ok');
      final result2 = SpeedTestResult(resultID: 1, exitCode: 'ok');
      final result3 = SpeedTestResult(resultID: 2, exitCode: 'fail');
      expect(result1, result2);
      expect(result1.props, result2.props);
      expect(result1 == result3, false);
      expect(result1.props == result3.props, false);
    });
  });

  group('HealthCheckResultData', () {
    const speedTestResult = SpeedTestResult(
      resultID: 1,
      exitCode: 'Success',
      serverID: 'server1',
      latency: 10,
      uploadBandwidth: 100,
      downloadBandwidth: 200,
    );

    const healthCheckResult = HealthCheckResultData(
      resultID: 100,
      timestamp: '2023-01-01T12:00:00Z',
      healthCheckModulesRequested: ['SpeedTest', 'Connectivity'],
      speedTestResult: speedTestResult,
    );

    final Map<String, dynamic> healthCheckResultMap = {
      'resultID': 100,
      'timestamp': '2023-01-01T12:00:00Z',
      'healthCheckModulesRequested': ['SpeedTest', 'Connectivity'],
      'speedTestResult': speedTestResult.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(healthCheckResult.toMap(), healthCheckResultMap);
    });

    test('fromMap creates a valid object', () {
      expect(HealthCheckResultData.fromMap(healthCheckResultMap), healthCheckResult);
    });

    test('toJson returns a valid JSON string', () {
      expect(healthCheckResult.toJson(), json.encode(healthCheckResultMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(HealthCheckResultData.fromJson(json.encode(healthCheckResultMap)), healthCheckResult);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedResult = healthCheckResult.copyWith(
        timestamp: '2023-01-02T12:00:00Z',
        healthCheckModulesRequested: ['SpeedTest'],
      );
      expect(updatedResult.timestamp, '2023-01-02T12:00:00Z');
      expect(updatedResult.healthCheckModulesRequested, ['SpeedTest']);
      expect(updatedResult.resultID, healthCheckResult.resultID);
    });

    test('props are correct', () {
      final result1 = HealthCheckResultData(
        resultID: 1,
        timestamp: 't1',
        healthCheckModulesRequested: ['m1'],
      );
      final result2 = HealthCheckResultData(
        resultID: 1,
        timestamp: 't1',
        healthCheckModulesRequested: ['m1'],
      );
      final result3 = HealthCheckResultData(
        resultID: 2,
        timestamp: 't2',
        healthCheckModulesRequested: ['m2'],
      );

      expect(result1, result2);
      expect(result1.props, result2.props);
      expect(result1 == result3, false);
      expect(result1.props == result3.props, false);
    });
  });
}