
import 'package:jnap/src/modules/mlo/action.dart';
import 'package:jnap/src/modules/mlo/service.dart';
import 'package:test/test.dart';

void main() {
  group('MLO actions', () {
    test('GetMLOSettings has correct properties', () {
      final action = GetMLOSettings.instance;
      expect(action.name, 'GetMLOSettings');
      expect(action.service, mloService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetMLOSettings');
    });

    test('SetMLOSettings has correct properties', () {
      final action = SetMLOSettings.instance;
      expect(action.name, 'SetMLOSettings');
      expect(action.service, mloService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/SetMLOSettings');
    });
  });
}
