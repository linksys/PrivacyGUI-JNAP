import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/dyn_dns_settings.dart';

void main() {
  group('DynDNSMailExchangeSettingsData', () {
    const mailExchangeSettings = DynDNSMailExchangeSettingsData(
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
      expect(DynDNSMailExchangeSettingsData.fromMap(mailExchangeSettingsMap), mailExchangeSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(mailExchangeSettings.toJson(), json.encode(mailExchangeSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DynDNSMailExchangeSettingsData.fromJson(json.encode(mailExchangeSettingsMap)), mailExchangeSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = mailExchangeSettings.copyWith(
        isBackup: false,
      );
      expect(updatedSettings.isBackup, false);
      expect(updatedSettings.hostName, mailExchangeSettings.hostName);
    });

    test('props are correct', () {
      final settings1 = DynDNSMailExchangeSettingsData(hostName: 'host1', isBackup: true);
      final settings2 = DynDNSMailExchangeSettingsData(hostName: 'host1', isBackup: true);
      final settings3 = DynDNSMailExchangeSettingsData(hostName: 'host2', isBackup: false);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });

  group('DynDNSSettingsData', () {
    const mailExchangeSettings = DynDNSMailExchangeSettingsData(
      hostName: 'mail.example.com',
      isBackup: true,
    );

    const dynDNSSettings = DynDNSSettingsData(
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
      expect(DynDNSSettingsData.fromMap(dynDNSSettingsMap), dynDNSSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(dynDNSSettings.toJson(), json.encode(dynDNSSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DynDNSSettingsData.fromJson(json.encode(dynDNSSettingsMap)), dynDNSSettings);
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
      final settings1 = DynDNSSettingsData(
        username: 'user1',
        password: 'pass1',
        hostName: 'host1',
        isWildcardEnabled: true,
        mode: 'mode1',
        isMailExchangeEnabled: true,
        mailExchangeSettings: mailExchangeSettings,
      );
      final settings2 = DynDNSSettingsData(
        username: 'user1',
        password: 'pass1',
        hostName: 'host1',
        isWildcardEnabled: true,
        mode: 'mode1',
        isMailExchangeEnabled: true,
        mailExchangeSettings: mailExchangeSettings,
      );
      final settings3 = DynDNSSettingsData(
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