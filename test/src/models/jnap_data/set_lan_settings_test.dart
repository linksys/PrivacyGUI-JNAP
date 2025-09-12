import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/set_lan_settings.dart';
import 'package:jnap/src/models/jnap_data/lan_settings.dart';

void main() {
  group('SetRouterLANSettingsData', () {
    const dhcpReservation = DHCPReservation(
      macAddress: '00:11:22:33:44:55',
      ipAddress: '192.168.1.100',
      description: 'My Device',
    );

    const dhcpSettings = DHCPSettings(
      lastClientIPAddress: '192.168.1.254',
      leaseMinutes: 1440,
      reservations: [dhcpReservation],
      firstClientIPAddress: '192.168.1.10',
    );

    const setRouterLANSettings = SetRouterLANSettingsData(
      ipAddress: '192.0.2.1',
      networkPrefixLength: 24,
      hostName: 'myrouter',
      isDHCPEnabled: true,
      dhcpSettings: dhcpSettings,
    );

    final Map<String, dynamic> setRouterLANSettingsMap = {
      'ipAddress': '192.0.2.1',
      'networkPrefixLength': 24,
      'hostName': 'myrouter',
      'isDHCPEnabled': true,
      'dhcpSettings': dhcpSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(setRouterLANSettings.toMap(), setRouterLANSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SetRouterLANSettingsData.fromMap(setRouterLANSettingsMap), setRouterLANSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(setRouterLANSettings.toJson(), json.encode(setRouterLANSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SetRouterLANSettingsData.fromJson(json.encode(setRouterLANSettingsMap)), setRouterLANSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = setRouterLANSettings.copyWith(
        ipAddress: '192.0.2.2',
        isDHCPEnabled: false,
      );
      expect(updatedSettings.ipAddress, '192.0.2.2');
      expect(updatedSettings.isDHCPEnabled, false);
      expect(updatedSettings.hostName, setRouterLANSettings.hostName);
    });

    test('props are correct', () {
      final settings1 = SetRouterLANSettingsData(
        ipAddress: 'ip1',
        networkPrefixLength: 1,
        hostName: 'h1',
        isDHCPEnabled: true,
        dhcpSettings: dhcpSettings,
      );
      final settings2 = SetRouterLANSettingsData(
        ipAddress: 'ip1',
        networkPrefixLength: 1,
        hostName: 'h1',
        isDHCPEnabled: true,
        dhcpSettings: dhcpSettings,
      );
      final settings3 = SetRouterLANSettingsData(
        ipAddress: 'ip2',
        networkPrefixLength: 2,
        hostName: 'h2',
        isDHCPEnabled: false,
        dhcpSettings: null,
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}