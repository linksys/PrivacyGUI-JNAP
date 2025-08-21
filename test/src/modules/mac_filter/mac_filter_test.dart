
import 'package:jnap/src/modules/mac_filter/action.dart';
import 'package:jnap/src/modules/mac_filter/service.dart';
import 'package:test/test.dart';

void main() {
  group('MACFilter actions', () {
    test('GetMACFilterSettings has correct properties', () {
      final action = GetMACFilterSettings.instance;
      expect(action.name, 'GetMACFilterSettings');
      expect(action.service, macFilterService);
      expect(action.command, 'http://linksys.com/jnap/macfilter/GetMACFilterSettings');
    });

    test('SetMACFilterSettings has correct properties', () {
      final action = SetMACFilterSettings.instance;
      expect(action.name, 'SetMACFilterSettings');
      expect(action.service, macFilterService);
      expect(action.command, 'http://linksys.com/jnap/macfilter/SetMACFilterSettings');
    });

    test('GetSTABSSIDS has correct properties', () {
      final action = GetSTABSSIDS.instance;
      expect(action.name, 'GetSTABSSIDS');
      expect(action.service, macFilterService);
      expect(action.command, 'http://linksys.com/jnap/macfilter/GetSTABSSIDS');
    });
  });
}
