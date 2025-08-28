import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/mac_filter_settings.dart';

void main() {
  group('MACFilterSettings', () {
    const macFilterSettings = MACFilterSettings(
      macFilterMode: 'Allow',
      maxMACAddresses: 10,
      macAddresses: ['00:11:22:33:44:55', 'AA:BB:CC:DD:EE:FF'],
    );

    final Map<String, dynamic> macFilterSettingsMap = {
      'macFilterMode': 'Allow',
      'maxMACAddresses': 10,
      'macAddresses': ['00:11:22:33:44:55', 'AA:BB:CC:DD:EE:FF'],
    };

    test('toMap returns a valid map', () {
      expect(macFilterSettings.toMap(), macFilterSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(MACFilterSettings.fromMap(macFilterSettingsMap), macFilterSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(macFilterSettings.toJson(), json.encode(macFilterSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(MACFilterSettings.fromJson(json.encode(macFilterSettingsMap)), macFilterSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = macFilterSettings.copyWith(
        macFilterMode: 'Deny',
        macAddresses: ['11:22:33:44:55:66'],
      );
      expect(updatedSettings.macFilterMode, 'Deny');
      expect(updatedSettings.macAddresses, ['11:22:33:44:55:66']);
      expect(updatedSettings.maxMACAddresses, macFilterSettings.maxMACAddresses);
    });

    test('props are correct', () {
      final settings1 = MACFilterSettings(macFilterMode: 'm1', maxMACAddresses: 1, macAddresses: ['a1']);
      final settings2 = MACFilterSettings(macFilterMode: 'm1', maxMACAddresses: 1, macAddresses: ['a1']);
      final settings3 = MACFilterSettings(macFilterMode: 'm2', maxMACAddresses: 2, macAddresses: ['a2']);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
