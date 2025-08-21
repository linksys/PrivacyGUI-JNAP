
import 'package:jnap/src/modules/power_table/action.dart';
import 'package:jnap/src/modules/power_table/service.dart';
import 'package:test/test.dart';

void main() {
  group('PowerTable actions', () {
    test('GetPowerTableSettings has correct properties', () {
      final action = GetPowerTableSettings.instance;
      expect(action.name, 'GetPowerTableSettings');
      expect(action.service, powerTableService);
      expect(action.command, 'http://linksys.com/jnap/powertable/GetPowerTableSettings');
    });

    test('SetPowerTableSettings has correct properties', () {
      final action = SetPowerTableSettings.instance;
      expect(action.name, 'SetPowerTableSettings');
      expect(action.service, powerTableService);
      expect(action.command, 'http://linksys.com/jnap/powertable/SetPowerTableSettings');
    });
  });
}
