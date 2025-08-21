
import 'package:jnap/src/modules/ddns/action.dart';
import 'package:jnap/src/modules/ddns/service.dart';
import 'package:test/test.dart';

void main() {
  group('DDNS actions', () {
    test('GetDDNSSettings has correct properties', () {
      final action = GetDDNSSettings.instance;
      expect(action.name, 'GetDDNSSettings');
      expect(action.service, ddnsService);
      expect(action.command, 'http://linksys.com/jnap/ddns/GetDDNSSettings');
    });

    test('GetDDNSStatus has correct properties', () {
      final action = GetDDNSStatus.instance;
      expect(action.name, 'GetDDNSStatus');
      expect(action.service, ddnsService);
      expect(action.command, 'http://linksys.com/jnap/ddns/GetDDNSStatus');
    });

    test('GetSupportedDDNSProviders has correct properties', () {
      final action = GetSupportedDDNSProviders.instance;
      expect(action.name, 'GetSupportedDDNSProviders');
      expect(action.service, ddnsService);
      expect(action.command, 'http://linksys.com/jnap/ddns/GetSupportedDDNSProviders');
    });

    test('SetDDNSSettings has correct properties', () {
      final action = SetDDNSSettings.instance;
      expect(action.name, 'SetDDNSSettings');
      expect(action.service, ddnsService);
      expect(action.command, 'http://linksys.com/jnap/ddns/SetDDNSSettings');
    });

    test('GetDDNSStatus handles versioning', () {
      final action = GetDDNSStatus.instance;
      ddnsService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/ddns/GetDDNSStatus2');
    });
  });
}
