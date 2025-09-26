import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/auto_configuration_settings.dart';

void main() {
  group('AutoConfigurationMethod', () {
    test('toValue returns correct string', () {
      expect(AutoConfigurationMethod.preConfigured.toValue(), 'PreConfigured');
      expect(AutoConfigurationMethod.autoParent.toValue(), 'AutoParent');
    });

    test('fromValue returns correct enum', () {
      expect(AutoConfigurationMethod.fromValue('PreConfigured'), AutoConfigurationMethod.preConfigured);
      expect(AutoConfigurationMethod.fromValue('AutoParent'), AutoConfigurationMethod.autoParent);
      expect(AutoConfigurationMethod.fromValue('Invalid'), null);
      expect(AutoConfigurationMethod.fromValue(null), null);
    });
  });

  group('AutoConfigurationSettingsData', () {
    const autoConfigurationSettings = AutoConfigurationSettingsData(
      isAutoConfigurationSupported: true,
      autoConfigurationMethod: AutoConfigurationMethod.preConfigured,
      userAcknowledgedAutoConfiguration: false,
    );

    final Map<String, dynamic> autoConfigurationSettingsMap = {
      'isAutoConfigurationSupported': true,
      'autoConfigurationMethod': 'PreConfigured',
      'userAcknowledgedAutoConfiguration': false,
    };

    test('toMap returns a valid map', () {
      expect(autoConfigurationSettings.toMap(), autoConfigurationSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(AutoConfigurationSettingsData.fromMap(autoConfigurationSettingsMap), autoConfigurationSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(autoConfigurationSettings.toJson(), json.encode(autoConfigurationSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(AutoConfigurationSettingsData.fromJson(json.encode(autoConfigurationSettingsMap)), autoConfigurationSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = autoConfigurationSettings.copyWith(
        isAutoConfigurationSupported: () => false,
        autoConfigurationMethod: () => AutoConfigurationMethod.autoParent,
      );
      expect(updatedSettings.isAutoConfigurationSupported, false);
      expect(updatedSettings.autoConfigurationMethod, AutoConfigurationMethod.autoParent);
      expect(updatedSettings.userAcknowledgedAutoConfiguration, autoConfigurationSettings.userAcknowledgedAutoConfiguration);
    });

    test('props are correct', () {
      final settings1 = AutoConfigurationSettingsData(
        isAutoConfigurationSupported: true,
        autoConfigurationMethod: AutoConfigurationMethod.preConfigured,
        userAcknowledgedAutoConfiguration: false,
      );
      final settings2 = AutoConfigurationSettingsData(
        isAutoConfigurationSupported: true,
        autoConfigurationMethod: AutoConfigurationMethod.preConfigured,
        userAcknowledgedAutoConfiguration: false,
      );
      final settings3 = AutoConfigurationSettingsData(
        isAutoConfigurationSupported: false,
        autoConfigurationMethod: AutoConfigurationMethod.autoParent,
        userAcknowledgedAutoConfiguration: true,
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}