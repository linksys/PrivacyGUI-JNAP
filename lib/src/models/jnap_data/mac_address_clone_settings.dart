// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class MACAddressCloneSettings extends Jsonable {
  final bool isMACAddressCloneEnabled;
  final String? macAddress;

  const MACAddressCloneSettings({
    required this.isMACAddressCloneEnabled,
    this.macAddress,
  });

  @override
  MACAddressCloneSettings copyWith({
    bool? isMACAddressCloneEnabled,
    String? macAddress,
  }) {
    return MACAddressCloneSettings(
      isMACAddressCloneEnabled:
          isMACAddressCloneEnabled ?? this.isMACAddressCloneEnabled,
      macAddress: macAddress ?? this.macAddress,
    );
  }

  @override
  List<Object?> get props => [isMACAddressCloneEnabled, macAddress];

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isMACAddressCloneEnabled': isMACAddressCloneEnabled,
      'macAddress': macAddress,
    }..removeWhere((key, value) => value == null);
  }

  factory MACAddressCloneSettings.fromMap(Map<String, dynamic> map) {
    return MACAddressCloneSettings(
      isMACAddressCloneEnabled: map['isMACAddressCloneEnabled'] as bool,
      macAddress:
          map['macAddress'] != null ? map['macAddress'] as String : null,
    );
  }
  factory MACAddressCloneSettings.fromJson(String source) =>
      MACAddressCloneSettings.fromMap(jsonDecode(source));
}
