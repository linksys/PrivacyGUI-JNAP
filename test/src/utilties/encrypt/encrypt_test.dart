import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:jnap/src/utilties/encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  group('AES Encryption/Decryption', () {
    // Define a consistent key and IV for testing
    final key = encrypt.Key(Uint8List.fromList(List.generate(32, (i) => i % 256))); // 32 random bytes
    final iv = encrypt.IV(Uint8List.fromList(List.generate(16, (i) => i % 256))); // 16 random bytes

    // Convert key and IV to strings for the encryptAES/decryptAES functions
    final keyString = String.fromCharCodes(key.bytes);
    final ivString = String.fromCharCodes(iv.bytes);

    test('encryptAES and decryptAES work for a simple string', () {
      final plainText = 'Hello, AES!';
      final encrypted = encryptAES(plainText, keyString, ivString);
      final decrypted = decryptAES(encrypted, keyString, ivString);
      expect(decrypted, plainText);
    });

    test('encryptAES and decryptAES work for a longer string', () {
      final plainText = 'This is a much longer string to test the AES encryption and decryption functions.';
      final encrypted = encryptAES(plainText, keyString, ivString);
      final decrypted = decryptAES(encrypted, keyString, ivString);
      expect(decrypted, plainText);
    });

    test('encryptAES and decryptAES work for an empty string', () {
      final plainText = '';
      final encrypted = encryptAES(plainText, keyString, ivString);
      final decrypted = decryptAES(encrypted, keyString, ivString);
      expect(decrypted, plainText);
    });

    test('decryptAES throws an Error for incorrect key', () {
      final plainText = 'Test string';
      final encrypted = encryptAES(plainText, keyString, ivString);
      final wrongKey = encrypt.Key(Uint8List.fromList(List.generate(32, (i) => (i + 1) % 256))); // Different key
      final wrongKeyString = String.fromCharCodes(wrongKey.bytes);

      expect(() => decryptAES(encrypted, wrongKeyString, ivString), throwsA(isA<Error>()));
    });

    test('decryptAES throws an Error for incorrect IV', () {
      final plainText = 'Test string';
      final encrypted = encryptAES(plainText, keyString, ivString);
      final wrongIv = encrypt.IV(Uint8List.fromList(List.generate(16, (i) => (i + 1) % 256))); // Different IV
      final wrongIvString = String.fromCharCodes(wrongIv.bytes);

      expect(() => decryptAES(encrypted, keyString, wrongIvString), throwsA(isA<Error>()));
    });

    test('decryptAES throws a FormatException for invalid Base64 input', () {
      final invalidBase64 = 'not-a-valid-base64-string';
      expect(() => decryptAES(invalidBase64, keyString, ivString), throwsA(isA<FormatException>()));
    });
  });
}
