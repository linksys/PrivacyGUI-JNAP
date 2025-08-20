
import 'package:encrypt/encrypt.dart' as encrypt;

/// Decrypts a Base64 encoded string using AES CBC.
String decryptAES(String encryptedBase64, String keyString, String ivString) {
  // The key and IV must be the exact same as the ones used for encryption.
  // The key must be 32 bytes for AES-256.
  final key = encrypt.Key.fromUtf8(keyString);
  // The IV must be 16 bytes for AES-CBC.
  final iv = encrypt.IV.fromUtf8(ivString);

  // Create the encrypter
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  // Decrypt the data
  final encryptedData = encrypt.Encrypted.fromBase64(encryptedBase64);
  var decrypted = encrypter.decrypt(encryptedData, iv: iv);
  
  // Handle the case where the original string was empty (we encrypted a single space)
  if (decrypted == ' ') {
    decrypted = '';
  }

  return decrypted;
}

/// Encrypts a string using AES CBC and returns a Base64 encoded string.
String encryptAES(String plainText, String keyString, String ivString) {
  // The key and IV must be the exact same as the ones used for encryption.
  // The key must be 32 bytes for AES-256.
  final key = encrypt.Key.fromUtf8(keyString);
  // The IV must be 16 bytes for AES-CBC.
  final iv = encrypt.IV.fromUtf8(ivString);

  // Create the encrypter
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  // Handle empty string case by adding a space before encryption
  final textToEncrypt = plainText.isEmpty ? ' ' : plainText;
  
  // Encrypt the data
  final encrypted = encrypter.encrypt(textToEncrypt, iv: iv);

  return encrypted.base64;
}