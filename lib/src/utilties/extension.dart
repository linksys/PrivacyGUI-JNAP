import 'dart:convert';

import 'package:crypto/crypto.dart';

extension MapExt on Map {
  T? getValueByPath<T>(String path) { // Return nullable
    final token = path.split('.');
    final key = token[0];

    if (!containsKey(key)) {
      return null;
    }

    final value = this[key];

    if (token.length == 1) {
      return value is T ? value : null;
    } else {
      if (value is Map) {
        return value.getValueByPath<T>(token.sublist(1).join('.'));
      } else {
        return null;
      }
    }
  }
}

extension StringExt on String {
  /// Capitalize ONE word
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;

  /// Camel capitalize words
  String camelCapitalize() {
    return split(' ').fold(
        '',
        (previousValue, element) =>
            '${previousValue.isEmpty ? '' : '$previousValue '}${element.capitalize()}');
  }

  /// Capitalize words
  String capitalizeWords() {
    return split(' ').map((element) => element.capitalize()).join(' ');
  }

  /// Capitalize sentences
  String capitalizeSentence() {
    return split('. ').map((element) => element.capitalize()).join('. ');
  }

  String kebab() {
    // Replace uppercase letters with a hyphen and the lowercase letter
    final pattern = RegExp(r'(?=[A-Z])');
    return '${this[0].toLowerCase()}${substring(1)}'
        .replaceAll(' ', '')
        .replaceAllMapped(pattern, (match) => '-')
        .toLowerCase();
  }

  bool isJsonFormat() {
    try {
      jsonDecode(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  String toMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }

  /// Only use this on version string
  int compareToVersion(String comparedVersion) {
    List<String> currentSplit = split('.');
    final current = currentSplit.map((e) => e.padLeft(8, '0')).join();
    List<String> comparedSplit = comparedVersion.split('.');
    final compared = comparedSplit.map((e) => e.padLeft(8, '0')).join();
    return current.compareTo(compared);
  }

  String base64Encode() {
    return utf8.fuse(base64).encode(this);
  }

  String base64Decode() {
    return utf8.fuse(base64).decode(this);
  }

  bool isBase64() {
    try {
      String source = this;
      // Normalize the string by adding padding if it's missing.
      switch (source.length % 4) {
        case 2:
          source += '==';
          break;
        case 3:
          source += '=';
          break;
      }
      // Use the standard decoder.
      base64.decode(source);
      return true;
    } catch (e) {
      return false;
    }
  }
}