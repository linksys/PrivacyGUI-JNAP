
import 'package:jnap/src/modules/parental_control/action.dart';
import 'package:jnap/src/modules/parental_control/service.dart';
import 'package:test/test.dart';

void main() {
  group('ParentalControl actions', () {
    test('GetParentalControlSettings has correct properties', () {
      final action = GetParentalControlSettings.instance;
      expect(action.name, 'GetParentalControlSettings');
      expect(action.service, parentalControlService);
      expect(action.command, 'http://linksys.com/jnap/parentalcontrol/GetParentalControlSettings');
    });
  });
}
