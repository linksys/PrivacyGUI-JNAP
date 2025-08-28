import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/lan_settings.dart';

void main() {
  group('DHCPReservation', () {
    const dhcpReservation = DHCPReservation(
      macAddress: '00:11:22:33:44:55',
      ipAddress: '192.168.1.100',
      description: 'My Device',
    );

    final Map<String, dynamic> dhcpReservationMap = {
      'macAddress': '00:11:22:33:44:55',
      'ipAddress': '192.168.1.100',
      'description': 'My Device',
    };

    test('toMap returns a valid map', () {
      expect(dhcpReservation.toMap(), dhcpReservationMap);
    });

    test('fromMap creates a valid object', () {
      expect(DHCPReservation.fromMap(dhcpReservationMap), dhcpReservation);
    });

    test('toJson returns a valid JSON string', () {
      expect(dhcpReservation.toJson(), json.encode(dhcpReservationMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DHCPReservation.fromJson(json.encode(dhcpReservationMap)), dhcpReservation);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedReservation = dhcpReservation.copyWith(
        ipAddress: '192.168.1.101',
      );
      expect(updatedReservation.ipAddress, '192.168.1.101');
      expect(updatedReservation.macAddress, dhcpReservation.macAddress);
    });

    test('props are correct', () {
      final res1 = DHCPReservation(macAddress: 'm1', ipAddress: 'i1', description: 'd1');
      final res2 = DHCPReservation(macAddress: 'm1', ipAddress: 'i1', description: 'd1');
      final res3 = DHCPReservation(macAddress: 'm2', ipAddress: 'i2', description: 'd2');
      expect(res1, res2);
      expect(res1.props, res2.props);
      expect(res1 == res3, false);
      expect(res1.props == res3.props, false);
    });
  });

  group('DHCPSettings', () {
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
      dnsServer1: '8.8.8.8',
      dnsServer2: '8.8.4.4',
      dnsServer3: '1.1.1.1',
      winsServer: '192.168.1.5',
    );

    final Map<String, dynamic> dhcpSettingsMap = {
      'lastClientIPAddress': '192.168.1.254',
      'leaseMinutes': 1440,
      'reservations': [dhcpReservation.toMap()],
      'firstClientIPAddress': '192.168.1.10',
      'dnsServer1': '8.8.8.8',
      'dnsServer2': '8.8.4.4',
      'dnsServer3': '1.1.1.1',
      'winsServer': '192.168.1.5',
    };

    test('toMap returns a valid map', () {
      expect(dhcpSettings.toMap(), dhcpSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(DHCPSettings.fromMap(dhcpSettingsMap), dhcpSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(dhcpSettings.toJson(), json.encode(dhcpSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DHCPSettings.fromJson(json.encode(dhcpSettingsMap)), dhcpSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = dhcpSettings.copyWith(
        leaseMinutes: 2880,
        dnsServer1: '4.4.4.4',
      );
      expect(updatedSettings.leaseMinutes, 2880);
      expect(updatedSettings.dnsServer1, '4.4.4.4');
      expect(updatedSettings.lastClientIPAddress, dhcpSettings.lastClientIPAddress);
    });

    test('props are correct', () {
      final settings1 = DHCPSettings(
        lastClientIPAddress: 'l1',
        leaseMinutes: 1,
        reservations: [dhcpReservation],
        firstClientIPAddress: 'f1',
      );
      final settings2 = DHCPSettings(
        lastClientIPAddress: 'l1',
        leaseMinutes: 1,
        reservations: [dhcpReservation],
        firstClientIPAddress: 'f1',
      );
      final settings3 = DHCPSettings(
        lastClientIPAddress: 'l2',
        leaseMinutes: 2,
        reservations: [],
        firstClientIPAddress: 'f2',
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });

  group('RouterLANSettings', () {
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

    const routerLANSettings = RouterLANSettings(
      minNetworkPrefixLength: 16,
      maxNetworkPrefixLength: 30,
      minAllowedDHCPLeaseMinutes: 1,
      dhcpSettings: dhcpSettings,
      hostName: 'Linksys00005',
      maxDHCPReservationDescriptionLength: 63,
      isDHCPEnabled: true,
      networkPrefixLength: 24,
      ipAddress: '10.135.1.1',
      maxAllowedDHCPLeaseMinutes: 525600,
    );

    final Map<String, dynamic> routerLANSettingsMap = {
      'minNetworkPrefixLength': 16,
      'maxNetworkPrefixLength': 30,
      'minAllowedDHCPLeaseMinutes': 1,
      'dhcpSettings': dhcpSettings.toMap(),
      'hostName': 'Linksys00005',
      'maxDHCPReservationDescriptionLength': 63,
      'isDHCPEnabled': true,
      'networkPrefixLength': 24,
      'ipAddress': '10.135.1.1',
      'maxAllowedDHCPLeaseMinutes': 525600,
    };

    test('toMap returns a valid map', () {
      expect(routerLANSettings.toMap(), routerLANSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(RouterLANSettings.fromMap(routerLANSettingsMap), routerLANSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(routerLANSettings.toJson(), json.encode(routerLANSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RouterLANSettings.fromJson(json.encode(routerLANSettingsMap)), routerLANSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = routerLANSettings.copyWith(
        hostName: 'NewHost',
        isDHCPEnabled: false,
      );
      expect(updatedSettings.hostName, 'NewHost');
      expect(updatedSettings.isDHCPEnabled, false);
      expect(updatedSettings.ipAddress, routerLANSettings.ipAddress);
    });

    test('props are correct', () {
      final settings1 = RouterLANSettings(
        minNetworkPrefixLength: 1,
        maxNetworkPrefixLength: 2,
        minAllowedDHCPLeaseMinutes: 3,
        dhcpSettings: dhcpSettings,
        hostName: 'h1',
        maxDHCPReservationDescriptionLength: 4,
        isDHCPEnabled: true,
        networkPrefixLength: 5,
        ipAddress: 'i1',
      );
      final settings2 = RouterLANSettings(
        minNetworkPrefixLength: 1,
        maxNetworkPrefixLength: 2,
        minAllowedDHCPLeaseMinutes: 3,
        dhcpSettings: dhcpSettings,
        hostName: 'h1',
        maxDHCPReservationDescriptionLength: 4,
        isDHCPEnabled: true,
        networkPrefixLength: 5,
        ipAddress: 'i1',
      );
      final settings3 = RouterLANSettings(
        minNetworkPrefixLength: 6,
        maxNetworkPrefixLength: 7,
        minAllowedDHCPLeaseMinutes: 8,
        dhcpSettings: dhcpSettings.copyWith(leaseMinutes: 100),
        hostName: 'h2',
        maxDHCPReservationDescriptionLength: 9,
        isDHCPEnabled: false,
        networkPrefixLength: 10,
        ipAddress: 'i2',
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
