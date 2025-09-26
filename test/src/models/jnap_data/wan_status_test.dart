import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';

void main() {
  group('SupportedWANCombination', () {
    const supportedWANCombination = SupportedWANCombination(
      wanType: 'DHCP',
      wanIPv6Type: 'Automatic',
    );

    final Map<String, dynamic> supportedWANCombinationMap = {
      'wanType': 'DHCP',
      'wanIPv6Type': 'Automatic',
    };

    test('toMap returns a valid map', () {
      expect(supportedWANCombination.toMap(), supportedWANCombinationMap);
    });

    test('fromMap creates a valid object', () {
      expect(SupportedWANCombination.fromMap(supportedWANCombinationMap), supportedWANCombination);
    });

    test('toJson returns a valid JSON string', () {
      expect(supportedWANCombination.toJson(), json.encode(supportedWANCombinationMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SupportedWANCombination.fromJson(json.encode(supportedWANCombinationMap)), supportedWANCombination);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedCombination = supportedWANCombination.copyWith(
        wanType: 'Static',
      );
      expect(updatedCombination.wanType, 'Static');
      expect(updatedCombination.wanIPv6Type, supportedWANCombination.wanIPv6Type);
    });

    test('props are correct', () {
      final swc1 = SupportedWANCombination(wanType: 't1', wanIPv6Type: 'i1');
      final swc2 = SupportedWANCombination(wanType: 't1', wanIPv6Type: 'i1');
      final swc3 = SupportedWANCombination(wanType: 't2', wanIPv6Type: 'i2');
      expect(swc1, swc2);
      expect(swc1.props, swc2.props);
      expect(swc1 == swc3, false);
      expect(swc1.props == swc3.props, false);
    });
  });

  group('IPv6NetworkInfo', () {
    const ipv6NetworkInfo = IPv6NetworkInfo(
      ipAddress: '2001:db8::1',
      gateway: '2001:db8::fffe',
      dhcpLeaseMinutes: 1440,
      dnsServer1: '2001:4860:4860::8888',
      dnsServer2: '2001:4860:4860::8844',
      dnsServer3: '2606:4700:4700::1111',
    );

    final Map<String, dynamic> ipv6NetworkInfoMap = {
      'ipAddress': '2001:db8::1',
      'gateway': '2001:db8::fffe',
      'dhcpLeaseMinutes': 1440,
      'dnsServer1': '2001:4860:4860::8888',
      'dnsServer2': '2001:4860:4860::8844',
      'dnsServer3': '2606:4700:4700::1111',
    };

    test('toMap returns a valid map', () {
      expect(ipv6NetworkInfo.toMap(), ipv6NetworkInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(IPv6NetworkInfo.fromMap(ipv6NetworkInfoMap), ipv6NetworkInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(ipv6NetworkInfo.toJson(), json.encode(ipv6NetworkInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(IPv6NetworkInfo.fromJson(json.encode(ipv6NetworkInfoMap)), ipv6NetworkInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = ipv6NetworkInfo.copyWith(
        ipAddress: '2001:db8::2',
      );
      expect(updatedInfo.ipAddress, '2001:db8::2');
      expect(updatedInfo.gateway, ipv6NetworkInfo.gateway);
    });

    test('props are correct', () {
      final ini1 = IPv6NetworkInfo(ipAddress: 'ip1');
      final ini2 = IPv6NetworkInfo(ipAddress: 'ip1');
      final ini3 = IPv6NetworkInfo(ipAddress: 'ip2');
      expect(ini1, ini2);
      expect(ini1.props, ini2.props);
      expect(ini1 == ini3, false);
      expect(ini1.props == ini3.props, false);
    });
  });

  group('WANIPv6ConnectionInfo', () {
    const ipv6NetworkInfo = IPv6NetworkInfo(
      ipAddress: '2001:db8::1',
    );

    const wanIPv6ConnectionInfo = WANIPv6ConnectionInfo(
      wanType: 'Automatic',
      networkInfo: ipv6NetworkInfo,
    );

    final Map<String, dynamic> wanIPv6ConnectionInfoMap = {
      'wanType': 'Automatic',
      'networkInfo': ipv6NetworkInfo.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(wanIPv6ConnectionInfo.toMap(), wanIPv6ConnectionInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(WANIPv6ConnectionInfo.fromMap(wanIPv6ConnectionInfoMap), wanIPv6ConnectionInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(wanIPv6ConnectionInfo.toJson(), json.encode(wanIPv6ConnectionInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WANIPv6ConnectionInfo.fromJson(json.encode(wanIPv6ConnectionInfoMap)), wanIPv6ConnectionInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = wanIPv6ConnectionInfo.copyWith(
        wanType: 'Static',
      );
      expect(updatedInfo.wanType, 'Static');
      expect(updatedInfo.networkInfo, wanIPv6ConnectionInfo.networkInfo);
    });

    test('props are correct', () {
      final wic1 = WANIPv6ConnectionInfo(wanType: 't1', networkInfo: ipv6NetworkInfo);
      final wic2 = WANIPv6ConnectionInfo(wanType: 't1', networkInfo: ipv6NetworkInfo);
      final wic3 = WANIPv6ConnectionInfo(wanType: 't2', networkInfo: null);
      expect(wic1, wic2);
      expect(wic1.props, wic2.props);
      expect(wic1 == wic3, false);
      expect(wic1.props == wic3.props, false);
    });
  });

  group('WANConnectionInfo', () {
    const wanConnectionInfo = WANConnectionInfo(
      wanType: 'DHCP',
      ipAddress: '192.168.1.100',
      networkPrefixLength: 24,
      gateway: '192.168.1.1',
      mtu: 1500,
      dhcpLeaseMinutes: 1440,
      dnsServer1: '8.8.8.8',
      dnsServer2: '8.8.4.4',
      dnsServer3: '1.1.1.1',
    );

    final Map<String, dynamic> wanConnectionInfoMap = {
      'wanType': 'DHCP',
      'ipAddress': '192.168.1.100',
      'networkPrefixLength': 24,
      'gateway': '192.168.1.1',
      'mtu': 1500,
      'dhcpLeaseMinutes': 1440,
      'dnsServer1': '8.8.8.8',
      'dnsServer2': '8.8.4.4',
      'dnsServer3': '1.1.1.1',
    };

    test('toMap returns a valid map', () {
      expect(wanConnectionInfo.toMap(), wanConnectionInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(WANConnectionInfo.fromMap(wanConnectionInfoMap), wanConnectionInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(wanConnectionInfo.toJson(), json.encode(wanConnectionInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WANConnectionInfo.fromJson(json.encode(wanConnectionInfoMap)), wanConnectionInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = wanConnectionInfo.copyWith(
        ipAddress: '192.168.1.101',
      );
      expect(updatedInfo.ipAddress, '192.168.1.101');
      expect(updatedInfo.wanType, wanConnectionInfo.wanType);
    });

    test('props are correct', () {
      final wci1 = WANConnectionInfo(wanType: 't1', ipAddress: 'ip1', networkPrefixLength: 1, gateway: 'g1', mtu: 1, dnsServer1: 'd1');
      final wci2 = WANConnectionInfo(wanType: 't1', ipAddress: 'ip1', networkPrefixLength: 1, gateway: 'g1', mtu: 1, dnsServer1: 'd1');
      final wci3 = WANConnectionInfo(wanType: 't2', ipAddress: 'ip2', networkPrefixLength: 2, gateway: 'g2', mtu: 2, dnsServer1: 'd2');
      expect(wci1, wci2);
      expect(wci1.props, wci2.props);
      expect(wci1 == wci3, false);
      expect(wci1.props == wci3.props, false);
    });
  });

  group('RouterWANStatus', () {
    const wanConnectionInfo = WANConnectionInfo(
      wanType: 'DHCP',
      ipAddress: '192.168.1.100',
      networkPrefixLength: 24,
      gateway: '192.168.1.1',
      mtu: 1500,
      dnsServer1: '8.8.8.8',
    );
    const ipv6NetworkInfo = IPv6NetworkInfo(
      ipAddress: '2001:db8::1',
    );
    const wanIPv6ConnectionInfo = WANIPv6ConnectionInfo(
      wanType: 'Automatic',
      networkInfo: ipv6NetworkInfo,
    );
    const supportedWANCombination = SupportedWANCombination(
      wanType: 'DHCP',
      wanIPv6Type: 'Automatic',
    );

    const routerWANStatus = RouterWANStatusData(
      macAddress: '00:11:22:33:44:55',
      detectedWANType: 'DHCP',
      wanStatus: 'Connected',
      wanIPv6Status: 'Connected',
      wanConnection: wanConnectionInfo,
      wanIPv6Connection: wanIPv6ConnectionInfo,
      supportedWANTypes: ['DHCP', 'Static'],
      supportedIPv6WANTypes: ['Automatic'],
      supportedWANCombinations: [supportedWANCombination],
    );

    final Map<String, dynamic> routerWANStatusMap = {
      'macAddress': '00:11:22:33:44:55',
      'detectedWANType': 'DHCP',
      'wanStatus': 'Connected',
      'wanIPv6Status': 'Connected',
      'wanConnection': wanConnectionInfo.toMap(),
      'wanIPv6Connection': wanIPv6ConnectionInfo.toMap(),
      'supportedWANTypes': ['DHCP', 'Static'],
      'supportedIPv6WANTypes': ['Automatic'],
      'supportedWANCombinations': [supportedWANCombination.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(routerWANStatus.toMap(), routerWANStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(RouterWANStatusData.fromMap(routerWANStatusMap), routerWANStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(routerWANStatus.toJson(), json.encode(routerWANStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RouterWANStatusData.fromJson(json.encode(routerWANStatusMap)), routerWANStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = routerWANStatus.copyWith(
        wanStatus: 'Disconnected',
      );
      expect(updatedStatus.wanStatus, 'Disconnected');
      expect(updatedStatus.macAddress, routerWANStatus.macAddress);
    });

    test('props are correct', () {
      final rws1 = RouterWANStatusData(
        macAddress: 'm1',
        detectedWANType: 'd1',
        wanStatus: 's1',
        wanIPv6Status: 'is1',
        supportedWANTypes: ['t1'],
        supportedIPv6WANTypes: ['it1'],
        supportedWANCombinations: [supportedWANCombination],
      );
      final rws2 = RouterWANStatusData(
        macAddress: 'm1',
        detectedWANType: 'd1',
        wanStatus: 's1',
        wanIPv6Status: 'is1',
        supportedWANTypes: ['t1'],
        supportedIPv6WANTypes: ['it1'],
        supportedWANCombinations: [supportedWANCombination],
      );
      final rws3 = RouterWANStatusData(
        macAddress: 'm2',
        detectedWANType: 'd2',
        wanStatus: 's2',
        wanIPv6Status: 'is2',
        supportedWANTypes: ['t2'],
        supportedIPv6WANTypes: ['it2'],
        supportedWANCombinations: [],
      );

      expect(rws1, rws2);
      expect(rws1.props, rws2.props);
      expect(rws1 == rws3, false);
      expect(rws1.props == rws3.props, false);
    });
  });
}
