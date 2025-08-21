
import 'package:jnap/src/modules/locale/action.dart';
import 'package:jnap/src/modules/locale/service.dart';
import 'package:test/test.dart';

void main() {
  group('Locale actions', () {
    test('GetLocalTime has correct properties', () {
      final action = GetLocalTime.instance;
      expect(action.name, 'GetLocalTime');
      expect(action.service, localeService);
      expect(action.command, 'http://linksys.com/jnap/locale/GetLocalTime');
    });

    test('GetTimeSettings has correct properties', () {
      final action = GetTimeSettings.instance;
      expect(action.name, 'GetTimeSettings');
      expect(action.service, localeService);
      expect(action.command, 'http://linksys.com/jnap/locale/GetTimeSettings');
    });

    test('GetLocale has correct properties', () {
      final action = GetLocale.instance;
      expect(action.name, 'GetLocale');
      expect(action.service, localeService);
      expect(action.command, 'http://linksys.com/jnap/locale/GetLocale');
    });

    test('SetLocale has correct properties', () {
      final action = SetLocale.instance;
      expect(action.name, 'SetLocale');
      expect(action.service, localeService);
      expect(action.command, 'http://linksys.com/jnap/locale/SetLocale');
    });

    test('SetTimeSettings has correct properties', () {
      final action = SetTimeSettings.instance;
      expect(action.name, 'SetTimeSettings');
      expect(action.service, localeService);
      expect(action.command, 'http://linksys.com/jnap/locale/SetTimeSettings');
    });
  });
}
