import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/port_range_forwarding_rule.dart';

void main() {
  group('PortRangeForwardingRule', () {
    const portRangeForwardingRule = PortRangeForwardingRule(
      isEnabled: true,
      firstExternalPort: 3074,
      protocol: "TCP",
      internalServerIPAddress: "192.168.1.150",
      lastExternalPort: 3074,
      description: "XBox Live (TM)",
    );

    final Map<String, dynamic> portRangeForwardingRuleMap = {
      'isEnabled': true,
      'firstExternalPort': 3074,
      'protocol': "TCP",
      'internalServerIPAddress': "192.168.1.150",
      'lastExternalPort': 3074,
      'description': "XBox Live (TM)",
    };

    test('toMap returns a valid map', () {
      expect(portRangeForwardingRule.toMap(), portRangeForwardingRuleMap);
    });

    test('fromMap creates a valid object', () {
      expect(PortRangeForwardingRule.fromMap(portRangeForwardingRuleMap), portRangeForwardingRule);
    });

    test('toJson returns a valid JSON string', () {
      expect(portRangeForwardingRule.toJson(), json.encode(portRangeForwardingRuleMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PortRangeForwardingRule.fromJson(json.encode(portRangeForwardingRuleMap)), portRangeForwardingRule);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRule = portRangeForwardingRule.copyWith(
        isEnabled: false,
        description: "Updated Description",
      );
      expect(updatedRule.isEnabled, false);
      expect(updatedRule.description, "Updated Description");
      expect(updatedRule.firstExternalPort, portRangeForwardingRule.firstExternalPort);
    });

    test('props are correct', () {
      final rule1 = PortRangeForwardingRule(
        isEnabled: true,
        firstExternalPort: 1,
        protocol: 'p1',
        internalServerIPAddress: 'ip1',
        lastExternalPort: 2,
        description: 'd1',
      );
      final rule2 = PortRangeForwardingRule(
        isEnabled: true,
        firstExternalPort: 1,
        protocol: 'p1',
        internalServerIPAddress: 'ip1',
        lastExternalPort: 2,
        description: 'd1',
      );
      final rule3 = PortRangeForwardingRule(
        isEnabled: false,
        firstExternalPort: 3,
        protocol: 'p2',
        internalServerIPAddress: 'ip2',
        lastExternalPort: 4,
        description: 'd2',
      );

      expect(rule1, rule2);
      expect(rule1.props, rule2.props);
      expect(rule1 == rule3, false);
      expect(rule1.props == rule3.props, false);
    });
  });
}
