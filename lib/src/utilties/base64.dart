import 'dart:convert';

class Base64Utils {
  static bool isBase64Encoded(String value) {
    try {
      utf8.decode(base64Url.decode(value));
      return true;
    } catch (e) {
      return false;
    }
  }
}