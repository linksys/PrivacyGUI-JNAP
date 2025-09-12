import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/dhcp_lease.dart';

void main() {
  group('DhcpLeaseData', () {
    const dhcpLease = DhcpLeaseData(
      macAddress: '00:11:22:33:44:55',
      ipAddress: '192.168.1.100',
      expiration: '2023-01-01T12:00:00Z',
      hostName: 'mydevice',
      clientID: 'client123',
    );

    final Map<String, dynamic> dhcpLeaseMap = {
      'macAddress': '00:11:22:33:44:55',
      'ipAddress': '192.168.1.100',
      'expiration': '2023-01-01T12:00:00Z',
      'hostName': 'mydevice',
      'clientID': 'client123',
    };

    test('toMap returns a valid map', () {
      expect(dhcpLease.toMap(), dhcpLeaseMap);
    });

    test('fromMap creates a valid object', () {
      expect(DhcpLeaseData.fromMap(dhcpLeaseMap), dhcpLease);
    });

    test('toJson returns a valid JSON string', () {
      expect(dhcpLease.toJson(), json.encode(dhcpLeaseMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DhcpLeaseData.fromJson(json.encode(dhcpLeaseMap)), dhcpLease);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedLease = dhcpLease.copyWith(
        ipAddress: '192.168.1.101',
        hostName: 'newdevice',
      );
      expect(updatedLease.ipAddress, '192.168.1.101');
      expect(updatedLease.hostName, 'newdevice');
      expect(updatedLease.macAddress, dhcpLease.macAddress);
    });

    test('props are correct', () {
      final lease1 = DhcpLeaseData(
        macAddress: 'mac1',
        ipAddress: 'ip1',
        expiration: 'exp1',
        clientID: 'client1',
      );
      final lease2 = DhcpLeaseData(
        macAddress: 'mac1',
        ipAddress: 'ip1',
        expiration: 'exp1',
        clientID: 'client1',
      );
      final lease3 = DhcpLeaseData(
        macAddress: 'mac2',
        ipAddress: 'ip2',
        expiration: 'exp2',
        clientID: 'client2',
      );

      expect(lease1, lease2);
      expect(lease1.props, lease2.props);
      expect(lease1 == lease3, false);
      expect(lease1.props == lease3.props, false);
    });
  });
}