
import 'package:jnap/src/modules/router/action.dart';
import 'package:jnap/src/modules/router/service.dart';
import 'package:test/test.dart';

void main() {
  group('Router actions', () {
    test('GetDHCPClientLeases has correct properties', () {
      final action = GetDHCPClientLeases.instance;
      expect(action.name, 'GetDHCPClientLeases');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetDHCPClientLeases');
    });

    test('GetIPv6Settings has correct properties', () {
      final action = GetIPv6Settings.instance;
      expect(action.name, 'GetIPv6Settings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetIPv6Settings');
    });

    test('GetLANSettings has correct properties', () {
      final action = GetLANSettings.instance;
      expect(action.name, 'GetLANSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetLANSettings');
    });

    test('GetMACAddressCloneSettings has correct properties', () {
      final action = GetMACAddressCloneSettings.instance;
      expect(action.name, 'GetMACAddressCloneSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetMACAddressCloneSettings');
    });

    test('GetWANSettings has correct properties', () {
      final action = GetWANSettings.instance;
      expect(action.name, 'GetWANSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetWANSettings');
    });

    test('GetWANStatus has correct properties', () {
      final action = GetWANStatus.instance;
      expect(action.name, 'GetWANStatus');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetWANStatus');
    });

    test('GetRoutingSettings has correct properties', () {
      final action = GetRoutingSettings.instance;
      expect(action.name, 'GetRoutingSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetRoutingSettings');
    });

    test('SetIPv6Settings has correct properties', () {
      final action = SetIPv6Settings.instance;
      expect(action.name, 'SetIPv6Settings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/SetIPv6Settings');
    });

    test('SetMACAddressCloneSettings has correct properties', () {
      final action = SetMACAddressCloneSettings.instance;
      expect(action.name, 'SetMACAddressCloneSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/SetMACAddressCloneSettings');
    });

    test('SetWANSettings has correct properties', () {
      final action = SetWANSettings.instance;
      expect(action.name, 'SetWANSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/SetWANSettings');
    });

    test('SetLANSettings has correct properties', () {
      final action = SetLANSettings.instance;
      expect(action.name, 'SetLANSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/SetLANSettings');
    });

    test('SetRoutingSettings has correct properties', () {
      final action = SetRoutingSettings.instance;
      expect(action.name, 'SetRoutingSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/SetRoutingSettings');
    });

    test('ReleaseDHCPWANLease has correct properties', () {
      final action = ReleaseDHCPWANLease.instance;
      expect(action.name, 'ReleaseDHCPWANLease');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/ReleaseDHCPWANLease');
    });

    test('ReleaseDHCPIPv6WANLease has correct properties', () {
      final action = ReleaseDHCPIPv6WANLease.instance;
      expect(action.name, 'ReleaseDHCPIPv6WANLease');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/ReleaseDHCPIPv6WANLease');
    });

    test('RenewDHCPWANLease has correct properties', () {
      final action = RenewDHCPWANLease.instance;
      expect(action.name, 'RenewDHCPWANLease');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/RenewDHCPWANLease');
    });

    test('RenewDHCPIPv6WANLease has correct properties', () {
      final action = RenewDHCPIPv6WANLease.instance;
      expect(action.name, 'RenewDHCPIPv6WANLease');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/RenewDHCPIPv6WANLease');
    });

    test('GetEthernetPortConnections has correct properties', () {
      final action = GetEthernetPortConnections.instance;
      expect(action.name, 'GetEthernetPortConnections');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetEthernetPortConnections');
    });

    test('GetExpressForwardingSettings has correct properties', () {
      final action = GetExpressForwardingSettings.instance;
      expect(action.name, 'GetExpressForwardingSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetExpressForwardingSettings');
    });

    test('SetExpressForwardingSettings has correct properties', () {
      final action = SetExpressForwardingSettings.instance;
      expect(action.name, 'SetExpressForwardingSettings');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/SetExpressForwardingSettings');
    });

    test('GetWANExternal has correct properties', () {
      final action = GetWANExternal.instance;
      expect(action.name, 'GetWANExternal');
      expect(action.service, routerService);
      expect(action.command, 'http://linksys.com/jnap/router/GetWANExternal');
    });

    test('GetIPv6Settings handles versioning', () {
      final action = GetIPv6Settings.instance;
      routerService.updateVersion(5);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/router/GetIPv6Settings2');
    });

    test('GetWANSettings handles versioning', () {
      final action = GetWANSettings.instance;
      routerService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/router/GetWANSettings2');
      routerService.updateVersion(7);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/router/GetWANSettings3');
      routerService.updateVersion(8);
      expect(action.latestVersion, '4');
      expect(action.command, 'http://linksys.com/jnap/router/GetWANSettings4');
      routerService.updateVersion(10);
      expect(action.latestVersion, '5');
      expect(action.command, 'http://linksys.com/jnap/router/GetWANSettings5');
    });

    test('GetWANStatus handles versioning', () {
      final action = GetWANStatus.instance;
      routerService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/router/GetWANStatus2');
      routerService.updateVersion(5);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/router/GetWANStatus3');
    });

    test('SetIPv6Settings handles versioning', () {
      final action = SetIPv6Settings.instance;
      routerService.updateVersion(5);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/router/SetIPv6Settings2');
    });

    test('SetWANSettings handles versioning', () {
      final action = SetWANSettings.instance;
      routerService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/router/SetWANSettings2');
      routerService.updateVersion(7);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/router/SetWANSettings3');
      routerService.updateVersion(8);
      expect(action.latestVersion, '4');
      expect(action.command, 'http://linksys.com/jnap/router/SetWANSettings4');
      routerService.updateVersion(14);
      expect(action.latestVersion, '5');
      expect(action.command, 'http://linksys.com/jnap/router/SetWANSettings5');
    });
  });
}
