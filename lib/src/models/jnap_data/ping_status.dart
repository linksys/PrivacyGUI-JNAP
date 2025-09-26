// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class PingStatusData extends Jsonable {
  final bool isRunning;
  final String pingLog;
  const PingStatusData({
    required this.isRunning,
    required this.pingLog,
  });

  @override
  PingStatusData copyWith({
    bool? isRunning,
    String? pingLog,
  }) {
    return PingStatusData(
      isRunning: isRunning ?? this.isRunning,
      pingLog: pingLog ?? this.pingLog,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isRunning': isRunning,
      'pingLog': pingLog,
    };
  }

  factory PingStatusData.fromMap(Map<String, dynamic> map) {
    return PingStatusData(
      isRunning: map['isRunning'] as bool,
      pingLog: map['pingLog'] as String,
    );
  }

  @override
  List<Object> get props => [isRunning, pingLog];

  factory PingStatusData.fromJson(String source) =>
      PingStatusData.fromMap(jsonDecode(source));
}