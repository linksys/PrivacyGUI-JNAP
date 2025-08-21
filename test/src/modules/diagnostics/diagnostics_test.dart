
import 'package:jnap/src/modules/diagnostics/action.dart';
import 'package:jnap/src/modules/diagnostics/service.dart';
import 'package:test/test.dart';

void main() {
  group('Diagnostics actions', () {
    test('ExecSysCommand has correct properties', () {
      final action = ExecSysCommand.instance;
      expect(action.name, 'ExecSysCommand');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/ExecSysCommand');
    });

    test('GetPingStatus has correct properties', () {
      final action = GetPingStatus.instance;
      expect(action.name, 'GetPingStatus');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/GetPingStatus');
    });

    test('GetSysinfoData has correct properties', () {
      final action = GetSysinfoData.instance;
      expect(action.name, 'GetSysinfoData');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/GetSysinfoData');
    });

    test('GetSystemStats has correct properties', () {
      final action = GetSystemStats.instance;
      expect(action.name, 'GetSystemStats');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/GetSystemStats');
    });

    test('GetTracerouteStatus has correct properties', () {
      final action = GetTracerouteStatus.instance;
      expect(action.name, 'GetTracerouteStatus');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/GetTracerouteStatus');
    });

    test('RestorePreviousFirmware has correct properties', () {
      final action = RestorePreviousFirmware.instance;
      expect(action.name, 'RestorePreviousFirmware');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/RestorePreviousFirmware');
    });

    test('SendSysinfoEmail has correct properties', () {
      final action = SendSysinfoEmail.instance;
      expect(action.name, 'SendSysinfoEmail');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/SendSysinfoEmail');
    });

    test('StartPing has correct properties', () {
      final action = StartPing.instance;
      expect(action.name, 'StartPing');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/StartPing');
    });

    test('StartTraceroute has correct properties', () {
      final action = StartTraceroute.instance;
      expect(action.name, 'StartTraceroute');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/StartTraceroute');
    });

    test('StopPing has correct properties', () {
      final action = StopPing.instance;
      expect(action.name, 'StopPing');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/StopPing');
    });

    test('StopTraceroute has correct properties', () {
      final action = StopTraceroute.instance;
      expect(action.name, 'StopTraceroute');
      expect(action.service, diagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/diagnostics/StopTraceroute');
    });

    test('GetSystemStats handles versioning', () {
      final action = GetSystemStats.instance;
      diagnosticsService.updateVersion(10);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/diagnostics/GetSystemStats2');
    });
  });
}
