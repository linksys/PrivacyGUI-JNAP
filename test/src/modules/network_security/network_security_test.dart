
import 'package:jnap/src/modules/network_security/action.dart';
import 'package:jnap/src/modules/network_security/service.dart';
import 'package:test/test.dart';

void main() {
  group('NetworkSecurity actions', () {
    test('GetNetworkSecuritySettings has correct properties', () {
      final action = GetNetworkSecuritySettings.instance;
      expect(action.name, 'GetNetworkSecuritySettings');
      expect(action.service, networkSecurityService);
      expect(action.command, 'http://linksys.com/jnap/networksecurity/GetNetworkSecuritySettings');
    });

    test('SetNetworkSecuritySettings has correct properties', () {
      final action = SetNetworkSecuritySettings.instance;
      expect(action.name, 'SetNetworkSecuritySettings');
      expect(action.service, networkSecurityService);
      expect(action.command, 'http://linksys.com/jnap/networksecurity/SetNetworkSecuritySettings');
    });

    test('GetNetworkSecuritySettings handles versioning', () {
      final action = GetNetworkSecuritySettings.instance;
      networkSecurityService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/networksecurity/GetNetworkSecuritySettings2');
    });

    test('SetNetworkSecuritySettings handles versioning', () {
      final action = SetNetworkSecuritySettings.instance;
      networkSecurityService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/networksecurity/SetNetworkSecuritySettings2');
    });
  });
}
