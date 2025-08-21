
import 'package:jnap/src/modules/iptv/action.dart';
import 'package:jnap/src/modules/iptv/service.dart';
import 'package:test/test.dart';

void main() {
  group('IPTV actions', () {
    test('GetIPTVSettings has correct properties', () {
      final action = GetIPTVSettings.instance;
      expect(action.name, 'GetIPTVSettings');
      expect(action.service, iptvService);
      expect(action.command, 'http://linksys.com/jnap/iptv/GetIPTVSettings');
    });

    test('SetIPTVSettings has correct properties', () {
      final action = SetIPTVSettings.instance;
      expect(action.name, 'SetIPTVSettings');
      expect(action.service, iptvService);
      expect(action.command, 'http://linksys.com/jnap/iptv/SetIPTVSettings');
    });
  });
}
