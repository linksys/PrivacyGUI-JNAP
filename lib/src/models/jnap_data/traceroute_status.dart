// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class TracerouteStatusData extends Jsonable {
  final bool isRunning;
  final String tracerouteLog;
  const TracerouteStatusData({
    required this.isRunning,
    required this.tracerouteLog,
  });

  @override
  TracerouteStatusData copyWith({
    bool? isRunning,
    String? tracerouteLog,
  }) {
    return TracerouteStatusData(
      isRunning: isRunning ?? this.isRunning,
      tracerouteLog: tracerouteLog ?? this.tracerouteLog,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isRunning': isRunning,
      'tracerouteLog': tracerouteLog,
    };
  }

  factory TracerouteStatusData.fromMap(Map<String, dynamic> map) {
    return TracerouteStatusData(
      isRunning: map['isRunning'] as bool,
      tracerouteLog: map['tracerouteLog'] as String,
    );
  }

  @override
  List<Object> get props => [isRunning, tracerouteLog];

  factory TracerouteStatusData.fromJson(String source) =>
      TracerouteStatusData.fromMap(jsonDecode(source));
}