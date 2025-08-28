import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/node_light_settings.dart';

void main() {
  group('NodeLightStatus', () {
    test('getStatus returns correct status', () {
      expect(NodeLightStatus.getStatus(null), NodeLightStatus.off);
      expect(NodeLightStatus.getStatus(const NodeLightSettings(isNightModeEnable: true, allDayOff: true)), NodeLightStatus.off);
      expect(NodeLightStatus.getStatus(const NodeLightSettings(isNightModeEnable: true, startHour: 0, endHour: 24)), NodeLightStatus.off);
      expect(NodeLightStatus.getStatus(const NodeLightSettings(isNightModeEnable: false)), NodeLightStatus.on);
      expect(NodeLightStatus.getStatus(const NodeLightSettings(isNightModeEnable: true, startHour: 20, endHour: 8)), NodeLightStatus.night);
    });
  });

  group('NodeLightSettings', () {
    const nodeLightSettings = NodeLightSettings(
      isNightModeEnable: true,
      startHour: 20,
      endHour: 8,
      allDayOff: false,
    );

    final Map<String, dynamic> nodeLightSettingsMap = {
      'Enable': true,
      'StartingTime': 20,
      'EndingTime': 8,
      'AllDayOff': false,
    };

    test('toMap returns a valid map', () {
      expect(nodeLightSettings.toMap(), nodeLightSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(NodeLightSettings.fromMap(nodeLightSettingsMap), nodeLightSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(nodeLightSettings.toJson(), json.encode(nodeLightSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NodeLightSettings.fromJson(json.encode(nodeLightSettingsMap)), nodeLightSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = nodeLightSettings.copyWith(
        isNightModeEnable: false,
        startHour: 0,
      );
      expect(updatedSettings.isNightModeEnable, false);
      expect(updatedSettings.startHour, 0);
      expect(updatedSettings.endHour, nodeLightSettings.endHour);
    });

    test('factory on creates correct settings', () {
      final onSettings = NodeLightSettings.on();
      expect(onSettings.isNightModeEnable, false);
      expect(onSettings.startHour, null);
      expect(onSettings.endHour, null);
      expect(onSettings.allDayOff, null);
    });

    test('factory off creates correct settings', () {
      final offSettings = NodeLightSettings.off();
      expect(offSettings.isNightModeEnable, true);
      expect(offSettings.startHour, 0);
      expect(offSettings.endHour, 24);
      expect(offSettings.allDayOff, null);
    });

    test('factory night creates correct settings', () {
      final nightSettings = NodeLightSettings.night();
      expect(nightSettings.isNightModeEnable, true);
      expect(nightSettings.startHour, 20);
      expect(nightSettings.endHour, 8);
      expect(nightSettings.allDayOff, null);
    });

    test('factory fromStatus creates correct settings', () {
      expect(NodeLightSettings.fromStatus(NodeLightStatus.on), NodeLightSettings.on());
      expect(NodeLightSettings.fromStatus(NodeLightStatus.off), NodeLightSettings.off());
      expect(NodeLightSettings.fromStatus(NodeLightStatus.night), NodeLightSettings.night());
    });

    test('props are correct', () {
      final settings1 = NodeLightSettings(isNightModeEnable: true, startHour: 1, endHour: 2, allDayOff: true);
      final settings2 = NodeLightSettings(isNightModeEnable: true, startHour: 1, endHour: 2, allDayOff: true);
      final settings3 = NodeLightSettings(isNightModeEnable: false, startHour: 3, endHour: 4, allDayOff: false);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
