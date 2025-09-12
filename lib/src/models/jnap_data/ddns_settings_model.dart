import 'dart:convert';

import 'package:jnap/src/models/types.dart';

import '../jsonable.dart';

import 'dyn_dns_settings.dart';
import 'no_ip_settings.dart';
import 'tzo_settings.dart';

class DDNSSettingsData extends Jsonable {
  final String ddnsProvider;
  final DynDNSSettingsData? dynDNSSettings;
  final TZOSettingsData? tzoSettings;
  final NoIPSettingsData? noIPSettings;
  const DDNSSettingsData({
    required this.ddnsProvider,
    this.dynDNSSettings,
    this.tzoSettings,
    this.noIPSettings,
  });

  @override
  DDNSSettingsData copyWith({
    String? ddnsProvider,
    ValueGetter<DynDNSSettingsData?>? dynDNSSettings,
    ValueGetter<TZOSettingsData?>? tzoSettings,
    ValueGetter<NoIPSettingsData?>? noIPSettings,
  }) {
    return DDNSSettingsData(
      ddnsProvider: ddnsProvider ?? this.ddnsProvider,
      dynDNSSettings: dynDNSSettings != null ? dynDNSSettings() : this.dynDNSSettings,
      tzoSettings: tzoSettings != null ? tzoSettings() : this.tzoSettings,
      noIPSettings: noIPSettings != null ? noIPSettings() : this.noIPSettings,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ddnsProvider': ddnsProvider,
      'dynDNSSettings': dynDNSSettings?.toMap(),
      'tzoSettings': tzoSettings?.toMap(),
      'noipSettings': noIPSettings?.toMap(),
    };
  }

  factory DDNSSettingsData.fromMap(Map<String, dynamic> map) {
    return DDNSSettingsData(
      ddnsProvider: map['ddnsProvider'] as String,
      dynDNSSettings: map['dynDNSSettings'] != null
          ? DynDNSSettingsData.fromMap(
              map['dynDNSSettings'] as Map<String, dynamic>)
          : null,
      tzoSettings: map['tzoSettings'] != null
          ? TZOSettingsData.fromMap(map['tzoSettings'] as Map<String, dynamic>)
          : null,
      noIPSettings: map['noipSettings'] != null
          ? NoIPSettingsData.fromMap(map['noipSettings'] as Map<String, dynamic>)
          : null,
    );
  }

  factory DDNSSettingsData.fromJson(String source) =>
      DDNSSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props =>
      [ddnsProvider, dynDNSSettings, tzoSettings, noIPSettings];
}