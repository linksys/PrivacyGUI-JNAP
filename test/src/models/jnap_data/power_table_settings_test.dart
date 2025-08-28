import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/power_table_settings.dart';

void main() {
  group('PowerTableSettings', () {
    const powerTableSettings = PowerTableSettings(
      isPowerTableSelectable: true,
      supportedCountries: ['US', 'CA'],
      country: 'US',
    );

    final Map<String, dynamic> powerTableSettingsMap = {
      'isPowerTableSelectable': true,
      'supportedCountries': ['US', 'CA'],
      'country': 'US',
    };

    test('toMap returns a valid map', () {
      expect(powerTableSettings.toMap(), powerTableSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(PowerTableSettings.fromMap(powerTableSettingsMap), powerTableSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(powerTableSettings.toJson(), json.encode(powerTableSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PowerTableSettings.fromJson(json.encode(powerTableSettingsMap)), powerTableSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = powerTableSettings.copyWith(
        isPowerTableSelectable: false,
        country: 'CA',
      );
      expect(updatedSettings.isPowerTableSelectable, false);
      expect(updatedSettings.country, 'CA');
      expect(updatedSettings.supportedCountries, powerTableSettings.supportedCountries);
    });

    test('props are correct', () {
      final settings1 = PowerTableSettings(isPowerTableSelectable: true, supportedCountries: ['c1']);
      final settings2 = PowerTableSettings(isPowerTableSelectable: true, supportedCountries: ['c1']);
      final settings3 = PowerTableSettings(isPowerTableSelectable: false, supportedCountries: ['c2']);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
