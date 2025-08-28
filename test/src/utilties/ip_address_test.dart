import 'package:jnap/src/utilties/ip_address.dart';
import 'package:test/test.dart';

void main() {
  group('IpAddressUtils', () {
    group('isValidIpAddress', () {
      test('should return true for valid IP addresses', () {
        expect(IpAddressUtils.isValidIpAddress('192.168.1.1'), isTrue);
        expect(IpAddressUtils.isValidIpAddress('0.0.0.0'), isTrue);
        expect(IpAddressUtils.isValidIpAddress('255.255.255.255'), isTrue);
      });

      test('should return false for invalid IP addresses', () {
        expect(IpAddressUtils.isValidIpAddress('192.168.1'), isFalse);
        expect(IpAddressUtils.isValidIpAddress('192.168.1.256'), isFalse);
        expect(IpAddressUtils.isValidIpAddress('192.168.1.-1'), isFalse);
        expect(IpAddressUtils.isValidIpAddress('abc.def.ghi.jkl'), isFalse);
        expect(IpAddressUtils.isValidIpAddress('192.168.1.1.2'), isFalse);
      });
    });

    group('ipToNum', () {
      test('should convert IP address to integer correctly', () {
        expect(IpAddressUtils.ipToNum('0.0.0.0'), 0);
        expect(IpAddressUtils.ipToNum('192.168.1.1'), 3232235777);
        expect(IpAddressUtils.ipToNum('255.255.255.255'), 4294967295);
      });

      test('should return 0 for invalid IP addresses', () {
        expect(IpAddressUtils.ipToNum('invalid'), 0);
        expect(IpAddressUtils.ipToNum('192.168.1'), 0);
      });
    });

    group('numToIp', () {
      test('should convert integer to IP address correctly', () {
        expect(IpAddressUtils.numToIp(0), '0.0.0.0');
        expect(IpAddressUtils.numToIp(3232235777), '192.168.1.1');
        expect(IpAddressUtils.numToIp(4294967295), '255.255.255.255');
      });

      test('should return 0.0.0.0 for out of range numbers', () {
        expect(IpAddressUtils.numToIp(-1), '0.0.0.0');
        expect(IpAddressUtils.numToIp(4294967296), '0.0.0.0');
      });
    });

    group('ipInRange', () {
      test('should return true if IP is within range', () {
        expect(IpAddressUtils.ipInRange('192.168.1.5', '192.168.1.1', '192.168.1.10'), isTrue);
        expect(IpAddressUtils.ipInRange('192.168.1.1', '192.168.1.1', '192.168.1.10'), isTrue);
        expect(IpAddressUtils.ipInRange('192.168.1.10', '192.168.1.1', '192.168.1.10'), isTrue);
      });

      test('should return false if IP is outside range', () {
        expect(IpAddressUtils.ipInRange('192.168.1.0', '192.168.1.1', '192.168.1.10'), isFalse);
        expect(IpAddressUtils.ipInRange('192.168.1.11', '192.168.1.1', '192.168.1.10'), isFalse);
      });

      test('should throw ArgumentError for invalid IP addresses', () {
        expect(() => IpAddressUtils.ipInRange('invalid', '192.168.1.1', '192.168.1.10'), throwsArgumentError);
        expect(() => IpAddressUtils.ipInRange('192.168.1.1', 'invalid', '192.168.1.10'), throwsArgumentError);
        expect(() => IpAddressUtils.ipInRange('192.168.1.1', '192.168.1.1', 'invalid'), throwsArgumentError);
      });

      test('should throw ArgumentError if min is greater than max', () {
        expect(() => IpAddressUtils.ipInRange('192.168.1.5', '192.168.1.10', '192.168.1.1'), throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Range error')));
      });
    });

    group('isValidSubnetMask', () {
      test('should return true for valid subnet masks', () {
        expect(IpAddressUtils.isValidSubnetMask('255.255.255.0'), isTrue);
        expect(IpAddressUtils.isValidSubnetMask('255.255.255.255'), isFalse);
        expect(IpAddressUtils.isValidSubnetMask('0.0.0.0'), isFalse);
      });

      test('should return false for invalid subnet masks', () {
        expect(IpAddressUtils.isValidSubnetMask('255.255.255.1'), isFalse);
        expect(IpAddressUtils.isValidSubnetMask('192.168.1.1'), isFalse);
        expect(IpAddressUtils.isValidSubnetMask('invalid'), isFalse);
      });

      test('should throw FormatException for invalid min/max network prefix length', () {
        expect(() => IpAddressUtils.isValidSubnetMask('255.255.255.0', minNetworkPrefixLength: 0), throwsFormatException);
        expect(() => IpAddressUtils.isValidSubnetMask('255.255.255.0', maxNetworkPrefixLength: 32), throwsFormatException);
        expect(() => IpAddressUtils.isValidSubnetMask('255.255.255.0', minNetworkPrefixLength: 10, maxNetworkPrefixLength: 8), throwsFormatException);
      });
    });

    group('getIpPrefix', () {
      test('should return correct IP prefix', () {
        expect(IpAddressUtils.getIpPrefix('192.168.1.10', '255.255.255.0'), '192.168.1.0');
        expect(IpAddressUtils.getIpPrefix('10.0.0.5', '255.0.0.0'), '10.0.0.0');
      });

      test('should throw ArgumentError for invalid IP or subnet mask', () {
        expect(() => IpAddressUtils.getIpPrefix('invalid', '255.255.255.0'), throwsArgumentError);
        expect(() => IpAddressUtils.getIpPrefix('192.168.1.1', 'invalid'), throwsArgumentError);
      });
    });

    group('prefixLengthToSubnetMask', () {
      test('should convert prefix length to subnet mask correctly', () {
        expect(IpAddressUtils.prefixLengthToSubnetMask(24), '255.255.255.0');
        expect(IpAddressUtils.prefixLengthToSubnetMask(8), '255.0.0.0');
        expect(IpAddressUtils.prefixLengthToSubnetMask(32), '255.255.255.255');
      });
    });

    group('subnetMaskToPrefixLength', () {
      test('should convert subnet mask to prefix length correctly', () {
        expect(IpAddressUtils.subnetMaskToPrefixLength('255.255.255.0'), 24);
        expect(IpAddressUtils.subnetMaskToPrefixLength('255.0.0.0'), 8);
        expect(IpAddressUtils.subnetMaskToPrefixLength('255.255.255.255'), 32);
      });

      test('should throw Exception for invalid subnet mask', () {
        expect(() => IpAddressUtils.subnetMaskToPrefixLength('255.255.255.1'), throwsException);
      });
    });

    group('isRouterIPInDHCPRange', () {
      test('should return true if router IP is in DHCP range with lastClientIPAddress', () {
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.1', '192.168.1.1', '192.168.1.10'), isTrue);
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.5', '192.168.1.1', '192.168.1.10'), isTrue);
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.10', '192.168.1.1', '192.168.1.10'), isTrue);
      });

      test('should return false if router IP is not in DHCP range with lastClientIPAddress', () {
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.0', '192.168.1.1', '192.168.1.10'), isFalse);
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.11', '192.168.1.1', '192.168.1.10'), isFalse);
      });

      test('should return true if router IP is in DHCP range with maxUsers', () {
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.1', '192.168.1.1', null, 10), isTrue);
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.5', '192.168.1.1', null, 10), isTrue);
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.10', '192.168.1.1', null, 10), isTrue);
      });

      test('should return false if router IP is not in DHCP range with maxUsers', () {
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.0', '192.168.1.1', null, 10), isFalse);
        expect(IpAddressUtils.isRouterIPInDHCPRange('192.168.1.11', '192.168.1.1', null, 10), isFalse);
      });
    });

    group('getMaxUserAllowedInDHCPRange', () {
      test('should return correct max users allowed in DHCP range', () {
        expect(IpAddressUtils.getMaxUserAllowedInDHCPRange('192.168.1.1', '192.168.1.1', '192.168.1.10'), 10);
        expect(IpAddressUtils.getMaxUserAllowedInDHCPRange('192.168.1.0', '192.168.1.1', '192.168.1.10'), 10);
        expect(IpAddressUtils.getMaxUserAllowedInDHCPRange('192.168.1.11', '192.168.1.1', '192.168.1.10'), 10);
      });
    });

    group('getEndDHCPRangeForMaxUsers', () {
      test('should return correct end DHCP range for max users', () {
        expect(IpAddressUtils.getEndDHCPRangeForMaxUsers('192.168.1.1', 10), '192.168.1.10');
        expect(IpAddressUtils.getEndDHCPRangeForMaxUsers('192.168.1.250', 10), '192.168.2.3');
      });
    });

    group('getEndingIpAddress', () {
      test('should return correct ending IP address', () {
        expect(IpAddressUtils.getEndingIpAddress('192.168.1.1', '192.168.1.1', 10), '192.168.1.10');
        expect(IpAddressUtils.getEndingIpAddress('192.168.1.5', '192.168.1.1', 10), '192.168.1.10');
        expect(IpAddressUtils.getEndingIpAddress('192.168.1.11', '192.168.1.1', 10), '192.168.1.10');
      });
    });

    group('getMaxUserLimit', () {
      test('should return correct max user limit', () {
        expect(IpAddressUtils.getMaxUserLimit('192.168.1.1', '192.168.1.100', '255.255.255.0', 100), 155);
        expect(IpAddressUtils.getMaxUserLimit('10.0.0.1', '10.0.0.10', '255.0.0.0', 10), 16777205);
      });
    });

    group('isMtuValid', () {
      test('should return true for valid MTU values', () {
        expect(IpAddressUtils.isMtuValid('dhcp', 1000), isTrue);
        expect(IpAddressUtils.isMtuValid('pppoe', 1492), isTrue);
        expect(IpAddressUtils.isMtuValid('static', 576), isTrue);
        expect(IpAddressUtils.isMtuValid('pptp', 1460), isTrue);
        expect(IpAddressUtils.isMtuValid('l2tp', 1460), isTrue);
        expect(IpAddressUtils.isMtuValid('dhcp', 0), isTrue);
      });

      test('should return false for invalid MTU values', () {
        expect(IpAddressUtils.isMtuValid('dhcp', 500), isFalse);
        expect(IpAddressUtils.isMtuValid('pppoe', 1500), isFalse);
        expect(IpAddressUtils.isMtuValid('unknown', 1000), isFalse);
      });
    });

    group('getMinMtu', () {
      test('should return correct minimum MTU for WAN types', () {
        expect(IpAddressUtils.getMinMtu('dhcp'), 576);
        expect(IpAddressUtils.getMinMtu('pppoe'), 576);
        expect(IpAddressUtils.getMinMtu('static'), 576);
        expect(IpAddressUtils.getMinMtu('pptp'), 576);
        expect(IpAddressUtils.getMinMtu('l2tp'), 576);
        expect(IpAddressUtils.getMinMtu('unknown'), 0);
      });
    });

    group('getMaxMtu', () {
      test('should return correct maximum MTU for WAN types', () {
        expect(IpAddressUtils.getMaxMtu('dhcp'), 1500);
        expect(IpAddressUtils.getMaxMtu('pppoe'), 1492);
        expect(IpAddressUtils.getMaxMtu('static'), 1500);
        expect(IpAddressUtils.getMaxMtu('pptp'), 1460);
        expect(IpAddressUtils.getMaxMtu('l2tp'), 1460);
        expect(IpAddressUtils.getMaxMtu('unknown'), 0);
      });
    });
  });
}
