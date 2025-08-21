
import 'package:jnap/src/modules/settings/action.dart';
import 'package:jnap/src/modules/settings/service.dart';
import 'package:test/test.dart';

void main() {
  group('Settings actions', () {
    test('GetRemoteSetting has correct properties', () {
      final action = GetRemoteSetting.instance;
      expect(action.name, 'GetRemoteSetting');
      expect(action.service, settingsService);
      expect(action.command, 'http://linksys.com/jnap/ui/GetRemoteSetting');
    });

    test('SetRemoteSetting has correct properties', () {
      final action = SetRemoteSetting.instance;
      expect(action.name, 'SetRemoteSetting');
      expect(action.service, settingsService);
      expect(action.command, 'http://linksys.com/jnap/ui/SetRemoteSetting');
    });
  });
}
