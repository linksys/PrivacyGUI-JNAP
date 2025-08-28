// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class MACFilterSettings extends Jsonable {
  final String macFilterMode;
  final int maxMACAddresses;
  final List<String> macAddresses;
  const MACFilterSettings({
    required this.macFilterMode,
    required this.maxMACAddresses,
    required this.macAddresses,
  });

  @override
  MACFilterSettings copyWith({
    String? macFilterMode,
    int? maxMACAddresses,
    List<String>? macAddresses,
  }) {
    return MACFilterSettings(
      macFilterMode: macFilterMode ?? this.macFilterMode,
      maxMACAddresses: maxMACAddresses ?? this.maxMACAddresses,
      macAddresses: macAddresses ?? this.macAddresses,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macFilterMode': macFilterMode,
      'maxMACAddresses': maxMACAddresses,
      'macAddresses': macAddresses,
    };
  }

  factory MACFilterSettings.fromMap(Map<String, dynamic> map) {
    return MACFilterSettings(
        macFilterMode: map['macFilterMode'] as String,
        maxMACAddresses: map['maxMACAddresses'] as int,
        macAddresses: List<String>.from(map['macAddresses']));
  }

  @override
  List<Object> get props => [macFilterMode, maxMACAddresses, macAddresses];

  factory MACFilterSettings.fromJson(String source) =>
      MACFilterSettings.fromMap(jsonDecode(source));
}
