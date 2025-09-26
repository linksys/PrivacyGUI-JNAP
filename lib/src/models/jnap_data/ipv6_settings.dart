// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/ipv6_automatic_settings.dart';

class GetIPv6SettingsData extends Jsonable {
  final String? wanType;
  final IPv6AutomaticSettingsData? ipv6AutomaticSettings;
  final String duid;

  const GetIPv6SettingsData({
    this.wanType,
    this.ipv6AutomaticSettings,
    required this.duid,
  });

  @override
  List<Object?> get props => [wanType, ipv6AutomaticSettings, duid];

  @override
  GetIPv6SettingsData copyWith({
    String? wanType,
    IPv6AutomaticSettingsData? ipv6AutomaticSettings,
    String? duid,
  }) {
    return GetIPv6SettingsData(
      wanType: wanType ?? this.wanType,
      ipv6AutomaticSettings:
          ipv6AutomaticSettings ?? this.ipv6AutomaticSettings,
      duid: duid ?? this.duid,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wanType': wanType,
      'ipv6AutomaticSettings': ipv6AutomaticSettings?.toMap(),
      'duid': duid,
    }..removeWhere((key, value) => value == null);
  }

  factory GetIPv6SettingsData.fromMap(Map<String, dynamic> map) {
    return GetIPv6SettingsData(
      wanType: map['wanType'] as String?,
      ipv6AutomaticSettings: map['ipv6AutomaticSettings'] != null
          ? IPv6AutomaticSettingsData.fromMap(
              map['ipv6AutomaticSettings'] as Map<String, dynamic>)
          : null,
      duid: map['duid'] as String,
    );
  }

  factory GetIPv6SettingsData.fromJson(String source) =>
      GetIPv6SettingsData.fromMap(jsonDecode(source));
}

class SetIPv6SettingsData extends Jsonable {
  final String wanType;
  final IPv6AutomaticSettingsData? ipv6AutomaticSettings;

  const SetIPv6SettingsData({
    required this.wanType,
    this.ipv6AutomaticSettings,
  });

  @override
  List<Object?> get props => [wanType, ipv6AutomaticSettings];

  @override
  SetIPv6SettingsData copyWith({
    String? wanType,
    IPv6AutomaticSettingsData? ipv6AutomaticSettings,
    String? duid,
  }) {
    return SetIPv6SettingsData(
      wanType: wanType ?? this.wanType,
      ipv6AutomaticSettings:
          ipv6AutomaticSettings ?? this.ipv6AutomaticSettings,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wanType': wanType,
      'ipv6AutomaticSettings': ipv6AutomaticSettings?.toMap(),
    }..removeWhere((key, value) => value == null);
  }

  factory SetIPv6SettingsData.fromMap(Map<String, dynamic> map) {
    return SetIPv6SettingsData(
      wanType: map['wanType'] as String,
      ipv6AutomaticSettings: map['ipv6AutomaticSettings'] != null
          ? IPv6AutomaticSettingsData.fromMap(
              map['ipv6AutomaticSettings'] as Map<String, dynamic>)
          : null,
    );
  }

  factory SetIPv6SettingsData.fromJson(String source) =>
      SetIPv6SettingsData.fromMap(jsonDecode(source));
}