
import 'package:jnap/src/modules/guest_network/action.dart';
import 'package:jnap/src/modules/guest_network/service.dart';
import 'package:test/test.dart';

void main() {
  group('GuestNetwork actions', () {
    test('GetGuestNetworkClients has correct properties', () {
      final action = GetGuestNetworkClients.instance;
      expect(action.name, 'GetGuestNetworkClients');
      expect(action.service, guestNetworkService);
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/GetGuestNetworkClients');
    });

    test('GetGuestNetworkSettings has correct properties', () {
      final action = GetGuestNetworkSettings.instance;
      expect(action.name, 'GetGuestNetworkSettings');
      expect(action.service, guestNetworkService);
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/GetGuestNetworkSettings');
    });

    test('SetGuestNetworkSettings has correct properties', () {
      final action = SetGuestNetworkSettings.instance;
      expect(action.name, 'SetGuestNetworkSettings');
      expect(action.service, guestNetworkService);
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/SetGuestNetworkSettings');
    });

    test('GetGuestRadioSettings has correct properties', () {
      final action = GetGuestRadioSettings.instance;
      expect(action.name, 'GetGuestRadioSettings');
      expect(action.service, guestNetworkService);
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/GetGuestRadioSettings');
    });

    test('SetGuestRadioSettings has correct properties', () {
      final action = SetGuestRadioSettings.instance;
      expect(action.name, 'SetGuestRadioSettings');
      expect(action.service, guestNetworkService);
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/SetGuestRadioSettings');
    });

    test('SetGuestNetworkSettings handles versioning', () {
      final action = SetGuestNetworkSettings.instance;
      guestNetworkService.updateVersion(2);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/SetGuestNetworkSettings3');
    });

    test('GetGuestRadioSettings handles versioning', () {
      final action = GetGuestRadioSettings.instance;
      guestNetworkService.updateVersion(4);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/GetGuestRadioSettings2');
    });

    test('SetGuestRadioSettings handles versioning', () {
      final action = SetGuestRadioSettings.instance;
      guestNetworkService.updateVersion(4);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/guestnetwork/SetGuestRadioSettings2');
    });
  });
}
