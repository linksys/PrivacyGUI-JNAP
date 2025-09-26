import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class PortRangeTriggeringRuleData extends Jsonable {
  const PortRangeTriggeringRuleData({
    required this.isEnabled,
    required this.firstTriggerPort,
    required this.lastTriggerPort,
    required this.firstForwardedPort,
    required this.lastForwardedPort,
    required this.description,
  });

  final bool isEnabled;
  final int firstTriggerPort;
  final int lastTriggerPort;
  final int firstForwardedPort;
  final int lastForwardedPort;
  final String description;

  @override
  List<Object> get props => [
        isEnabled,
        firstTriggerPort,
        lastTriggerPort,
        firstForwardedPort,
        lastForwardedPort,
        description,
      ];

  @override
  PortRangeTriggeringRuleData copyWith({
    bool? isEnabled,
    int? firstTriggerPort,
    int? lastTriggerPort,
    int? firstForwardedPort,
    int? lastForwardedPort,
    String? description,
  }) {
    return PortRangeTriggeringRuleData(
      isEnabled: isEnabled ?? this.isEnabled,
      firstTriggerPort: firstTriggerPort ?? this.firstTriggerPort,
      lastTriggerPort: lastTriggerPort ?? this.lastTriggerPort,
      firstForwardedPort: firstForwardedPort ?? this.firstForwardedPort,
      lastForwardedPort: lastForwardedPort ?? this.lastForwardedPort,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'firstTriggerPort': firstTriggerPort,
      'lastTriggerPort': lastTriggerPort,
      'firstForwardedPort': firstForwardedPort,
      'lastForwardedPort': lastForwardedPort,
      'description': description,
    };
  }

  @override
  factory PortRangeTriggeringRuleData.fromMap(Map<String, dynamic> json) {
    return PortRangeTriggeringRuleData(
      isEnabled: json['isEnabled'],
      firstTriggerPort: json['firstTriggerPort'],
      lastTriggerPort: json['lastTriggerPort'],
      firstForwardedPort: json['firstForwardedPort'],
      lastForwardedPort: json['lastForwardedPort'],
      description: json['description'],
    );
  }

  factory PortRangeTriggeringRuleData.fromJson(String source) =>
      PortRangeTriggeringRuleData.fromMap(jsonDecode(source));
}