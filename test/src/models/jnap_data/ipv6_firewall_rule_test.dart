import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/ipv6_firewall_rule.dart';

void main() {
  group('PortRange', () {
    const portRange = PortRange(
      protocol: 'TCP',
      firstPort: 80,
      lastPort: 8080,
    );

    final Map<String, dynamic> portRangeMap = {
      'protocol': 'TCP',
      'firstPort': 80,
      'lastPort': 8080,
    };

    test('toMap returns a valid map', () {
      expect(portRange.toMap(), portRangeMap);
    });

    test('fromMap creates a valid object', () {
      expect(PortRange.fromMap(portRangeMap), portRange);
    });

    test('toJson returns a valid JSON string', () {
      expect(portRange.toJson(), json.encode(portRangeMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PortRange.fromJson(json.encode(portRangeMap)), portRange);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRange = portRange.copyWith(
        firstPort: 443,
      );
      expect(updatedRange.firstPort, 443);
      expect(updatedRange.protocol, portRange.protocol);
    });

    test('props are correct', () {
      final range1 = PortRange(protocol: 'p1', firstPort: 1, lastPort: 2);
      final range2 = PortRange(protocol: 'p1', firstPort: 1, lastPort: 2);
      final range3 = PortRange(protocol: 'p2', firstPort: 3, lastPort: 4);
      expect(range1, range2);
      expect(range1.props, range2.props);
      expect(range1 == range3, false);
      expect(range1.props == range3.props, false);
    });
  });

  group('IPv6FirewallRuleData', () {
    const portRange1 = PortRange(
      protocol: 'TCP',
      firstPort: 80,
      lastPort: 8080,
    );
    const portRange2 = PortRange(
      protocol: 'UDP',
      firstPort: 53,
      lastPort: 53,
    );

    const ipv6FirewallRule = IPv6FirewallRuleData(
      description: 'Allow HTTP/S',
      ipv6Address: '2001:db8::1',
      isEnabled: true,
      portRanges: [portRange1, portRange2],
    );

    final Map<String, dynamic> ipv6FirewallRuleMap = {
      'description': 'Allow HTTP/S',
      'ipv6Address': '2001:db8::1',
      'isEnabled': true,
      'portRanges': [portRange1.toMap(), portRange2.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(ipv6FirewallRule.toMap(), ipv6FirewallRuleMap);
    });

    test('fromMap creates a valid object', () {
      expect(IPv6FirewallRuleData.fromMap(ipv6FirewallRuleMap), ipv6FirewallRule);
    });

    test('toJson returns a valid JSON string', () {
      expect(ipv6FirewallRule.toJson(), json.encode(ipv6FirewallRuleMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(IPv6FirewallRuleData.fromJson(json.encode(ipv6FirewallRuleMap)), ipv6FirewallRule);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRule = ipv6FirewallRule.copyWith(
        isEnabled: false,
        description: 'Block HTTP/S',
      );
      expect(updatedRule.isEnabled, false);
      expect(updatedRule.description, 'Block HTTP/S');
      expect(updatedRule.ipv6Address, ipv6FirewallRule.ipv6Address);
    });

    test('props are correct', () {
      final rule1 = IPv6FirewallRuleData(description: 'd1', ipv6Address: 'ip1', isEnabled: true, portRanges: [portRange1]);
      final rule2 = IPv6FirewallRuleData(description: 'd1', ipv6Address: 'ip1', isEnabled: true, portRanges: [portRange1]);
      final rule3 = IPv6FirewallRuleData(description: 'd2', ipv6Address: 'ip2', isEnabled: false, portRanges: [portRange2]);
      expect(rule1, rule2);
      expect(rule1.props, rule2.props);
      expect(rule1 == rule3, false);
      expect(rule1.props == rule3.props, false);
    });
  });
}