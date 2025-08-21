import 'package:test/test.dart';
import 'package:jnap/src/modules/dfs/action.dart';
import 'package:jnap/src/modules/dfs/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

void main() {
  group('DFSSAction', () {
    test('GetDFSSettings has correct properties', () {
      final action = GetDFSSettings.instance;
      expect(action.name, 'GetDFSSettings');
      expect(action.service, dfsService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/GetDFSSettings');
    });

    test('SetDFSSettings has correct properties', () {
      final action = SetDFSSettings.instance;
      expect(action.name, 'SetDFSSettings');
      expect(action.service, dfsService);
      expect(action.command, 'http://linksys.com/jnap/wirelessap/SetDFSSettings');
    });

    test('DFSSAction.all contains all actions', () {
      final actions = DFSSAction.all;
      expect(actions, contains(isA<GetDFSSettings>()));
      expect(actions, contains(isA<SetDFSSettings>()));
      expect(actions.length, 2);
    });
  });
}
