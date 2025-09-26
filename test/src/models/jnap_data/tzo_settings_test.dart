import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/tzo_settings.dart';

void main() {
  group('TZOSettingsData', () {
    const tzoSettings = TZOSettingsData(
      username: 'user123',
      password: 'pass123',
      hostName: 'myhost.tzo.com',
    );

    final Map<String, dynamic> tzoSettingsMap = {
      'username': 'user123',
      'password': 'pass123',
      'hostName': 'myhost.tzo.com',
    };

    test('toMap returns a valid map', () {
      expect(tzoSettings.toMap(), tzoSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(TZOSettingsData.fromMap(tzoSettingsMap), tzoSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(tzoSettings.toJson(), json.encode(tzoSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(TZOSettingsData.fromJson(json.encode(tzoSettingsMap)), tzoSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = tzoSettings.copyWith(
        username: 'newuser',
      );
      expect(updatedSettings.username, 'newuser');
      expect(updatedSettings.password, tzoSettings.password);
    });

    test('props are correct', () {
      final settings1 = TZOSettingsData(username: 'u1', password: 'p1', hostName: 'h1');
      final settings2 = TZOSettingsData(username: 'u1', password: 'p1', hostName: 'h1');
      final settings3 = TZOSettingsData(username: 'u2', password: 'p2', hostName: 'h2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}