import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/mac_address_clone_settings.dart';

void main() {
  group('MACAddressCloneSettings', () {
    const macAddressCloneSettings = MACAddressCloneSettings(
      isMACAddressCloneEnabled: true,
      macAddress: '00:11:22:33:44:55',
    );

    final Map<String, dynamic> macAddressCloneSettingsMap = {
      'isMACAddressCloneEnabled': true,
      'macAddress': '00:11:22:33:44:55',
    };

    test('toMap returns a valid map', () {
      expect(macAddressCloneSettings.toMap(), macAddressCloneSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(MACAddressCloneSettings.fromMap(macAddressCloneSettingsMap), macAddressCloneSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(macAddressCloneSettings.toJson(), json.encode(macAddressCloneSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(MACAddressCloneSettings.fromJson(json.encode(macAddressCloneSettingsMap)), macAddressCloneSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = macAddressCloneSettings.copyWith(
        isMACAddressCloneEnabled: false,
      );
      expect(updatedSettings.isMACAddressCloneEnabled, false);
      expect(updatedSettings.macAddress, macAddressCloneSettings.macAddress);
    });

    test('props are correct', () {
      final settings1 = MACAddressCloneSettings(isMACAddressCloneEnabled: true, macAddress: 'm1');
      final settings2 = MACAddressCloneSettings(isMACAddressCloneEnabled: true, macAddress: 'm1');
      final settings3 = MACAddressCloneSettings(isMACAddressCloneEnabled: false, macAddress: 'm2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
