// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class PingStatus extends Jsonable {
  final bool isRunning;
  final String pingLog;
  const PingStatus({
    required this.isRunning,
    required this.pingLog,
  });

  @override
  PingStatus copyWith({
    bool? isRunning,
    String? pingLog,
  }) {
    return PingStatus(
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

  factory PingStatus.fromMap(Map<String, dynamic> map) {
    return PingStatus(
      isRunning: map['isRunning'] as bool,
      pingLog: map['pingLog'] as String,
    );
  }

  @override
  List<Object> get props => [isRunning, pingLog];

  factory PingStatus.fromJson(String source) =>
      PingStatus.fromMap(jsonDecode(source));
}
