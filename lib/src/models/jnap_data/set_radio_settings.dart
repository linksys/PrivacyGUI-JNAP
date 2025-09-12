// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';

class SetRadioSettingsData extends Jsonable {
  final List<NewRadioSettings> radios;

  const SetRadioSettingsData({
    required this.radios,
  });

  @override
  SetRadioSettingsData copyWith({
    List<NewRadioSettings>? radios,
  }) {
    return SetRadioSettingsData(
      radios: radios ?? this.radios,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory SetRadioSettingsData.fromMap(Map<String, dynamic> map) {
    return SetRadioSettingsData(
      radios: List<NewRadioSettings>.from(
        (map['radios'] as List<dynamic>).map<NewRadioSettings>(
          (x) => NewRadioSettings.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory SetRadioSettingsData.fromJson(String source) =>
      SetRadioSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [radios];
}

class NewRadioSettings extends Jsonable {
  final String radioID;
  final RouterRadioSettings settings;

  const NewRadioSettings({
    required this.radioID,
    required this.settings,
  });

  @override
  NewRadioSettings copyWith({
    String? radioID,
    RouterRadioSettings? settings,
  }) {
    return NewRadioSettings(
      radioID: radioID ?? this.radioID,
      settings: settings ?? this.settings,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'radioID': radioID,
      'settings': settings.toMap(),
    };
  }

  factory NewRadioSettings.fromMap(Map<String, dynamic> map) {
    return NewRadioSettings(
      radioID: map['radioID'] as String,
      settings:
          RouterRadioSettings.fromMap(map['settings'] as Map<String, dynamic>),
    );
  }

  factory NewRadioSettings.fromJson(String source) =>
      NewRadioSettings.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [radioID, settings];
}