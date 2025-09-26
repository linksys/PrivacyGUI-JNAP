import 'dart:convert';

import '../jsonable.dart';

class HealthCheckResultData extends Jsonable {
  final int resultID;
  final String timestamp;
  final List<String> healthCheckModulesRequested;
  final SpeedTestResult? speedTestResult;

  // final ErResult? channelAnalyzerResult;
  // final ErResult? deviceScannerResult;

  const HealthCheckResultData({
    required this.resultID,
    required this.timestamp,
    required this.healthCheckModulesRequested,
    this.speedTestResult,
  });

  @override
  List<Object?> get props => [
        resultID,
        timestamp,
        healthCheckModulesRequested,
        speedTestResult,
      ];

  @override
  HealthCheckResultData copyWith({
    int? resultID,
    String? timestamp,
    List<String>? healthCheckModulesRequested,
    SpeedTestResult? speedTestResult,
  }) {
    return HealthCheckResultData(
      resultID: resultID ?? this.resultID,
      timestamp: timestamp ?? this.timestamp,
      healthCheckModulesRequested:
          healthCheckModulesRequested ?? this.healthCheckModulesRequested,
      speedTestResult: speedTestResult ?? this.speedTestResult,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'resultID': resultID,
      'timestamp': timestamp,
      'healthCheckModulesRequested': healthCheckModulesRequested,
      'speedTestResult': speedTestResult?.toMap(),
    }..removeWhere((key, value) => value == null);
  }

  factory HealthCheckResultData.fromMap(Map<String, dynamic> map) {
    return HealthCheckResultData(
      resultID: map['resultID'],
      timestamp: map['timestamp'],
      healthCheckModulesRequested:
          List.from(map['healthCheckModulesRequested']),
      speedTestResult: map['speedTestResult'] == null
          ? null
          : SpeedTestResult.fromMap(map['speedTestResult']),
    );
  }

  factory HealthCheckResultData.fromJson(String source) =>
      HealthCheckResultData.fromMap(jsonDecode(source));
}

class SpeedTestResult extends Jsonable {
  final int resultID;
  final String exitCode;
  final String? serverID;
  final int? latency;
  final int? uploadBandwidth;
  final int? downloadBandwidth;

  const SpeedTestResult({
    required this.resultID,
    required this.exitCode,
    this.serverID,
    this.latency,
    this.uploadBandwidth,
    this.downloadBandwidth,
  });

  @override
  List<Object?> get props => [
        resultID,
        exitCode,
        serverID,
        latency,
        uploadBandwidth,
        downloadBandwidth,
      ];

  @override
  SpeedTestResult copyWith({
    int? resultID,
    String? exitCode,
    String? serverID,
    int? latency,
    int? uploadBandwidth,
    int? downloadBandwidth,
  }) {
    return SpeedTestResult(
      resultID: resultID ?? this.resultID,
      exitCode: exitCode ?? this.exitCode,
      serverID: serverID ?? this.serverID,
      latency: latency ?? this.latency,
      uploadBandwidth: uploadBandwidth ?? this.uploadBandwidth,
      downloadBandwidth: downloadBandwidth ?? this.downloadBandwidth,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'resultID': resultID,
      'exitCode': exitCode,
      'serverID': serverID,
      'latency': latency,
      'uploadBandwidth': uploadBandwidth,
      'downloadBandwidth': downloadBandwidth,
    };
  }

  factory SpeedTestResult.fromMap(Map<String, dynamic> map) {
    return SpeedTestResult(
      resultID: map['resultID'],
      exitCode: map['exitCode'],
      serverID: map['serverID'],
      latency: map['latency'],
      uploadBandwidth: map['uploadBandwidth'],
      downloadBandwidth: map['downloadBandwidth'],
    );
  }

  factory SpeedTestResult.fromJson(String source) =>
      SpeedTestResult.fromMap(jsonDecode(source));
}