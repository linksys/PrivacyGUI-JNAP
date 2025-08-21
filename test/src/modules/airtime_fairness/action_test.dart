import 'package:test/test.dart';
import 'package:jnap/src/modules/airtime_fairness/action.dart';
import 'package:jnap/src/modules/airtime_fairness/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

void main() {
  group('AirtimeFairnessAction', () {
    test('GetAirtimeFairnessSettings has correct properties', () {
      final action = GetAirtimeFairnessSettings.instance;
      expect(action.name, 'GetAirtimeFairnessSettings');
      expect(action.service, airtimeFairnessService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetAirtimeFairnessSettings');
    });

    test('SetAirtimeFairnessSettings has correct properties', () {
      final action = SetAirtimeFairnessSettings.instance;
      expect(action.name, 'SetAirtimeFairnessSettings');
      expect(action.service, airtimeFairnessService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/SetAirtimeFairnessSettings');
    });

    test('AirtimeFairnessAction.all contains all actions', () {
      final actions = AirtimeFairnessAction.all;
      expect(actions, contains(isA<GetAirtimeFairnessSettings>()));
      expect(actions, contains(isA<SetAirtimeFairnessSettings>()));
      expect(actions.length, 2);
    });
  });
}
