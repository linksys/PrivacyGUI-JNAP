import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/firmware_update_settings.dart';

void main() {
  group('FirmwareAutoUpdateWindow', () {
    const firmwareAutoUpdateWindow = FirmwareAutoUpdateWindow(
      startMinute: 60,
      durationMinutes: 120,
    );

    final Map<String, dynamic> firmwareAutoUpdateWindowMap = {
      'startMinute': 60,
      'durationMinutes': 120,
    };

    test('toMap returns a valid map', () {
      expect(firmwareAutoUpdateWindow.toMap(), firmwareAutoUpdateWindowMap);
    });

    test('fromMap creates a valid object', () {
      expect(FirmwareAutoUpdateWindow.fromMap(firmwareAutoUpdateWindowMap), firmwareAutoUpdateWindow);
    });

    test('toJson returns a valid JSON string', () {
      expect(firmwareAutoUpdateWindow.toJson(), json.encode(firmwareAutoUpdateWindowMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(FirmwareAutoUpdateWindow.fromJson(json.encode(firmwareAutoUpdateWindowMap)), firmwareAutoUpdateWindow);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedWindow = firmwareAutoUpdateWindow.copyWith(
        startMinute: 30,
      );
      expect(updatedWindow.startMinute, 30);
      expect(updatedWindow.durationMinutes, firmwareAutoUpdateWindow.durationMinutes);
    });

    test('simple factory creates a valid object', () {
      final simpleWindow = FirmwareAutoUpdateWindow.simple();
      expect(simpleWindow.startMinute, 0);
      expect(simpleWindow.durationMinutes, 240);
    });

    test('props are correct', () {
      final window1 = FirmwareAutoUpdateWindow(startMinute: 1, durationMinutes: 2);
      final window2 = FirmwareAutoUpdateWindow(startMinute: 1, durationMinutes: 2);
      final window3 = FirmwareAutoUpdateWindow(startMinute: 3, durationMinutes: 4);
      expect(window1, window2);
      expect(window1.props, window2.props);
      expect(window1 == window3, false);
      expect(window1.props == window3.props, false);
    });
  });

  group('FirmwareUpdateSettings', () {
    const firmwareAutoUpdateWindow = FirmwareAutoUpdateWindow(
      startMinute: 60,
      durationMinutes: 120,
    );

    const firmwareUpdateSettings = FirmwareUpdateSettings(
      updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
      autoUpdateWindow: firmwareAutoUpdateWindow,
    );

    final Map<String, dynamic> firmwareUpdateSettingsMap = {
      'updatePolicy': FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
      'autoUpdateWindow': firmwareAutoUpdateWindow.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(firmwareUpdateSettings.toMap(), firmwareUpdateSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(FirmwareUpdateSettings.fromMap(firmwareUpdateSettingsMap), firmwareUpdateSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(firmwareUpdateSettings.toJson(), json.encode(firmwareUpdateSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(FirmwareUpdateSettings.fromJson(json.encode(firmwareUpdateSettingsMap)), firmwareUpdateSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = firmwareUpdateSettings.copyWith(
        updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyManual,
      );
      expect(updatedSettings.updatePolicy, FirmwareUpdateSettings.firmwareUpdatePolicyManual);
      expect(updatedSettings.autoUpdateWindow, firmwareUpdateSettings.autoUpdateWindow);
    });

    test('props are correct', () {
      final settings1 = FirmwareUpdateSettings(
        updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
        autoUpdateWindow: firmwareAutoUpdateWindow,
      );
      final settings2 = FirmwareUpdateSettings(
        updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
        autoUpdateWindow: firmwareAutoUpdateWindow,
      );
      final settings3 = FirmwareUpdateSettings(
        updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyManual,
        autoUpdateWindow: FirmwareAutoUpdateWindow.simple(),
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
