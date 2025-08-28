// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/ipv6_automatic_settings.dart';

class GetIPv6Settings extends Jsonable {
  final String? wanType;
  final IPv6AutomaticSettings? ipv6AutomaticSettings;
  final String duid;

  const GetIPv6Settings({
    this.wanType,
    this.ipv6AutomaticSettings,
    required this.duid,
  });

  @override
  List<Object?> get props => [wanType, ipv6AutomaticSettings, duid];

  @override
  GetIPv6Settings copyWith({
    String? wanType,
    IPv6AutomaticSettings? ipv6AutomaticSettings,
    String? duid,
  }) {
    return GetIPv6Settings(
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

  factory GetIPv6Settings.fromMap(Map<String, dynamic> map) {
    return GetIPv6Settings(
      wanType: map['wanType'] as String?,
      ipv6AutomaticSettings: map['ipv6AutomaticSettings'] != null
          ? IPv6AutomaticSettings.fromMap(
              map['ipv6AutomaticSettings'] as Map<String, dynamic>)
          : null,
      duid: map['duid'] as String,
    );
  }

  factory GetIPv6Settings.fromJson(String source) =>
      GetIPv6Settings.fromMap(jsonDecode(source));
}

class SetIPv6Settings extends Jsonable {
  final String wanType;
  final IPv6AutomaticSettings? ipv6AutomaticSettings;

  const SetIPv6Settings({
    required this.wanType,
    this.ipv6AutomaticSettings,
  });

  @override
  List<Object?> get props => [wanType, ipv6AutomaticSettings];

  @override
  SetIPv6Settings copyWith({
    String? wanType,
    IPv6AutomaticSettings? ipv6AutomaticSettings,
    String? duid,
  }) {
    return SetIPv6Settings(
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

  factory SetIPv6Settings.fromMap(Map<String, dynamic> map) {
    return SetIPv6Settings(
      wanType: map['wanType'] as String,
      ipv6AutomaticSettings: map['ipv6AutomaticSettings'] != null
          ? IPv6AutomaticSettings.fromMap(
              map['ipv6AutomaticSettings'] as Map<String, dynamic>)
          : null,
    );
  }

  factory SetIPv6Settings.fromJson(String source) =>
      SetIPv6Settings.fromMap(jsonDecode(source));
}
