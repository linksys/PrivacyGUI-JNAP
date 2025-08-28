import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/no_ip_settings.dart';

void main() {
  group('NoIPSettings', () {
    const noIPSettings = NoIPSettings(
      username: 'user123',
      password: 'pass123',
      hostName: 'myhost.no-ip.com',
    );

    final Map<String, dynamic> noIPSettingsMap = {
      'username': 'user123',
      'password': 'pass123',
      'hostName': 'myhost.no-ip.com',
    };

    test('toMap returns a valid map', () {
      expect(noIPSettings.toMap(), noIPSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(NoIPSettings.fromMap(noIPSettingsMap), noIPSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(noIPSettings.toJson(), json.encode(noIPSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NoIPSettings.fromJson(json.encode(noIPSettingsMap)), noIPSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = noIPSettings.copyWith(
        username: 'newuser',
      );
      expect(updatedSettings.username, 'newuser');
      expect(updatedSettings.password, noIPSettings.password);
    });

    test('props are correct', () {
      final settings1 = NoIPSettings(username: 'u1', password: 'p1', hostName: 'h1');
      final settings2 = NoIPSettings(username: 'u1', password: 'p1', hostName: 'h1');
      final settings3 = NoIPSettings(username: 'u2', password: 'p2', hostName: 'h2');
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
