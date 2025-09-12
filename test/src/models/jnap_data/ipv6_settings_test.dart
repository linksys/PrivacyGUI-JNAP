import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/ipv6_settings.dart';
import 'package:jnap/src/models/jnap_data/ipv6_automatic_settings.dart';

void main() {
  group('GetIPv6SettingsData', () {
    const ipv6rdTunnelSettings = IPv6rdTunnelSettings(
      prefix: '2001:db8::/32',
      prefixLength: 32,
      borderRelay: '192.0.2.1',
      borderRelayPrefixLength: 24,
    );

    const ipv6AutomaticSettings = IPv6AutomaticSettingsData(
      isIPv6AutomaticEnabled: true,
      ipv6rdTunnelMode: '6rd',
      ipv6rdTunnelSettings: ipv6rdTunnelSettings,
    );

    const getIPv6Settings = GetIPv6SettingsData(
      wanType: 'Automatic',
      ipv6AutomaticSettings: ipv6AutomaticSettings,
      duid: '00:01:00:01:1A:2B:3C:4D:5E:6F',
    );

    final Map<String, dynamic> getIPv6SettingsMap = {
      'wanType': 'Automatic',
      'ipv6AutomaticSettings': ipv6AutomaticSettings.toMap(),
      'duid': '00:01:00:01:1A:2B:3C:4D:5E:6F',
    };

    test('toMap returns a valid map', () {
      expect(getIPv6Settings.toMap(), getIPv6SettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(GetIPv6SettingsData.fromMap(getIPv6SettingsMap), getIPv6Settings);
    });

    test('toJson returns a valid JSON string', () {
      expect(getIPv6Settings.toJson(), json.encode(getIPv6SettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GetIPv6SettingsData.fromJson(json.encode(getIPv6SettingsMap)), getIPv6Settings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = getIPv6Settings.copyWith(
        wanType: 'Manual',
        duid: 'new_duid',
      );
      expect(updatedSettings.wanType, 'Manual');
      expect(updatedSettings.duid, 'new_duid');
      expect(updatedSettings.ipv6AutomaticSettings, getIPv6Settings.ipv6AutomaticSettings);
    });

    test('props are correct', () {
      final settings1 = GetIPv6SettingsData(wanType: 't1', duid: 'd1');
      final settings2 = GetIPv6SettingsData(wanType: 't1', duid: 'd1');
      final settings3 = GetIPv6SettingsData(wanType: 't2', duid: 'd2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });

  group('SetIPv6SettingsData', () {
    const ipv6rdTunnelSettings = IPv6rdTunnelSettings(
      prefix: '2001:db8::/32',
      prefixLength: 32,
      borderRelay: '192.0.2.1',
      borderRelayPrefixLength: 24,
    );

    const ipv6AutomaticSettings = IPv6AutomaticSettingsData(
      isIPv6AutomaticEnabled: true,
      ipv6rdTunnelMode: '6rd',
      ipv6rdTunnelSettings: ipv6rdTunnelSettings,
    );

    const setIPv6Settings = SetIPv6SettingsData(
      wanType: 'Automatic',
      ipv6AutomaticSettings: ipv6AutomaticSettings,
    );

    final Map<String, dynamic> setIPv6SettingsMap = {
      'wanType': 'Automatic',
      'ipv6AutomaticSettings': ipv6AutomaticSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(setIPv6Settings.toMap(), setIPv6SettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SetIPv6SettingsData.fromMap(setIPv6SettingsMap), setIPv6Settings);
    });

    test('toJson returns a valid JSON string', () {
      expect(setIPv6Settings.toJson(), json.encode(setIPv6SettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SetIPv6SettingsData.fromJson(json.encode(setIPv6SettingsMap)), setIPv6Settings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = setIPv6Settings.copyWith(
        wanType: 'Manual',
      );
      expect(updatedSettings.wanType, 'Manual');
      expect(updatedSettings.ipv6AutomaticSettings, setIPv6Settings.ipv6AutomaticSettings);
    });

    test('props are correct', () {
      final settings1 = SetIPv6SettingsData(wanType: 't1');
      final settings2 = SetIPv6SettingsData(wanType: 't1');
      final settings3 = SetIPv6SettingsData(wanType: 't2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}