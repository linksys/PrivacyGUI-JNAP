// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

enum NodeLightStatus {
  on,
  off,
  night;

  static NodeLightStatus getStatus(NodeLightSettingsData? settings) {
    if (settings == null) {
      return NodeLightStatus.off;
    }
    if ((settings.allDayOff ?? false) ||
        (settings.startHour == 0 && settings.endHour == 24)) {
      return NodeLightStatus.off;
    } else if (!settings.isNightModeEnable) {
      return NodeLightStatus.on;
    } else {
      return NodeLightStatus.night;
    }
  }
}

class NodeLightSettingsData extends Jsonable {
  final bool isNightModeEnable;
  final int? startHour;
  final int? endHour;
  final bool? allDayOff;
  const NodeLightSettingsData({
    required this.isNightModeEnable,
    this.startHour,
    this.endHour,
    this.allDayOff,
  });

  factory NodeLightSettingsData.fromStatus(NodeLightStatus status) =>
      switch (status) {
        NodeLightStatus.on => NodeLightSettingsData.on(),
        NodeLightStatus.off => NodeLightSettingsData.off(),
        NodeLightStatus.night => NodeLightSettingsData.night(),
      };
  factory NodeLightSettingsData.on() => NodeLightSettingsData(
        isNightModeEnable: false,
      );
  factory NodeLightSettingsData.off() =>
      NodeLightSettingsData(isNightModeEnable: true, startHour: 0, endHour: 24);
  factory NodeLightSettingsData.night() =>
      NodeLightSettingsData(isNightModeEnable: true, startHour: 20, endHour: 8);

  @override
  List<Object?> get props => [isNightModeEnable, startHour, endHour, allDayOff];

  @override
  NodeLightSettingsData copyWith({
    bool? isNightModeEnable,
    int? startHour,
    int? endHour,
    bool? allDayOff,
  }) {
    return NodeLightSettingsData(
      isNightModeEnable: isNightModeEnable ?? this.isNightModeEnable,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      allDayOff: allDayOff ?? this.allDayOff,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Enable': isNightModeEnable,
      'StartingTime': startHour,
      'EndingTime': endHour,
      'AllDayOff': allDayOff,
    }..removeWhere((key, value) => value == null);
  }

  factory NodeLightSettingsData.fromMap(Map<String, dynamic> map) {
    return NodeLightSettingsData(
      isNightModeEnable: map['Enable'] as bool,
      startHour:
          map['StartingTime'] != null ? map['StartingTime'] as int : null,
      endHour: map['EndingTime'] != null ? map['EndingTime'] as int : null,
      allDayOff: map['AllDayOff'] != null ? map['AllDayOff'] as bool : null,
    );
  }

  factory NodeLightSettingsData.fromJson(String source) =>
      NodeLightSettingsData.fromMap(jsonDecode(source));
}