
import 'package:jnap/src/modules/wireless_ap/action.dart';
import 'package:jnap/src/modules/wireless_ap/service.dart';
import 'package:test/test.dart';

void main() {
  group('WirelessAP actions', () {
    test('GetRadioInfo has correct properties', () {
      final action = GetRadioInfo.instance;
      expect(action.name, 'GetRadioInfo');
      expect(action.service, wirelessAPService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetRadioInfo');
    });

    test('GetWPSServerSessionStatus has correct properties', () {
      final action = GetWPSServerSessionStatus.instance;
      expect(action.name, 'GetWPSServerSessionStatus');
      expect(action.service, wirelessAPService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetWPSServerSessionStatus');
    });

    test('SetRadioSettings has correct properties', () {
      final action = SetRadioSettings.instance;
      expect(action.name, 'SetRadioSettings');
      expect(action.service, wirelessAPService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/SetRadioSettings');
    });

    test('ClientDeauth has correct properties', () {
      final action = ClientDeauth.instance;
      expect(action.name, 'ClientDeauth');
      expect(action.service, wirelessAPService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/ClientDeauth');
    });

    test('GetRadioInfo handles versioning', () {
      final action = GetRadioInfo.instance;
      wirelessAPService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetRadioInfo2');
      wirelessAPService.updateVersion(4);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetRadioInfo3');
    });

    test('SetRadioSettings handles versioning', () {
      final action = SetRadioSettings.instance;
      wirelessAPService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/wirelessap/SetRadioSettings2');
      wirelessAPService.updateVersion(4);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/wirelessap/SetRadioSettings3');
    });
  });
}
