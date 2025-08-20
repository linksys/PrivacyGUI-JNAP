import 'dart:convert';

import 'package:jnap/src/utilties/encrypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  const validKey = 'ThisIsA32ByteKeyForAES256Encrypt'; // Exactly 32 bytes
  const validIV = '16ByteIVString!!';
  const testMessage = 'Hello, this is a test message!';

  group('encryptAES', () {
    test('should return different outputs for same input with different IVs',
        () {
      final encrypted1 = encryptAES(testMessage, validKey, validIV);
      final encrypted2 = encryptAES(testMessage, validKey, '16ByteIVString--');
      expect(encrypted1, isNot(equals(encrypted2)));
    });

    test('should handle empty string input', () {
      final encrypted = encryptAES('', validKey, validIV);
      expect(encrypted, isA<String>());
      expect(encrypted.isNotEmpty, isTrue);
    });

    test('should throw with invalid key length', () {
      expect(
        () => encryptAES(testMessage, 'shortkey', validIV),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('decryptAES', () {
    test('should decrypt an encrypted message correctly', () {
      final encrypted = encryptAES(testMessage, validKey, validIV);
      final decrypted = decryptAES(encrypted, validKey, validIV);
      expect(decrypted, equals(testMessage));
    });

    test('should return empty string when decrypting empty ciphertext', () {
      // Encrypting empty string
      final encrypted = encryptAES('', validKey, validIV);
      final decrypted = decryptAES(encrypted, validKey, validIV);
      expect(decrypted, equals(''));
    });

    test('should throw with incorrect key', () {
      final encrypted = encryptAES(testMessage, validKey, validIV);
      expect(
        () =>
            decryptAES(encrypted, 'WrongKey123456789012345678901234', validIV),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw with incorrect IV', () {
      final encrypted = encryptAES(testMessage, validKey, validIV);
      expect(
        () => decryptAES(encrypted, validKey, 'WrongIV1234567890'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('encryptAES and decryptAES', () {
    test('should be able to decrypt encrypted message', () {
      const message =
          'This is a test message with special characters: !@#\$%^&*()';
      final encrypted = encryptAES(message, validKey, validIV);
      final decrypted = decryptAES(encrypted, validKey, validIV);
      expect(decrypted, equals(message));
    });

    test('should handle very long messages', () {
      final longMessage = 'A' * 10000;
      final encrypted = encryptAES(longMessage, validKey, validIV);
      final decrypted = decryptAES(encrypted, validKey, validIV);
      expect(decrypted, equals(longMessage));
    });

    test('should handle special characters and unicode', () {
      const specialMessage =
          'Special chars: こんにちは, 你好, नमस्ते! @#\$%^&*()_+{}[]|\\:;"\'<>,.?/~`';
      final encrypted = encryptAES(specialMessage, validKey, validIV);
      final decrypted = decryptAES(encrypted, validKey, validIV);
      expect(decrypted, equals(specialMessage));
    });
  });
}
