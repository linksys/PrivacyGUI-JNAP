import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/simple_wifi_settings.dart';

void main() {
  group('SimpleWiFiSettingsData', () {
    const simpleWiFiSettings = SimpleWiFiSettingsData(
      band: '2.4GHz',
      ssid: 'MyWiFi',
      security: 'WPA2',
      passphrase: 'password123',
    );

    final Map<String, dynamic> simpleWiFiSettingsMap = {
      'band': '2.4GHz',
      'ssid': 'MyWiFi',
      'security': 'WPA2',
      'passphrase': 'password123',
    };

    test('toMap returns a valid map', () {
      expect(simpleWiFiSettings.toMap(), simpleWiFiSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SimpleWiFiSettingsData.fromMap(simpleWiFiSettingsMap), simpleWiFiSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(simpleWiFiSettings.toJson(), json.encode(simpleWiFiSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SimpleWiFiSettingsData.fromJson(json.encode(simpleWiFiSettingsMap)), simpleWiFiSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = simpleWiFiSettings.copyWith(
        ssid: 'NewWiFi',
        passphrase: 'newpass',
      );
      expect(updatedSettings.ssid, 'NewWiFi');
      expect(updatedSettings.passphrase, 'newpass');
      expect(updatedSettings.band, simpleWiFiSettings.band);
    });

    test('props are correct', () {
      final settings1 = SimpleWiFiSettingsData(band: 'b1', ssid: 's1', security: 'sec1', passphrase: 'p1');
      final settings2 = SimpleWiFiSettingsData(band: 'b1', ssid: 's1', security: 'sec1', passphrase: 'p1');
      final settings3 = SimpleWiFiSettingsData(band: 'b2', ssid: 's2', security: 'sec2', passphrase: 'p2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}