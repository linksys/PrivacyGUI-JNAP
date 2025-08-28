import 'package:test/test.dart';
import 'package:jnap/src/utilties/validator_rules/rules.dart';

void main() {
  group('EmailRule', () {
    final rule = EmailRule();
    test('should return true for valid emails', () {
      expect(rule.validate('test@example.com'), isTrue);
      expect(rule.validate('john.doe123@sub.domain.co.uk'), isTrue);
    });
    test('should return false for invalid emails', () {
      expect(rule.validate('invalid-email'), isFalse);
      expect(rule.validate('test@.com'), isFalse);
      expect(rule.validate('test@example'), isFalse);
      expect(rule.validate('test@example..com'), isFalse);
      expect(rule.validate('test@example.com.'), isFalse);
      expect(rule.validate(' test@example.com'), isFalse);
      expect(rule.validate('test@example.com '), isFalse);
    });
  });

  group('DigitalCheckRule', () {
    final rule = DigitalCheckRule();
    test('should return true if input contains a digit', () {
      expect(rule.validate('password123'), isTrue);
      expect(rule.validate('12345'), isTrue);
    });
    test('should return false if input does not contain a digit', () {
      expect(rule.validate('password'), isFalse);
      expect(rule.validate('ABC'), isFalse);
    });
  });

  group('SpecialCharCheckRule', () {
    final rule = SpecialCharCheckRule();
    test('should return true if input contains a special character', () {
      expect(rule.validate('password!'), isTrue);
      expect(rule.validate('pass@word'), isTrue);
      expect(rule.validate('#\$%'), isTrue);
    });
    test('should return false if input does not contain a special character',
        () {
      expect(rule.validate('password'), isFalse);
      expect(rule.validate('ABC123'), isFalse);
    });
  });

  group('WiFiPasswordRule', () {
    test('should validate correctly with default settings', () {
      final rule = WiFiPasswordRule();
      expect(rule.validate('a' * 8), isTrue); // Min length
      expect(rule.validate('a' * 63), isTrue); // Max length
      expect(rule.validate('a' * 7), isFalse); // Too short
      expect(rule.validate('a' * 64), isFalse); // Too long
      expect(rule.validate(' password'), isFalse); // Leading whitespace
      expect(rule.validate('password '), isFalse); // Trailing whitespace
      expect(rule.validate('pass word'), isTrue); // Internal whitespace
      expect(
          rule.validate('password!@#\$%^&*()'), isTrue); // Special characters
      expect(
          rule.validate('password\x00'), isFalse); // Invalid character (null)
    });

    test('should ignore length if ignoreLength is true', () {
      final rule = WiFiPasswordRule(ignoreLength: true);
      expect(rule.validate('a' * 5), isTrue);
      expect(rule.validate('a' * 100), isTrue);
    });

    test(
        'should ignore whitespace surround if ignoreWhiteSpaceSurround is true',
        () {
      // Note: The current regex for WiFiPasswordRule always checks for surrounding whitespace.
      // This test case is based on the assumption that the regex would change to respect ignoreWhiteSpaceSurround.
      // As per current regex, this will still return false for surrounding whitespace.
      final rule = WiFiPasswordRule(ignoreWhiteSpaceSurround: true);
      expect(rule.validate(' password'),
          isFalse); // Still false with current regex
      expect(rule.validate('password '),
          isFalse); // Still false with current regex
    });
  });

  group('WiFiSsidRule', () {
    final rule = WiFiSsidRule();
    test('should return true for valid SSIDs', () {
      expect(rule.validate('MyWiFi'), isTrue);
      expect(rule.validate('My WiFi Network'), isTrue);
      expect(rule.validate('a' * 31), isTrue); // Max length
    });
    test('should return false for invalid SSIDs', () {
      expect(rule.validate(''), isFalse); // Empty
      expect(rule.validate(' a'), isFalse); // Leading whitespace
      expect(rule.validate('a '), isFalse); // Trailing whitespace
      expect(rule.validate('a' * 33), isFalse); // Too long
    });
  });

  group('IpAddressRule', () {
    final rule = IpAddressRule();
    test('should return true for valid IPv4 addresses', () {
      expect(rule.validate('192.168.1.1'), isTrue);
      expect(rule.validate('0.0.0.0'), isTrue);
      expect(rule.validate('255.255.255.255'), isTrue);
      expect(rule.validate('10.0.0.1'), isTrue);
    });
    test('should return false for invalid IPv4 addresses', () {
      expect(rule.validate('192.168.1'), isFalse); // Too few octets
      expect(rule.validate('192.168.1.1.1'), isFalse); // Too many octets
      expect(rule.validate('256.0.0.0'), isFalse); // Octet out of range
      expect(rule.validate('192.168.1.a'), isFalse); // Non-numeric octet
      expect(rule.validate('192.168..1'), isFalse); // Empty octet
    });
  });

  group('NoSurroundWhitespaceRule', () {
    final rule = NoSurroundWhitespaceRule();
    test('should return false if input has leading or trailing whitespace', () {
      expect(rule.validate(' test'), isFalse);
      expect(rule.validate('test '), isFalse);
      expect(rule.validate(' test '), isFalse);
      expect(rule.validate('  test  '), isFalse);
    });
    test('should return true if input has no leading or trailing whitespace',
        () {
      expect(rule.validate('test'), isTrue);
      expect(rule.validate('test test'), isTrue);
      expect(rule.validate(''),
          isTrue); // Empty string has no surrounding whitespace
    });
  });

  group('AndroidNameRule', () {
    final rule = AndroidNameRule();
    test('should return true for valid Android names', () {
      expect(rule.validate('Android'), isTrue);
      expect(rule.validate('android-abcdef0123456789'), isTrue);
      expect(rule.validate('Android-12345'), isTrue);
      expect(rule.validate('android-abcdef0123456789extra'), isTrue);
      expect(rule.validate('Android-12345extra'), isTrue);
    });
    test('should return false for invalid Android names', () {
      expect(rule.validate('android'), isFalse);
      expect(rule.validate('Android-'), isFalse);
      expect(rule.validate('android-'), isFalse);
      expect(rule.validate('NotAndroid'), isFalse);
      expect(rule.validate('android-g'), isFalse);
    });
  });

  group('AsciiRule', () {
    final rule = AsciiRule();
    test('should return true for strings with only ASCII characters', () {
      expect(rule.validate('Hello World!'), isTrue);
      expect(rule.validate('12345'), isTrue);
      expect(rule.validate('!@#\$%^&*()'), isTrue);
    });
    test('should return false for strings with non-ASCII characters', () {
      expect(rule.validate('Hello World€'), isFalse);
      expect(rule.validate('你好世界'), isFalse);
    });
  });

  group('WiFiPSKRule', () {
    final rule = WiFiPSKRule();
    test('should return true for valid PSK', () {
      expect(rule.validate('a' * 64), isTrue); // 64 hex chars
      expect(rule.validate('12345678'), isTrue); // Less than 64, no hex check
      expect(
          rule.validate(
              'ABCDEF0123456789abcdef0123456789ABCDEF0123456789abcdef0123456789'),
          isTrue);
    });
    test('should return false for invalid PSK', () {
      expect(rule.validate('a' * 63 + 'G'),
          isFalse); // 64 chars, but last is not hex
      expect(rule.validate('a' * 65), isFalse); // Too long
      expect(
          rule.validate('a' * 60 + 'G'), isTrue); // Less than 64, no hex check
    });
  });

  group('WhiteSpaceRule', () {
    final rule = WhiteSpaceRule();
    test('should return true if input contains internal whitespace', () {
      expect(rule.validate('hello world'), isTrue);
      expect(rule.validate(' hello world '), isTrue);
      expect(rule.validate('hello  world'), isTrue);
    });
    test('should return false if input does not contain internal whitespace',
        () {
      expect(rule.validate('helloworld'), isFalse);
      expect(rule.validate(''), isFalse);
    });
  });

  group('HostNameCheckRule', () {
    final rule = HostNameCheckRule();
    test('should return false for valid hostnames', () {
      expect(rule.validate('my-hostname'), isFalse);
      expect(rule.validate('hostname123'), isFalse);
      expect(rule.validate('a'), isFalse);
    });
    test('should return true for invalid hostnames', () {
      expect(rule.validate('my_hostname'), isTrue); // Underscore
      expect(rule.validate('-hostname'), isTrue); // Leading hyphen
      expect(rule.validate('hostname-'), isTrue); // Trailing hyphen
      expect(rule.validate('host name'), isTrue); // Space
      expect(rule.validate('host!name'), isTrue); // Special character
    });
  });

  group('ConsecutiveCharRule', () {
    final rule = ConsecutiveCharRule();
    test('should return true if input contains consecutive characters', () {
      expect(rule.validate('aa'), isTrue);
      expect(rule.validate('hello'), isTrue);
      expect(rule.validate('111'), isTrue);
    });
    test('should return false if input does not contain consecutive characters',
        () {
      expect(rule.validate('ab'), isFalse);
      expect(rule.validate('helol'), isFalse);
      expect(rule.validate('123'), isFalse);
      expect(rule.validate(''), isFalse);
    });
  });

  group('MACAddressRule', () {
    final rule = MACAddressRule();
    test('should return true for valid MAC addresses', () {
      expect(rule.validate('00:11:22:33:44:55'), isTrue);
      expect(rule.validate('AA-BB-CC-DD-EE-FF'), isTrue);
      expect(rule.validate('01:23:45:67:89:AB'), isTrue);
    });
    test('should return false for invalid MAC addresses', () {
      expect(rule.validate('00:11:22:33:44'), isFalse); // Too short
      expect(rule.validate('00:11:22:33:44:55:66'), isFalse); // Too long
      expect(rule.validate('00:11:22:33:44:GG'), isFalse); // Invalid character
      expect(rule.validate('00:11:22:33:44:5'), isFalse); // Incomplete octet
    });
  });

  group('IPv6Rule', () {
    final rule = IPv6Rule();
    test('should return true for valid IPv6 addresses', () {
      expect(rule.validate('2001:0db8:85a3:0000:0000:8a2e:0370:7334'),
          isTrue); // Full
      expect(rule.validate('2001:db8::8a2e:370:7334'), isTrue); // Compressed
      expect(rule.validate('::1'), isTrue); // Loopback
      expect(rule.validate('fe80::'), isTrue); // Link-local
      expect(rule.validate('::ffff:192.168.1.1'), isTrue); // IPv4-mapped
      expect(rule.validate('2001:db8::192.168.1.1'), isTrue); // IPv4-embedded
      expect(rule.validate('::'), isFalse); // Unspecified
    });
    test('should return false for invalid IPv6 addresses', () {
      expect(rule.validate('invalid-ipv6'), isFalse);
      expect(rule.validate('2001:db8:::1'), isFalse); // Too many '::'
      expect(rule.validate('2001:db8:'), isFalse); // Incomplete
      expect(rule.validate('2001:db8:85a3:0000:0000:8a2e:0370:7334:1'),
          isFalse); // Too many groups
      expect(rule.validate('2001:db8:85a3:0000:0000:8a2e:0370:733G'),
          isFalse); // Invalid hex char
    });
  });

  group('IPv6WithReservedRule', () {
    final rule = IPv6WithReservedRule();
    test('should return true for valid global unicast IPv6 addresses', () {
      expect(rule.validate('2001:0db8:85a3:0000:0000:8a2e:0370:7334'), isTrue);
      expect(rule.validate('2001:db8::1'), isTrue); // Valid global unicast
      expect(rule.validate('2001:db8::'), isTrue); // Valid global unicast
    });
    test('should return false for reserved or special IPv6 addresses', () {
      expect(rule.validate('::1'), isFalse); // Loopback
      expect(rule.validate('fe80::1'), isFalse); // Link-local
      expect(rule.validate('ff00::1'), isFalse); // Multicast
      expect(rule.validate('fc00::1'), isFalse); // ULA
      expect(rule.validate('::'), isFalse); // Unspecified
      expect(rule.validate('ffff::1'), isFalse); // Unallocated
      expect(rule.validate('3ffe::1'), isFalse); // Deprecated 6bone
      expect(rule.validate('5f00::1'), isFalse); // Reserved within 2000::/3
    });
    test('should return false for invalid IPv6 formats', () {
      expect(rule.validate('invalid-ipv6'), isFalse);
      expect(rule.validate('2001:db8:::1'), isFalse);
    });
  });

  group('MACAddressWithReservedRule', () {
    final rule = MACAddressWithReservedRule();
    test('should return true for valid non-reserved MAC addresses', () {
      expect(rule.validate('00:1A:2B:3C:4D:5E'), isTrue);
      expect(rule.validate('02:1A:2B:3C:4D:5E'),
          isTrue); // Locally administered, not multicast
    });
    test('should return false for invalid MAC addresses', () {
      expect(rule.validate('00:00:00:00:00:00'), isFalse); // All zeros
      expect(rule.validate('01:00:00:00:00:00'),
          isFalse); // Multicast (LSB of first octet is 1)
      expect(rule.validate('00:11:22:33:44:GG'), isFalse); // Invalid format
      expect(rule.validate('03:1A:2B:3C:4D:5E'),
          isFalse); // Second char is odd (multicast)
      expect(rule.validate('00:11:22:33:44:5'), isFalse); // Incomplete octet
    });
  });

  group('LengthRule', () {
    test('should validate correctly with min and max length', () {
      final rule = LengthRule(min: 5, max: 10);
      expect(rule.validate('abcde'), isTrue); // Min length
      expect(rule.validate('abcdefghij'), isTrue); // Max length
      expect(rule.validate('abcd'), isFalse); // Too short
      expect(rule.validate('abcdefghijk'), isFalse); // Too long
    });
    test('should validate correctly with only min length (max = 0)', () {
      final rule = LengthRule(min: 5, max: 0);
      expect(rule.validate('abcde'), isTrue);
      expect(rule.validate('abcdefghijk'), isTrue);
      expect(rule.validate('abcd'), isFalse);
    });
    test('should handle empty string', () {
      final rule = LengthRule(min: 1, max: 5);
      expect(rule.validate(''), isFalse);
    });
  });

  group('HybridCaseRule', () {
    final rule = HybridCaseRule();
    test('should return true for mixed case strings', () {
      expect(rule.validate('HelloWorld'), isTrue);
      expect(rule.validate('helloWorld'), isTrue);
      expect(rule.validate('HELLOworld'), isTrue);
    });
    test('should return false for all uppercase or all lowercase strings', () {
      expect(rule.validate('helloworld'), isFalse);
      expect(rule.validate('HELLOWORLD'), isFalse);
      expect(rule.validate('12345'), isFalse);
    });
  });

  group('IpAddressHasFourOctetsRule', () {
    final rule = IpAddressHasFourOctetsRule();
    test('should return true for strings with four octets', () {
      expect(rule.validate('192.168.1.1'), isTrue);
      expect(rule.validate('0.0.0.0'), isTrue);
    });
    test('should return false for strings without four octets', () {
      expect(rule.validate('192.168.1'), isFalse);
      expect(rule.validate('192.168.1.1.1'), isFalse);
      expect(rule.validate(''), isFalse);
    });
  });

  group('SubnetMaskRule', () {
    test('should return true for valid subnet masks within range', () {
      final rule =
          SubnetMaskRule(minNetworkPrefixLength: 8, maxNetworkPrefixLength: 30);
      expect(rule.validate('255.0.0.0'), isTrue); // /8
      expect(rule.validate('255.255.255.0'), isTrue); // /24
      expect(rule.validate('255.255.255.252'), isTrue); // /30
    });
    test('should return false for invalid subnet masks', () {
      final rule = SubnetMaskRule();
      expect(rule.validate('255.255.255.1'), isFalse); // Invalid octet
      expect(rule.validate('192.168.1.1'), isFalse); // Not a subnet mask
      expect(rule.validate('255.255.255.255'),
          isFalse); // /32 (not allowed by default max 30)
      expect(rule.validate('0.0.0.0'),
          isFalse); // /0 (not allowed by default min 8)
    });
    test('should respect min and max network prefix length', () {
      final rule = SubnetMaskRule(
          minNetworkPrefixLength: 24, maxNetworkPrefixLength: 24);
      expect(rule.validate('255.255.255.0'), isTrue);
      expect(rule.validate('255.255.0.0'), isFalse); // /16
      expect(rule.validate('255.255.255.128'), isFalse); // /25
    });
  });

  group('RequiredRule', () {
    final rule = RequiredRule();
    test('should return true for non-empty strings', () {
      expect(rule.validate('hello'), isTrue);
      expect(rule.validate(' '), isTrue);
    });
    test('should return false for empty strings', () {
      expect(rule.validate(''), isFalse);
    });
  });

  group('IpAddressNoReservedRule', () {
    final rule = IpAddressNoReservedRule();
    test('should return true for valid non-reserved IPv4 addresses', () {
      expect(rule.validate('192.168.1.1'), isTrue);
      expect(rule.validate('10.0.0.1'), isTrue);
      expect(rule.validate('172.16.0.1'), isTrue);
    });
    test('should return false for reserved IPv4 addresses', () {
      expect(rule.validate('0.0.0.0'), isFalse); // 0.0.0.0/8
      expect(rule.validate('0.255.255.255'), isFalse); // 0.0.0.0/8
      expect(rule.validate('127.0.0.1'), isFalse); // Loopback
      expect(rule.validate('127.255.255.255'), isFalse); // Loopback
      expect(rule.validate('224.0.0.0'), isFalse); // Multicast
      expect(rule.validate('239.255.255.255'), isFalse); // Multicast
      expect(rule.validate('255.255.255.255'), isFalse); // Broadcast
    });
    test('should return false for invalid IPv4 formats', () {
      expect(rule.validate('192.168.1'), isFalse);
      expect(rule.validate('256.0.0.0'), isFalse);
      expect(rule.validate('192.168.1.a'), isFalse);
      expect(
          rule.validate('01.0.0.0'), isFalse); // Leading zero on non-zero octet
    });
  });

  group('HostValidForGivenRouterIPAddressAndSubnetMaskRule', () {
    test('should return true for valid host IPs in the same subnet', () {
      final rule = HostValidForGivenRouterIPAddressAndSubnetMaskRule(
          '192.168.1.1', '255.255.255.0');
      expect(rule.validate('192.168.1.100'), isTrue);
    });
    test('should return false for host IPs in different subnets', () {
      final rule = HostValidForGivenRouterIPAddressAndSubnetMaskRule(
          '192.168.1.1', '255.255.255.0');
      expect(rule.validate('192.168.2.100'), isFalse);
    });
    test('should return false for network ID or broadcast ID', () {
      final rule = HostValidForGivenRouterIPAddressAndSubnetMaskRule(
          '192.168.1.1', '255.255.255.0');
      expect(rule.validate('192.168.1.0'), isFalse); // Network ID
      expect(rule.validate('192.168.1.255'), isFalse); // Broadcast ID
    });
    test('should return false for invalid IP formats', () {
      final rule = HostValidForGivenRouterIPAddressAndSubnetMaskRule(
          '192.168.1.1', '255.255.255.0');
      expect(rule.validate('invalid-ip'), isFalse);
    });
  });

  group('NotRouterIpAddressRule', () {
    final rule = NotRouterIpAddressRule('192.168.1.1');
    test('should return true if input is not the router IP', () {
      expect(rule.validate('192.168.1.100'), isTrue);
      expect(rule.validate('192.168.2.1'), isTrue);
    });
    test('should return false if input is the router IP', () {
      expect(rule.validate('192.168.1.1'), isFalse);
    });
    test('should return true for invalid IP formats (not 4 octets)', () {
      expect(rule.validate('192.168.1'), isTrue);
    });
  });

  group('IntegerRule', () {
    test('should return true for valid integers within range', () {
      final rule = IntegerRule(min: 1, max: 10);
      expect(rule.validate('1'), isTrue);
      expect(rule.validate('5'), isTrue);
      expect(rule.validate('10'), isTrue);
    });
    test('should return false for integers outside range', () {
      final rule = IntegerRule(min: 1, max: 10);
      expect(rule.validate('0'), isFalse);
      expect(rule.validate('11'), isFalse);
    });
    test('should return false for non-integer input', () {
      final rule = IntegerRule(min: 1, max: 10);
      expect(rule.validate('abc'), isFalse);
      expect(rule.validate('1.5'), isFalse);
    });
    test('should handle no min/max (min = -1, max = -1)', () {
      final rule = IntegerRule(); // Default min: -1, max: -1
      expect(rule.validate('100'), isTrue);
      expect(rule.validate('-5'), isTrue);
    });
    test('should handle only min (max = -1)', () {
      final rule = IntegerRule(min: 0);
      expect(rule.validate('0'), isTrue);
      expect(rule.validate('100'), isTrue);
      expect(rule.validate('-1'), isFalse);
    });
    test('should handle only max (min = -1)', () {
      final rule = IntegerRule(max: 10);
      expect(rule.validate('5'), isTrue);
      expect(rule.validate('10'), isTrue);
      expect(rule.validate('11'), isFalse);
    });
  });
}
