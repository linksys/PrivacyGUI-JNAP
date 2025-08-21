
import 'package:jnap/src/modules/vpn/action.dart';
import 'package:jnap/src/modules/vpn/service.dart';
import 'package:test/test.dart';

void main() {
  group('VPN actions', () {
    test('TestVPNConnection has correct properties', () {
      final action = TestVPNConnection.instance;
      expect(action.name, 'TestVPNConnection');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/TestVPNConnection');
    });

    test('GetTunneledUser has correct properties', () {
      final action = GetTunneledUser.instance;
      expect(action.name, 'GetTunneledUser');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/GetTunneledUser');
    });

    test('SetTunneledUser has correct properties', () {
      final action = SetTunneledUser.instance;
      expect(action.name, 'SetTunneledUser');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/SetTunneledUser');
    });

    test('SetVPNApply has correct properties', () {
      final action = SetVPNApply.instance;
      expect(action.name, 'SetVPNApply');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/SetVPNApply');
    });

    test('GetVPNUser has correct properties', () {
      final action = GetVPNUser.instance;
      expect(action.name, 'GetVPNUser');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/GetVPNUser');
    });

    test('SetVPNUser has correct properties', () {
      final action = SetVPNUser.instance;
      expect(action.name, 'SetVPNUser');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/SetVPNUser');
    });

    test('GetVPNGateway has correct properties', () {
      final action = GetVPNGateway.instance;
      expect(action.name, 'GetVPNGateway');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/GetVPNGateway');
    });

    test('SetVPNGateway has correct properties', () {
      final action = SetVPNGateway.instance;
      expect(action.name, 'SetVPNGateway');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/SetVPNGateway');
    });

    test('GetVPNService has correct properties', () {
      final action = GetVPNService.instance;
      expect(action.name, 'GetVPNService');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/GetVPNService');
    });

    test('SetVPNService has correct properties', () {
      final action = SetVPNService.instance;
      expect(action.name, 'SetVPNService');
      expect(action.service, vpnService);
      expect(action.command, 'http://linksys.com/jnap/vpn/SetVPNService');
    });
  });
}
