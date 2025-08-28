import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/ipv6_automatic_settings.dart';

void main() {
  group('IPv6rdTunnelSettings', () {
    const ipv6rdTunnelSettings = IPv6rdTunnelSettings(
      prefix: '2001:db8::/32',
      prefixLength: 32,
      borderRelay: '192.0.2.1',
      borderRelayPrefixLength: 24,
    );

    final Map<String, dynamic> ipv6rdTunnelSettingsMap = {
      'prefix': '2001:db8::/32',
      'prefixLength': 32,
      'borderRelay': '192.0.2.1',
      'borderRelayPrefixLength': 24,
    };

    test('toMap returns a valid map', () {
      expect(ipv6rdTunnelSettings.toMap(), ipv6rdTunnelSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(IPv6rdTunnelSettings.fromMap(ipv6rdTunnelSettingsMap), ipv6rdTunnelSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(ipv6rdTunnelSettings.toJson(), json.encode(ipv6rdTunnelSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(IPv6rdTunnelSettings.fromJson(json.encode(ipv6rdTunnelSettingsMap)), ipv6rdTunnelSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = ipv6rdTunnelSettings.copyWith(
        prefixLength: 48,
      );
      expect(updatedSettings.prefixLength, 48);
      expect(updatedSettings.prefix, ipv6rdTunnelSettings.prefix);
    });

    test('props are correct', () {
      final settings1 = IPv6rdTunnelSettings(prefix: 'p1', prefixLength: 1, borderRelay: 'b1', borderRelayPrefixLength: 1);
      final settings2 = IPv6rdTunnelSettings(prefix: 'p1', prefixLength: 1, borderRelay: 'b1', borderRelayPrefixLength: 1);
      final settings3 = IPv6rdTunnelSettings(prefix: 'p2', prefixLength: 2, borderRelay: 'b2', borderRelayPrefixLength: 2);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });

  group('IPv6AutomaticSettings', () {
    const ipv6rdTunnelSettings = IPv6rdTunnelSettings(
      prefix: '2001:db8::/32',
      prefixLength: 32,
      borderRelay: '192.0.2.1',
      borderRelayPrefixLength: 24,
    );

    const ipv6AutomaticSettings = IPv6AutomaticSettings(
      isIPv6AutomaticEnabled: true,
      ipv6rdTunnelMode: '6rd',
      ipv6rdTunnelSettings: ipv6rdTunnelSettings,
    );

    final Map<String, dynamic> ipv6AutomaticSettingsMap = {
      'isIPv6AutomaticEnabled': true,
      'ipv6rdTunnelMode': '6rd',
      'ipv6rdTunnelSettings': ipv6rdTunnelSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(ipv6AutomaticSettings.toMap(), ipv6AutomaticSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(IPv6AutomaticSettings.fromMap(ipv6AutomaticSettingsMap), ipv6AutomaticSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(ipv6AutomaticSettings.toJson(), json.encode(ipv6AutomaticSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(IPv6AutomaticSettings.fromJson(json.encode(ipv6AutomaticSettingsMap)), ipv6AutomaticSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = ipv6AutomaticSettings.copyWith(
        isIPv6AutomaticEnabled: false,
      );
      expect(updatedSettings.isIPv6AutomaticEnabled, false);
      expect(updatedSettings.ipv6rdTunnelMode, ipv6AutomaticSettings.ipv6rdTunnelMode);
    });

    test('props are correct', () {
      final settings1 = IPv6AutomaticSettings(isIPv6AutomaticEnabled: true);
      final settings2 = IPv6AutomaticSettings(isIPv6AutomaticEnabled: true);
      final settings3 = IPv6AutomaticSettings(isIPv6AutomaticEnabled: false);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
