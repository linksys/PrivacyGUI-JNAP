
import 'package:test/test.dart';
import 'package:jnap/src/utilties/validator_rules/input_validators.dart';
import 'package:jnap/src/utilties/validator_rules/rules.dart';

void main() {
  group('InputValidator', () {
    test('validate should return true for valid input', () {
      final validator = InputValidator([
        RequiredRule(),
        LengthRule(min: 3, max: 10),
      ]);
      expect(validator.validate('test'), isTrue);
      expect(validator.isValid, isTrue);
    });

    test('validate should return false for invalid input', () {
      final validator = InputValidator([
        RequiredRule(),
        LengthRule(min: 3, max: 10),
      ]);
      expect(validator.validate('a'), isFalse);
      expect(validator.isValid, isFalse);
    });

    test('validateDetail should return all rule results', () {
      final validator = InputValidator([
        RequiredRule(),
        LengthRule(min: 3, max: 10),
      ]);
      final results = validator.validateDetail('a');
      expect(results, containsPair('RequiredRule', isTrue));
      expect(results, containsPair('LengthRule', isFalse));
      expect(validator.results, results);
    });

    test('validateDetail should return only failed rules when onlyFailed is true', () {
      final validator = InputValidator([
        RequiredRule(),
        LengthRule(min: 3, max: 10),
      ]);
      final results = validator.validateDetail('a', onlyFailed: true);
      expect(results, isNot(containsPair('RequiredRule', isTrue)));
      expect(results, containsPair('LengthRule', isFalse));
    });

    test('getRule should return the rule by name', () {
      final requiredRule = RequiredRule();
      final validator = InputValidator([requiredRule, LengthRule()]);
      expect(validator.getRule('RequiredRule'), requiredRule);
    });

    test('getRule should return null if rule not found', () {
      final validator = InputValidator([LengthRule()]);
      expect(validator.getRule('NonExistentRule'), isNull);
    });

    test('getRuleByIndex should return the rule by index', () {
      final requiredRule = RequiredRule();
      final validator = InputValidator([requiredRule, LengthRule()]);
      expect(validator.getRuleByIndex(0), requiredRule);
    });

    test('getRuleByIndex should return null for out of bounds index', () {
      final validator = InputValidator([RequiredRule()]);
      expect(validator.getRuleByIndex(10), isNull);
      expect(validator.getRuleByIndex(-1), isNull);
    });
  });

  group('ComplexPasswordValidator', () {
    test('should validate a complex password', () {
      final validator = ComplexPasswordValidator();
      // Min length is 10
      expect(validator.validate('Passw0rd!!'), isTrue);
      expect(validator.validate('AnotherP@ssw0rd'), isTrue);
    });
    test('should fail for invalid passwords', () {
      final validator = ComplexPasswordValidator();
      expect(validator.validate('password'), isFalse); // No digit, no special char, no hybrid case
      expect(validator.validate('PASSWORD'), isFalse); // No digit, no special char, no hybrid case
      expect(validator.validate('passw0rd'), isFalse); // No special char, no hybrid case
      expect(validator.validate('Passw0rd'), isFalse); // No special char
      expect(validator.validate('short'), isFalse); // Too short
    });
  });

  group('EmailValidator', () {
    test('should validate a valid email', () {
      final validator = EmailValidator();
      expect(validator.validate('test@example.com'), isTrue);
    });
    test('should fail for invalid email', () {
      final validator = EmailValidator();
      expect(validator.validate('invalid-email'), isFalse);
      expect(validator.validate(''), isFalse); // Required
    });
  });

  group('SubnetMaskValidator', () {
    test('should validate a valid subnet mask', () {
      final validator = SubnetMaskValidator();
      expect(validator.validate('255.255.255.0'), isTrue);
    });
    test('should fail for invalid subnet mask', () {
      final validator = SubnetMaskValidator();
      expect(validator.validate('192.168.1.1'), isFalse); // Not a valid mask
      expect(validator.validate('255.255.255.255'), isFalse); // /32 by default
      expect(validator.validate(''), isFalse); // Required
      expect(validator.validate(' 255.255.255.0'), isFalse); // Surrounding whitespace
    });
    test('should respect min/max prefix length', () {
      final validator = SubnetMaskValidator(min: 24, max: 24);
      expect(validator.validate('255.255.255.0'), isTrue);
      expect(validator.validate('255.255.0.0'), isFalse);
    });
  });

  group('IpAddressValidator', () {
    test('should validate a valid non-reserved IP address', () {
      final validator = IpAddressValidator();
      expect(validator.validate('192.168.1.1'), isTrue);
    });
    test('should fail for reserved IP addresses', () {
      final validator = IpAddressValidator();
      expect(validator.validate('127.0.0.1'), isFalse);
      expect(validator.validate('0.0.0.0'), isFalse);
    });
    test('should fail for invalid IP format', () {
      final validator = IpAddressValidator();
      expect(validator.validate('invalid-ip'), isFalse);
    });
    
  });

  group('IpAddressRequiredValidator', () {
    test('should validate a valid required IP address', () {
      final validator = IpAddressRequiredValidator();
      expect(validator.validate('192.168.1.1'), isTrue);
    });
    test('should fail for empty string', () {
      final validator = IpAddressRequiredValidator();
      expect(validator.validate(''), isFalse);
    });
  });

  group('IpAddressAsNewRouterIpValidator', () {
    test('should validate a valid new router IP', () {
      final validator = IpAddressAsNewRouterIpValidator('192.168.1.1', '255.255.255.0');
      expect(validator.validate('192.168.1.2'), isTrue);
    });
    test('should fail for invalid new router IP', () {
      final validator = IpAddressAsNewRouterIpValidator('192.168.1.1', '255.255.255.0');
      expect(validator.validate('192.168.2.1'), isFalse); // Different subnet
      expect(validator.validate('192.168.1.0'), isFalse); // Network ID
      expect(validator.validate('192.168.1.255'), isFalse); // Broadcast ID
      expect(validator.validate(''), isFalse); // Required
    });
  });

  group('IpAddressAsLocalIpValidator', () {
    test('should validate a valid local IP', () {
      final validator = IpAddressAsLocalIpValidator('192.168.1.1', '255.255.255.0');
      expect(validator.validate('192.168.1.100'), isTrue);
    });
    test('should fail for invalid local IP', () {
      final validator = IpAddressAsLocalIpValidator('192.168.1.1', '255.255.255.0');
      expect(validator.validate('192.168.1.1'), isFalse); // Is router IP
      expect(validator.validate('192.168.1.0'), isFalse); // Network ID
      expect(validator.validate('192.168.1.255'), isFalse); // Broadcast ID
      expect(validator.validate('192.168.2.100'), isFalse); // Different subnet
      expect(validator.validate(''), isFalse); // Required
    });
  });

  group('MaxUsersValidator', () {
    test('should validate a valid number of users', () {
      final validator = MaxUsersValidator(10);
      expect(validator.validate('1'), isTrue);
      expect(validator.validate('5'), isTrue);
      expect(validator.validate('10'), isTrue);
    });
    test('should fail for invalid number of users', () {
      final validator = MaxUsersValidator(10);
      expect(validator.validate('0'), isFalse);
      expect(validator.validate('11'), isFalse);
      expect(validator.validate('abc'), isFalse);
      expect(validator.validate(''), isFalse); // Required
    });
  });

  group('DhcpClientLeaseTimeValidator', () {
    test('should validate a valid lease time', () {
      final validator = DhcpClientLeaseTimeValidator(60, 1440);
      expect(validator.validate('60'), isTrue);
      expect(validator.validate('720'), isTrue);
      expect(validator.validate('1440'), isTrue);
    });
    test('should fail for invalid lease time', () {
      final validator = DhcpClientLeaseTimeValidator(60, 1440);
      expect(validator.validate('59'), isFalse);
      expect(validator.validate('1441'), isFalse);
      expect(validator.validate('abc'), isFalse);
      expect(validator.validate(''), isFalse); // Required
    });
  });
}
