import 'package:test/test.dart';
import 'package:jnap/src/utilties/base64.dart';

void main() {
  group('Base64Utils', () {
    test('isBase64Encoded returns true for a valid Base64 encoded string', () {
      final validBase64 = 'SGVsbG8gV29ybGQ='; // "Hello World"
      expect(Base64Utils.isBase64Encoded(validBase64), isTrue);
    });

    test('isBase64Encoded returns false for a string with invalid characters', () {
      final invalidChars = 'SGVsbG8gV29ybGQ!@#\$'; // Contains invalid Base64 characters
      expect(Base64Utils.isBase64Encoded(invalidChars), isFalse);
    });

    test('isBase64Encoded returns false for a string with incorrect length', () {
      final incorrectLength = 'SGVsbG8gV29ybGQ'; // Length not a multiple of 4
      expect(Base64Utils.isBase64Encoded(incorrectLength), isFalse);
    });

    test('isBase64Encoded returns false for a non-Base64 string', () {
      final nonBase64 = 'Hello World';
      expect(Base64Utils.isBase64Encoded(nonBase64), isFalse);
    });

    test('isBase64Encoded returns true for an empty string', () {
      final emptyString = '';
      expect(Base64Utils.isBase64Encoded(emptyString), isTrue);
    });

    test('isBase64Encoded returns false for a string with invalid Base64 padding (incorrect length before padding)', () {
      final invalidPadding = 'abc='; // 'abc' is not a valid Base64 string of length 3
      expect(Base64Utils.isBase64Encoded(invalidPadding), isFalse);
    });
  });
}
