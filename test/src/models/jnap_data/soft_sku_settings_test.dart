import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/soft_sku_settings.dart';

void main() {
  group('SoftSKUSettingsData', () {
    const softSKUSettings = SoftSKUSettingsData(
      modelNumber: 'ModelX',
    );

    final Map<String, dynamic> softSKUSettingsMap = {
      'modelNumber': 'ModelX',
    };

    test('toMap returns a valid map', () {
      expect(softSKUSettings.toMap(), softSKUSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SoftSKUSettingsData.fromMap(softSKUSettingsMap), softSKUSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(softSKUSettings.toJson(), json.encode(softSKUSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SoftSKUSettingsData.fromJson(json.encode(softSKUSettingsMap)), softSKUSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = softSKUSettings.copyWith(
        modelNumber: 'ModelY',
      );
      expect(updatedSettings.modelNumber, 'ModelY');
    });

    test('props are correct', () {
      final settings1 = SoftSKUSettingsData(modelNumber: 'm1');
      final settings2 = SoftSKUSettingsData(modelNumber: 'm1');
      final settings3 = SoftSKUSettingsData(modelNumber: 'm2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}