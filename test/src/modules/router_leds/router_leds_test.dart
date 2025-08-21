
import 'package:jnap/src/modules/router_leds/action.dart';
import 'package:jnap/src/modules/router_leds/service.dart';
import 'package:test/test.dart';

void main() {
  group('RouterLEDs actions', () {
    test('GetLedNightModeSetting has correct properties', () {
      final action = GetLedNightModeSetting.instance;
      expect(action.name, 'GetLedNightModeSetting');
      expect(action.service, routerLEDsService);
      expect(action.command, 'http://linksys.com/jnap/routerleds/GetLedNightModeSetting');
    });

    test('SetLedNightModeSetting has correct properties', () {
      final action = SetLedNightModeSetting.instance;
      expect(action.name, 'SetLedNightModeSetting');
      expect(action.service, routerLEDsService);
      expect(action.command, 'http://linksys.com/jnap/routerleds/SetLedNightModeSetting');
    });

    test('SetLedNightModeSetting handles versioning', () {
      final action = SetLedNightModeSetting.instance;
      routerLEDsService.updateVersion(4);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/routerleds/SetLedNightModeSetting2');
    });
  });
}
