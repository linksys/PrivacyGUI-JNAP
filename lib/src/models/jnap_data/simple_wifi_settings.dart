// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class SimpleWiFiSettings extends Jsonable {
  final String band;
  final String ssid;
  final String security;
  final String passphrase;
  const SimpleWiFiSettings({
    required this.band,
    required this.ssid,
    required this.security,
    required this.passphrase,
  });

  @override
  SimpleWiFiSettings copyWith({
    String? band,
    String? ssid,
    String? security,
    String? passphrase,
  }) {
    return SimpleWiFiSettings(
      band: band ?? this.band,
      ssid: ssid ?? this.ssid,
      security: security ?? this.security,
      passphrase: passphrase ?? this.passphrase,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'band': band,
      'ssid': ssid,
      'security': security,
      'passphrase': passphrase,
    };
  }

  @override
  factory SimpleWiFiSettings.fromMap(Map<String, dynamic> map) {
    return SimpleWiFiSettings(
      band: map['band'] as String,
      ssid: map['ssid'] as String,
      security: map['security'] as String,
      passphrase: map['passphrase'] as String,
    );
  }

  @override
  List<Object?> get props => [band, ssid, security, passphrase];

  factory SimpleWiFiSettings.fromJson(String source) =>
      SimpleWiFiSettings.fromMap(jsonDecode(source));
}
