
import 'package:jnap/src/modules/gaming_prioritization/action.dart';
import 'package:jnap/src/modules/gaming_prioritization/service.dart';
import 'package:test/test.dart';

void main() {
  group('GamingPrioritization actions', () {
    test('GetGamingPrioritizationSettings has correct properties', () {
      final action = GetGamingPrioritizationSettings.instance;
      expect(action.name, 'GetGamingPrioritizationSettings');
      expect(action.service, gamingPrioritizationService);
      expect(action.command, 'http://linksys.com/jnap/gamingprioritization/GetGamingPrioritizationSettings');
    });

    test('SetGamingPrioritizationSettings has correct properties', () {
      final action = SetGamingPrioritizationSettings.instance;
      expect(action.name, 'SetGamingPrioritizationSettings');
      expect(action.service, gamingPrioritizationService);
      expect(action.command, 'http://linksys.com/jnap/gamingprioritization/SetGamingPrioritizationSettings');
    });
  });
}
