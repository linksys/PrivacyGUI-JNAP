import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/alg_settings.dart';

void main() {
  group('ALGSettings', () {
    const algSettings = ALGSettings(
      isSIPEnabled: true,
    );

    final Map<String, dynamic> algSettingsMap = {
      'isSIPEnabled': true,
    };

    test('toMap returns a valid map', () {
      expect(algSettings.toMap(), algSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(ALGSettings.fromMap(algSettingsMap), algSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(algSettings.toJson(), json.encode(algSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(ALGSettings.fromJson(json.encode(algSettingsMap)), algSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = algSettings.copyWith(
        isSIPEnabled: false,
      );
      expect(updatedSettings.isSIPEnabled, false);
      expect(updatedSettings.isSIPEnabled, isNot(algSettings.isSIPEnabled));
    });

    test('props are correct', () {
      final settings1 = ALGSettings(isSIPEnabled: true);
      final settings2 = ALGSettings(isSIPEnabled: true);
      final settings3 = ALGSettings(isSIPEnabled: false);

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
