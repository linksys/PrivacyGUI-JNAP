import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/express_forwarding_settings.dart';

void main() {
  group('ExpressForwardingSettings', () {
    const expressForwardingSettings = ExpressForwardingSettings(
      isExpressForwardingSupported: true,
      isExpressForwardingEnabled: true,
    );

    final Map<String, dynamic> expressForwardingSettingsMap = {
      'isExpressForwardingSupported': true,
      'isExpressForwardingEnabled': true,
    };

    test('toMap returns a valid map', () {
      expect(expressForwardingSettings.toMap(), expressForwardingSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(ExpressForwardingSettings.fromMap(expressForwardingSettingsMap), expressForwardingSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(expressForwardingSettings.toJson(), json.encode(expressForwardingSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(ExpressForwardingSettings.fromJson(json.encode(expressForwardingSettingsMap)), expressForwardingSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = expressForwardingSettings.copyWith(
        isExpressForwardingEnabled: false,
      );
      expect(updatedSettings.isExpressForwardingEnabled, false);
      expect(updatedSettings.isExpressForwardingSupported, expressForwardingSettings.isExpressForwardingSupported);
    });

    test('toSetSettingsMap returns a valid map', () {
      expect(expressForwardingSettings.toSetSettingsMap(), {'isExpressForwardingEnabled': true});
    });

    test('props are correct', () {
      final settings1 = ExpressForwardingSettings(isExpressForwardingSupported: true, isExpressForwardingEnabled: true);
      final settings2 = ExpressForwardingSettings(isExpressForwardingSupported: true, isExpressForwardingEnabled: true);
      final settings3 = ExpressForwardingSettings(isExpressForwardingSupported: false, isExpressForwardingEnabled: false);

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
