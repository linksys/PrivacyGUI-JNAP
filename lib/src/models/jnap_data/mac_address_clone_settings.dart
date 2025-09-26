// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class MACAddressCloneSettingsData extends Jsonable {
  final bool isMACAddressCloneEnabled;
  final String? macAddress;

  const MACAddressCloneSettingsData({
    required this.isMACAddressCloneEnabled,
    this.macAddress,
  });

  @override
  MACAddressCloneSettingsData copyWith({
    bool? isMACAddressCloneEnabled,
    String? macAddress,
  }) {
    return MACAddressCloneSettingsData(
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

  factory MACAddressCloneSettingsData.fromMap(Map<String, dynamic> map) {
    return MACAddressCloneSettingsData(
      isMACAddressCloneEnabled: map['isMACAddressCloneEnabled'] as bool,
      macAddress:
          map['macAddress'] != null ? map['macAddress'] as String : null,
    );
  }
  factory MACAddressCloneSettingsData.fromJson(String source) =>
      MACAddressCloneSettingsData.fromMap(jsonDecode(source));
}