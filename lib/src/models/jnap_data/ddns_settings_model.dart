import 'dart:convert';

import 'package:jnap/src/models/types.dart';

import '../jsonable.dart';

import 'dyn_dns_settings.dart';
import 'no_ip_settings.dart';
import 'tzo_settings.dart';

class DDNSSettings extends Jsonable {
  final String ddnsProvider;
  final DynDNSSettings? dynDNSSettings;
  final TZOSettings? tzoSettings;
  final NoIPSettings? noIPSettings;
  const DDNSSettings({
    required this.ddnsProvider,
    this.dynDNSSettings,
    this.tzoSettings,
    this.noIPSettings,
  });

  @override
  DDNSSettings copyWith({
    String? ddnsProvider,
    ValueGetter<DynDNSSettings?>? dynDNSSettings,
    ValueGetter<TZOSettings?>? tzoSettings,
    ValueGetter<NoIPSettings?>? noIPSettings,
  }) {
    return DDNSSettings(
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

  factory DDNSSettings.fromMap(Map<String, dynamic> map) {
    return DDNSSettings(
      ddnsProvider: map['ddnsProvider'] as String,
      dynDNSSettings: map['dynDNSSettings'] != null
          ? DynDNSSettings.fromMap(
              map['dynDNSSettings'] as Map<String, dynamic>)
          : null,
      tzoSettings: map['tzoSettings'] != null
          ? TZOSettings.fromMap(map['tzoSettings'] as Map<String, dynamic>)
          : null,
      noIPSettings: map['noipSettings'] != null
          ? NoIPSettings.fromMap(map['noipSettings'] as Map<String, dynamic>)
          : null,
    );
  }

  factory DDNSSettings.fromJson(String source) =>
      DDNSSettings.fromMap(jsonDecode(source));

  @override
  List<Object?> get props =>
      [ddnsProvider, dynDNSSettings, tzoSettings, noIPSettings];
}