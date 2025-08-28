// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class TracerouteStatus extends Jsonable {
  final bool isRunning;
  final String tracerouteLog;
  const TracerouteStatus({
    required this.isRunning,
    required this.tracerouteLog,
  });

  @override
  TracerouteStatus copyWith({
    bool? isRunning,
    String? tracerouteLog,
  }) {
    return TracerouteStatus(
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

  factory TracerouteStatus.fromMap(Map<String, dynamic> map) {
    return TracerouteStatus(
      isRunning: map['isRunning'] as bool,
      tracerouteLog: map['tracerouteLog'] as String,
    );
  }

  @override
  List<Object> get props => [isRunning, tracerouteLog];

  factory TracerouteStatus.fromJson(String source) =>
      TracerouteStatus.fromMap(jsonDecode(source));
}
