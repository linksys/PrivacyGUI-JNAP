import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/advanced_routing_rule.dart';

void main() {
  group('AdvancedRoutingRuleData', () {
    const advancedRoutingRule = AdvancedRoutingRuleData(
      isEnabled: true,
      externalPort: 3074,
      protocol: "TCP",
      internalServerIPAddress: "192.168.1.150",
      internalPort: 3074,
      description: "XBox Live (TM)",
    );

    final Map<String, dynamic> advancedRoutingRuleMap = {
      'isEnabled': true,
      'externalPort': 3074,
      'protocol': "TCP",
      'internalServerIPAddress': "192.168.1.150",
      'internalPort': 3074,
      'description': "XBox Live (TM)",
    };

    test('toMap returns a valid map', () {
      expect(advancedRoutingRule.toMap(), advancedRoutingRuleMap);
    });

    test('fromMap creates a valid object', () {
      expect(AdvancedRoutingRuleData.fromMap(advancedRoutingRuleMap), advancedRoutingRule);
    });

    test('toJson returns a valid JSON string', () {
      expect(advancedRoutingRule.toJson(), json.encode(advancedRoutingRuleMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(AdvancedRoutingRuleData.fromJson(json.encode(advancedRoutingRuleMap)), advancedRoutingRule);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRule = advancedRoutingRule.copyWith(
        isEnabled: false,
        description: "Updated Description",
      );
      expect(updatedRule.isEnabled, false);
      expect(updatedRule.description, "Updated Description");
      expect(updatedRule.externalPort, advancedRoutingRule.externalPort);
    });

    test('props are correct', () {
      final rule1 = AdvancedRoutingRuleData(
        isEnabled: true,
        externalPort: 3074,
        protocol: "TCP",
        internalServerIPAddress: "192.168.1.150",
        internalPort: 3074,
        description: "XBox Live (TM)",
      );
      final rule2 = AdvancedRoutingRuleData(
        isEnabled: true,
        externalPort: 3074,
        protocol: "TCP",
        internalServerIPAddress: "192.168.1.150",
        internalPort: 3074,
        description: "XBox Live (TM)",
      );
      final rule3 = AdvancedRoutingRuleData(
        isEnabled: false,
        externalPort: 3074,
        protocol: "TCP",
        internalServerIPAddress: "192.168.1.150",
        internalPort: 3074,
        description: "XBox Live (TM)",
      );

      expect(rule1, rule2);
      expect(rule1.props, rule2.props);
      expect(rule1 == rule3, false);
      expect(rule1.props == rule3.props, false);
    });
  });
}