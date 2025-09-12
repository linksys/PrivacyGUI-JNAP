import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/port_range_triggering_rule.dart';

void main() {
  group('PortRangeTriggeringRuleData', () {
    const portRangeTriggeringRule = PortRangeTriggeringRuleData(
      isEnabled: true,
      firstTriggerPort: 1000,
      lastTriggerPort: 1001,
      firstForwardedPort: 2000,
      lastForwardedPort: 2001,
      description: "Game Trigger",
    );

    final Map<String, dynamic> portRangeTriggeringRuleMap = {
      'isEnabled': true,
      'firstTriggerPort': 1000,
      'lastTriggerPort': 1001,
      'firstForwardedPort': 2000,
      'lastForwardedPort': 2001,
      'description': "Game Trigger",
    };

    test('toMap returns a valid map', () {
      expect(portRangeTriggeringRule.toMap(), portRangeTriggeringRuleMap);
    });

    test('fromMap creates a valid object', () {
      expect(PortRangeTriggeringRuleData.fromMap(portRangeTriggeringRuleMap), portRangeTriggeringRule);
    });

    test('toJson returns a valid JSON string', () {
      expect(portRangeTriggeringRule.toJson(), json.encode(portRangeTriggeringRuleMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PortRangeTriggeringRuleData.fromJson(json.encode(portRangeTriggeringRuleMap)), portRangeTriggeringRule);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRule = portRangeTriggeringRule.copyWith(
        isEnabled: false,
        description: "Updated Trigger",
      );
      expect(updatedRule.isEnabled, false);
      expect(updatedRule.description, "Updated Trigger");
      expect(updatedRule.firstTriggerPort, portRangeTriggeringRule.firstTriggerPort);
    });

    test('props are correct', () {
      final rule1 = PortRangeTriggeringRuleData(
        isEnabled: true,
        firstTriggerPort: 1,
        lastTriggerPort: 2,
        firstForwardedPort: 3,
        lastForwardedPort: 4,
        description: 'd1',
      );
      final rule2 = PortRangeTriggeringRuleData(
        isEnabled: true,
        firstTriggerPort: 1,
        lastTriggerPort: 2,
        firstForwardedPort: 3,
        lastForwardedPort: 4,
        description: 'd1',
      );
      final rule3 = PortRangeTriggeringRuleData(
        isEnabled: false,
        firstTriggerPort: 5,
        lastTriggerPort: 6,
        firstForwardedPort: 7,
        lastForwardedPort: 8,
        description: 'd2',
      );

      expect(rule1, rule2);
      expect(rule1.props, rule2.props);
      expect(rule1 == rule3, false);
      expect(rule1.props == rule3.props, false);
    });
  });
}