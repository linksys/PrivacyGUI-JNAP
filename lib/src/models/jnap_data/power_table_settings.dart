// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class PowerTableSettings extends Jsonable {
  final bool isPowerTableSelectable;
  final List<String> supportedCountries;
  final String? country;
  const PowerTableSettings({
    required this.isPowerTableSelectable,
    required this.supportedCountries,
    this.country,
  });

  @override
  PowerTableSettings copyWith({
    bool? isPowerTableSelectable,
    List<String>? supportedCountries,
    String? country,
  }) {
    return PowerTableSettings(
      isPowerTableSelectable:
          isPowerTableSelectable ?? this.isPowerTableSelectable,
      supportedCountries: supportedCountries ?? this.supportedCountries,
      country: country ?? this.country,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isPowerTableSelectable': isPowerTableSelectable,
      'supportedCountries': supportedCountries,
      'country': country,
    };
  }

  @override
  factory PowerTableSettings.fromMap(Map<String, dynamic> map) {
    return PowerTableSettings(
      isPowerTableSelectable: map['isPowerTableSelectable'] as bool,
      supportedCountries: List<String>.from(map['supportedCountries']),
      country: map['country'] != null ? map['country'] as String : null,
    );
  }

  @override
  List<Object?> get props =>
      [isPowerTableSelectable, supportedCountries, country];

  factory PowerTableSettings.fromJson(String source) =>
      PowerTableSettings.fromMap(jsonDecode(source));
}
