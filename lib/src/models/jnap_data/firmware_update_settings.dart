// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class FirmwareAutoUpdateWindow extends Jsonable {
  final int startMinute;
  final int durationMinutes;
  const FirmwareAutoUpdateWindow({
    required this.startMinute,
    required this.durationMinutes,
  });

  factory FirmwareAutoUpdateWindow.simple() =>
      const FirmwareAutoUpdateWindow(startMinute: 0, durationMinutes: 240);

  @override
  FirmwareAutoUpdateWindow copyWith({
    int? startMinute,
    int? durationMinutes,
  }) {
    return FirmwareAutoUpdateWindow(
      startMinute: startMinute ?? this.startMinute,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startMinute': startMinute,
      'durationMinutes': durationMinutes,
    };
  }

  factory FirmwareAutoUpdateWindow.fromMap(Map<String, dynamic> map) {
    return FirmwareAutoUpdateWindow(
      startMinute: map['startMinute'],
      durationMinutes: map['durationMinutes'],
    );
  }

  @override
  List<Object> get props => [startMinute, durationMinutes];

  factory FirmwareAutoUpdateWindow.fromJson(String source) =>
      FirmwareAutoUpdateWindow.fromMap(jsonDecode(source));
}

class FirmwareUpdateSettings extends Jsonable {
  static const firmwareUpdatePolicyManual = 'Manual';
  static const firmwareUpdatePolicyAuto = 'AutomaticallyCheckAndInstall';

  final String updatePolicy;
  final FirmwareAutoUpdateWindow autoUpdateWindow;
  const FirmwareUpdateSettings({
    required this.updatePolicy,
    required this.autoUpdateWindow,
  });

  @override
  FirmwareUpdateSettings copyWith({
    String? updatePolicy,
    FirmwareAutoUpdateWindow? autoUpdateWindow,
  }) {
    return FirmwareUpdateSettings(
      updatePolicy: updatePolicy ?? this.updatePolicy,
      autoUpdateWindow: autoUpdateWindow ?? this.autoUpdateWindow,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'updatePolicy': updatePolicy,
      'autoUpdateWindow': autoUpdateWindow.toMap(),
    };
  }

  factory FirmwareUpdateSettings.fromMap(Map<String, dynamic> map) {
    return FirmwareUpdateSettings(
      updatePolicy: map['updatePolicy'] as String,
      autoUpdateWindow: FirmwareAutoUpdateWindow.fromMap(
          map['autoUpdateWindow'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [updatePolicy, autoUpdateWindow];

  factory FirmwareUpdateSettings.fromJson(String source) =>
      FirmwareUpdateSettings.fromMap(jsonDecode(source));
}
