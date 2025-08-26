import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:test/test.dart';

void main() {
  test('HMAC-SHA256 sanity check', () {
    final key = utf8.encode('secret');
    final bytes = utf8.encode('message');

    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    print('Hash for "message" with key "secret": ${digest.toString()}');
    expect(digest.toString(), '8b5f48702995c1598c573db1e21866a9b825d4a794d169d7060a03605796360b');
  });

  test('HMAC-SHA256 with different secret', () {
    final key = utf8.encode('another_secret');
    final bytes = utf8.encode('message');

    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    print('Hash for "message" with key "another_secret": ${digest.toString()}');
    // I will get the expected hash from an online tool
    expect(digest.toString(), '19abc330a3cfbe0b92e2ffb16c11066cec8674370882d9e9ab83eed09501171f');
  });

  test('HMAC-SHA256 with different message', () {
    final key = utf8.encode('secret');
    final bytes = utf8.encode('another_message');

    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    print('Hash for "another_message" with key "secret": ${digest.toString()}');
    // I will get the expected hash from an online tool
    expect(digest.toString(), 'a3efa493ae8a3f3e0a8008c2cbd2c7bf2cc83c3877b401de01b9a615b80d64e7');
  });
}
