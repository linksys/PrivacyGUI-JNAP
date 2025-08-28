import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/set_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';

void main() {
  group('NewRadioSettings', () {
    const routerRadioSettings = RouterRadioSettings(
      isEnabled: true,
      mode: 'Mixed',
      ssid: 'MyWiFi',
      broadcastSSID: true,
      channelWidth: '20MHz',
      channel: 6,
      security: 'WPA2Personal',
    );

    const newRadioSettings = NewRadioSettings(
      radioID: 'radio1',
      settings: routerRadioSettings,
    );

    final Map<String, dynamic> newRadioSettingsMap = {
      'radioID': 'radio1',
      'settings': routerRadioSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(newRadioSettings.toMap(), newRadioSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(NewRadioSettings.fromMap(newRadioSettingsMap), newRadioSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(newRadioSettings.toJson(), json.encode(newRadioSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NewRadioSettings.fromJson(json.encode(newRadioSettingsMap)), newRadioSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = newRadioSettings.copyWith(
        radioID: 'radio2',
      );
      expect(updatedSettings.radioID, 'radio2');
      expect(updatedSettings.settings, newRadioSettings.settings);
    });

    test('props are correct', () {
      final nrs1 = NewRadioSettings(radioID: 'r1', settings: routerRadioSettings);
      final nrs2 = NewRadioSettings(radioID: 'r1', settings: routerRadioSettings);
      final nrs3 = NewRadioSettings(radioID: 'r2', settings: routerRadioSettings.copyWith(isEnabled: false));
      expect(nrs1, nrs2);
      expect(nrs1.props, nrs2.props);
      expect(nrs1 == nrs3, false);
      expect(nrs1.props == nrs3.props, false);
    });
  });

  group('SetRadioSettings', () {
    const routerRadioSettings = RouterRadioSettings(
      isEnabled: true,
      mode: 'Mixed',
      ssid: 'MyWiFi',
      broadcastSSID: true,
      channelWidth: '20MHz',
      channel: 6,
      security: 'WPA2Personal',
    );

    const newRadioSettings = NewRadioSettings(
      radioID: 'radio1',
      settings: routerRadioSettings,
    );

    const setRadioSettings = SetRadioSettings(
      radios: [newRadioSettings],
    );

    final Map<String, dynamic> setRadioSettingsMap = {
      'radios': [newRadioSettings.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(setRadioSettings.toMap(), setRadioSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SetRadioSettings.fromMap(setRadioSettingsMap), setRadioSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(setRadioSettings.toJson(), json.encode(setRadioSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SetRadioSettings.fromJson(json.encode(setRadioSettingsMap)), setRadioSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = setRadioSettings.copyWith(
        radios: [],
      );
      expect(updatedSettings.radios, []);
    });

    test('props are correct', () {
      final srs1 = SetRadioSettings(radios: [newRadioSettings]);
      final srs2 = SetRadioSettings(radios: [newRadioSettings]);
      final srs3 = SetRadioSettings(radios: []);
      expect(srs1, srs2);
      expect(srs1.props, srs2.props);
      expect(srs1 == srs3, false);
      expect(srs1.props == srs3.props, false);
    });
  });
}
