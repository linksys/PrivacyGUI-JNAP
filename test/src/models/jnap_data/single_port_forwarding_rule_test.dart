import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/single_port_forwarding_rule.dart';

void main() {
  group('SinglePortForwardingRule', () {
    const singlePortForwardingRule = SinglePortForwardingRule(
      isEnabled: true,
      externalPort: 3074,
      protocol: "TCP",
      internalServerIPAddress: "192.168.1.150",
      internalPort: 3074,
      description: "XBox Live (TM)",
    );

    final Map<String, dynamic> singlePortForwardingRuleMap = {
      'isEnabled': true,
      'externalPort': 3074,
      'protocol': "TCP",
      'internalServerIPAddress': "192.168.1.150",
      'internalPort': 3074,
      'description': "XBox Live (TM)",
    };

    test('toMap returns a valid map', () {
      expect(singlePortForwardingRule.toMap(), singlePortForwardingRuleMap);
    });

    test('fromMap creates a valid object', () {
      expect(SinglePortForwardingRule.fromMap(singlePortForwardingRuleMap), singlePortForwardingRule);
    });

    test('toJson returns a valid JSON string', () {
      expect(singlePortForwardingRule.toJson(), json.encode(singlePortForwardingRuleMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SinglePortForwardingRule.fromJson(json.encode(singlePortForwardingRuleMap)), singlePortForwardingRule);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRule = singlePortForwardingRule.copyWith(
        isEnabled: false,
        description: "Updated Description",
      );
      expect(updatedRule.isEnabled, false);
      expect(updatedRule.description, "Updated Description");
      expect(updatedRule.externalPort, singlePortForwardingRule.externalPort);
    });

    test('props are correct', () {
      final rule1 = SinglePortForwardingRule(
        isEnabled: true,
        externalPort: 1,
        protocol: 'p1',
        internalServerIPAddress: 'ip1',
        internalPort: 2,
        description: 'd1',
      );
      final rule2 = SinglePortForwardingRule(
        isEnabled: true,
        externalPort: 1,
        protocol: 'p1',
        internalServerIPAddress: 'ip1',
        internalPort: 2,
        description: 'd1',
      );
      final rule3 = SinglePortForwardingRule(
        isEnabled: false,
        externalPort: 3,
        protocol: 'p2',
        internalServerIPAddress: 'ip2',
        internalPort: 4,
        description: 'd2',
      );

      expect(rule1, rule2);
      expect(rule1.props, rule2.props);
      expect(rule1 == rule3, false);
      expect(rule1.props == rule3.props, false);
    });
  });
}
