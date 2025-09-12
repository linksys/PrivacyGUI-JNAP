import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/ddns_settings_model.dart';
import 'package:jnap/src/models/jnap_data/dyn_dns_settings.dart';
import 'package:jnap/src/models/jnap_data/tzo_settings.dart';
import 'package:jnap/src/models/jnap_data/no_ip_settings.dart';

void main() {
  group('DDNSSettingsData', () {
    const dynDNSSettings = DynDNSSettingsData(
      username: 'dynuser',
      password: 'dynpass',
      hostName: 'dynhost.com',
      isWildcardEnabled: true,
      mode: 'mode1',
      isMailExchangeEnabled: false,
    );

    const tzoSettings = TZOSettingsData(
      username: 'tzouser',
      password: 'tzopass',
      hostName: 'tzohost.com',
    );

    const noIPSettings = NoIPSettingsData(
      username: 'noipuser',
      password: 'noippass',
      hostName: 'noiphost.com',
    );

    const ddnsSettings = DDNSSettingsData(
      ddnsProvider: 'DynDNS',
      dynDNSSettings: dynDNSSettings,
      tzoSettings: tzoSettings,
      noIPSettings: noIPSettings,
    );

    final Map<String, dynamic> ddnsSettingsMap = {
      'ddnsProvider': 'DynDNS',
      'dynDNSSettings': dynDNSSettings.toMap(),
      'tzoSettings': tzoSettings.toMap(),
      'noipSettings': noIPSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(ddnsSettings.toMap(), ddnsSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(DDNSSettingsData.fromMap(ddnsSettingsMap), ddnsSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(ddnsSettings.toJson(), json.encode(ddnsSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DDNSSettingsData.fromJson(json.encode(ddnsSettingsMap)), ddnsSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = ddnsSettings.copyWith(
        ddnsProvider: 'NoIP',
        dynDNSSettings: () => null,
      );
      expect(updatedSettings.ddnsProvider, 'NoIP');
      expect(updatedSettings.dynDNSSettings, null);
      expect(updatedSettings.tzoSettings, ddnsSettings.tzoSettings);
    });

    test('props are correct', () {
      final settings1 = DDNSSettingsData(
        ddnsProvider: 'DynDNS',
        dynDNSSettings: dynDNSSettings,
        tzoSettings: tzoSettings,
        noIPSettings: noIPSettings,
      );
      final settings2 = DDNSSettingsData(
        ddnsProvider: 'DynDNS',
        dynDNSSettings: dynDNSSettings,
        tzoSettings: tzoSettings,
        noIPSettings: noIPSettings,
      );
      final settings3 = DDNSSettingsData(
        ddnsProvider: 'NoIP',
        dynDNSSettings: null,
        tzoSettings: tzoSettings,
        noIPSettings: noIPSettings,
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}