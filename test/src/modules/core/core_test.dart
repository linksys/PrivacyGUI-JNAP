import 'package:jnap/src/modules/core/action.dart';
import 'package:jnap/src/modules/core/service.dart';
import 'package:test/test.dart';

void main() {
  group('Core actions', () {
    test('Transaction has correct properties', () {
      final action = Transaction.instance;
      expect(action.name, 'Transaction');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/Transaction');
    });

    test('CheckAdminPassword has correct properties', () {
      final action = CheckAdminPassword.instance;
      expect(action.name, 'CheckAdminPassword');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/CheckAdminPassword');
    });

    test('CoreSetAdminPassword has correct properties', () {
      final action = CoreSetAdminPassword.instance;
      expect(action.name, 'SetAdminPassword');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/SetAdminPassword');
    });

    test('CorePnPSetAdminPassword has correct properties', () {
      final action = CorePnPSetAdminPassword.instance;
      coreService.updateVersion(2);
      expect(action.name, 'SetAdminPassword');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/SetAdminPassword2');
    });

    test('GetAdminPasswordAuthStatus has correct properties', () {
      final action = GetAdminPasswordAuthStatus.instance;
      expect(action.name, 'GetAdminPasswordAuthStatus');
      expect(action.service, coreService);
      expect(action.command,
          'http://linksys.com/jnap/core/GetAdminPasswordAuthStatus');
    });

    test('GetAdminPasswordHint has correct properties', () {
      final action = GetAdminPasswordHint.instance;
      expect(action.name, 'GetAdminPasswordHint');
      expect(action.service, coreService);
      expect(
          action.command, 'http://linksys.com/jnap/core/GetAdminPasswordHint');
    });

    test('GetDataUploadUserConsent has correct properties', () {
      final action = GetDataUploadUserConsent.instance;
      expect(action.name, 'GetDataUploadUserConsent');
      expect(action.service, coreService);
      expect(action.command,
          'http://linksys.com/jnap/core/GetDataUploadUserConsent');
    });

    test('GetDeviceInfo has correct properties', () {
      final action = GetDeviceInfo.instance;
      expect(action.name, 'GetDeviceInfo');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/GetDeviceInfo');
    });

    test('GetUnsecuredWiFiWarning has correct properties', () {
      final action = GetUnsecuredWiFiWarning.instance;
      expect(action.name, 'GetUnsecuredWiFiWarning');
      expect(action.service, coreService);
      expect(action.command,
          'http://linksys.com/jnap/core/GetUnsecuredWiFiWarning');
    });

    test('SetUnsecuredWiFiWarning has correct properties', () {
      final action = SetUnsecuredWiFiWarning.instance;
      expect(action.name, 'SetUnsecuredWiFiWarning');
      expect(action.service, coreService);
      expect(action.command,
          'http://linksys.com/jnap/core/SetUnsecuredWiFiWarning');
    });

    test('IsAdminPasswordDefault has correct properties', () {
      final action = IsAdminPasswordDefault.instance;
      expect(action.name, 'IsAdminPasswordDefault');
      expect(action.service, coreService);
      expect(action.command,
          'http://linksys.com/jnap/core/IsAdminPasswordDefault');
    });

    test('IsServiceSupported has correct properties', () {
      final action = IsServiceSupported.instance;
      expect(action.name, 'IsServiceSupported');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/IsServiceSupported');
    });

    test('Reboot has correct properties', () {
      final action = Reboot.instance;
      expect(action.name, 'Reboot');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/Reboot');
    });

    test('Reboot2 has correct properties', () {
      final action = Reboot2.instance;
      expect(action.name, 'Reboot2');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/Reboot2');
    });

    test('FactoryReset has correct properties', () {
      final action = FactoryReset.instance;
      expect(action.name, 'FactoryReset');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/FactoryReset');
    });

    test('FactoryReset2 has correct properties', () {
      final action = FactoryReset2.instance;
      expect(action.name, 'FactoryReset2');
      expect(action.service, coreService);
      expect(action.command, 'http://linksys.com/jnap/core/FactoryReset2');
    });

    test('CheckAdminPassword handles versioning', () {
      final action = CheckAdminPassword.instance;
      coreService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(
          action.command, 'http://linksys.com/jnap/core/CheckAdminPassword2');
      coreService.updateVersion(7);
      expect(action.latestVersion, '3');
      expect(
          action.command, 'http://linksys.com/jnap/core/CheckAdminPassword3');
    });

    test('CoreSetAdminPassword handles versioning', () {
      final action = CoreSetAdminPassword.instance;
      coreService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/core/SetAdminPassword2');
      coreService.updateVersion(7);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/core/SetAdminPassword3');
    });
  });
}
