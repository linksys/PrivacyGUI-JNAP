
import 'package:jnap/src/modules/setup/action.dart';
import 'package:jnap/src/modules/setup/service.dart';
import 'package:test/test.dart';

void main() {
  group('Setup actions', () {
    test('GetSelectedChannels has correct properties', () {
      final action = GetSelectedChannels.instance;
      expect(action.name, 'GetSelectedChannels');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetSelectedChannels');
    });

    test('StartAutoChannelSelection has correct properties', () {
      final action = StartAutoChannelSelection.instance;
      expect(action.name, 'StartAutoChannelSelection');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/StartAutoChannelSelection');
    });

    test('GetAutoConfigurationSettings has correct properties', () {
      final action = GetAutoConfigurationSettings.instance;
      expect(action.name, 'GetAutoConfigurationSettings');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetAutoConfigurationSettings');
    });

    test('SetUserAcknowledgedAutoConfiguration has correct properties', () {
      final action = SetUserAcknowledgedAutoConfiguration.instance;
      expect(action.name, 'SetUserAcknowledgedAutoConfiguration');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/SetUserAcknowledgedAutoConfiguration');
    });

    test('GetWANDetectionStatus has correct properties', () {
      final action = GetWANDetectionStatus.instance;
      expect(action.name, 'GetWANDetectionStatus');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetWANDetectionStatus');
    });

    test('IsAdminPasswordSetByUser has correct properties', () {
      final action = IsAdminPasswordSetByUser.instance;
      expect(action.name, 'IsAdminPasswordSetByUser');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/IsAdminPasswordSetByUser');
    });

    test('SetAdminPassword has correct properties', () {
      final action = SetAdminPassword.instance;
      expect(action.name, 'SetAdminPassword');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/SetAdminPassword');
    });

    test('VerifyRouterResetCode has correct properties', () {
      final action = VerifyRouterResetCode.instance;
      expect(action.name, 'VerifyRouterResetCode');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/VerifyRouterResetCode');
    });

    test('GetVersionInfo has correct properties', () {
      final action = GetVersionInfo.instance;
      expect(action.name, 'GetVersionInfo');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetVersionInfo');
    });

    test('GetPortConnectionStatus has correct properties', () {
      final action = GetPortConnectionStatus.instance;
      expect(action.name, 'GetPortConnectionStatus');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetPortConnectionStatus');
    });

    test('GetWANPort has correct properties', () {
      final action = GetWANPort.instance;
      expect(action.name, 'GetWANPort');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetWANPort');
    });

    test('SetWANPort has correct properties', () {
      final action = SetWANPort.instance;
      expect(action.name, 'SetWANPort');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/SetWANPort');
    });

    test('GetInternetConnectionStatus has correct properties', () {
      final action = GetInternetConnectionStatus.instance;
      expect(action.name, 'GetInternetConnectionStatus');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetInternetConnectionStatus');
    });

    test('GetSimpleWiFiSettings has correct properties', () {
      final action = GetSimpleWiFiSettings.instance;
      expect(action.name, 'GetSimpleWiFiSettings');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetSimpleWiFiSettings');
    });

    test('SetSimpleWiFiSettings has correct properties', () {
      final action = SetSimpleWiFiSettings.instance;
      expect(action.name, 'SetSimpleWiFiSettings');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/SetSimpleWiFiSettings');
    });

    test('GetMACAddress has correct properties', () {
      final action = GetMACAddress.instance;
      expect(action.name, 'GetMACAddress');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/GetMACAddress');
    });

    test('StartBlinkingNodeLed has correct properties', () {
      final action = StartBlinkingNodeLed.instance;
      expect(action.name, 'StartBlinkingNodeLed');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/StartBlinkingNodeLed');
    });

    test('StopBlinkingNodeLed has correct properties', () {
      final action = StopBlinkingNodeLed.instance;
      expect(action.name, 'StopBlinkingNodeLed');
      expect(action.service, setupService);
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/StopBlinkingNodeLed');
    });

    test('SetAdminPassword handles versioning', () {
      final action = SetAdminPassword.instance;
      setupService.updateVersion(8);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/nodes/setup/SetAdminPassword2');
    });
  });
}
