import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/dyn_dns_settings.dart';

void main() {
  group('DynDNSMailExchangeSettings', () {
    const mailExchangeSettings = DynDNSMailExchangeSettings(
      hostName: 'mail.example.com',
      isBackup: true,
    );

    final Map<String, dynamic> mailExchangeSettingsMap = {
      'hostName': 'mail.example.com',
      'isBackup': true,
    };

    test('toMap returns a valid map', () {
      expect(mailExchangeSettings.toMap(), mailExchangeSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(DynDNSMailExchangeSettings.fromMap(mailExchangeSettingsMap), mailExchangeSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(mailExchangeSettings.toJson(), json.encode(mailExchangeSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DynDNSMailExchangeSettings.fromJson(json.encode(mailExchangeSettingsMap)), mailExchangeSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = mailExchangeSettings.copyWith(
        isBackup: false,
      );
      expect(updatedSettings.isBackup, false);
      expect(updatedSettings.hostName, mailExchangeSettings.hostName);
    });

    test('props are correct', () {
      final settings1 = DynDNSMailExchangeSettings(hostName: 'host1', isBackup: true);
      final settings2 = DynDNSMailExchangeSettings(hostName: 'host1', isBackup: true);
      final settings3 = DynDNSMailExchangeSettings(hostName: 'host2', isBackup: false);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });

  group('DynDNSSettings', () {
    const mailExchangeSettings = DynDNSMailExchangeSettings(
      hostName: 'mail.example.com',
      isBackup: true,
    );

    const dynDNSSettings = DynDNSSettings(
      username: 'user123',
      password: 'pass123',
      hostName: 'myhost.dyndns.org',
      isWildcardEnabled: true,
      mode: 'modeA',
      isMailExchangeEnabled: true,
      mailExchangeSettings: mailExchangeSettings,
    );

    final Map<String, dynamic> dynDNSSettingsMap = {
      'username': 'user123',
      'password': 'pass123',
      'hostName': 'myhost.dyndns.org',
      'isWildcardEnabled': true,
      'mode': 'modeA',
      'isMailExchangeEnabled': true,
      'mailExchangeSettings': mailExchangeSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(dynDNSSettings.toMap(), dynDNSSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(DynDNSSettings.fromMap(dynDNSSettingsMap), dynDNSSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(dynDNSSettings.toJson(), json.encode(dynDNSSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DynDNSSettings.fromJson(json.encode(dynDNSSettingsMap)), dynDNSSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = dynDNSSettings.copyWith(
        username: 'newuser',
        isWildcardEnabled: false,
        mailExchangeSettings: () => null,
      );
      expect(updatedSettings.username, 'newuser');
      expect(updatedSettings.isWildcardEnabled, false);
      expect(updatedSettings.mailExchangeSettings, null);
      expect(updatedSettings.hostName, dynDNSSettings.hostName);
    });

    test('props are correct', () {
      final settings1 = DynDNSSettings(
        username: 'user1',
        password: 'pass1',
        hostName: 'host1',
        isWildcardEnabled: true,
        mode: 'mode1',
        isMailExchangeEnabled: true,
        mailExchangeSettings: mailExchangeSettings,
      );
      final settings2 = DynDNSSettings(
        username: 'user1',
        password: 'pass1',
        hostName: 'host1',
        isWildcardEnabled: true,
        mode: 'mode1',
        isMailExchangeEnabled: true,
        mailExchangeSettings: mailExchangeSettings,
      );
      final settings3 = DynDNSSettings(
        username: 'user2',
        password: 'pass2',
        hostName: 'host2',
        isWildcardEnabled: false,
        mode: 'mode2',
        isMailExchangeEnabled: false,
        mailExchangeSettings: null,
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
