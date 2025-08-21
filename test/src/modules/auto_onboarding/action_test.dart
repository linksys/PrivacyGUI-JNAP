import 'package:test/test.dart';
import 'package:jnap/src/modules/auto_onboarding/action.dart';
import 'package:jnap/src/modules/auto_onboarding/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

void main() {
  group('AutoOnboardingAction', () {
    test('GetBluetoothAutoOnboardingSettings has correct properties', () {
      final action = GetBluetoothAutoOnboardingSettings.instance;
      expect(action.name, 'GetBluetoothAutoOnboardingSettings');
      expect(action.service, autoOnboardingService);
      expect(action.command, 'http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingSettings');
    });

    test('SetBluetoothAutoOnboardingSettings has correct properties', () {
      final action = SetBluetoothAutoOnboardingSettings.instance;
      expect(action.name, 'SetBluetoothAutoOnboardingSettings');
      expect(action.service, autoOnboardingService);
      expect(action.command, 'http://linksys.com/jnap/nodes/autoonboarding/SetBluetoothAutoOnboardingSettings');
    });

    test('GetBluetoothAutoOnboardingStatus has correct properties', () {
      final action = GetBluetoothAutoOnboardingStatus.instance;
      expect(action.name, 'GetBluetoothAutoOnboardingStatus');
      expect(action.service, autoOnboardingService);
      autoOnboardingService.updateVersion(1);
      expect(action.command, 'http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingStatus');
      autoOnboardingService.updateVersion(2);
      expect(action.command, 'http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingStatus2');
    });

    test('StartBluetoothAutoOnboarding has correct properties', () {
      final action = StartBluetoothAutoOnboarding.instance;
      expect(action.name, 'StartBluetoothAutoOnboarding');
      expect(action.service, autoOnboardingService);
      autoOnboardingService.updateVersion(1);
      expect(action.command, 'http://linksys.com/jnap/nodes/autoonboarding/StartBluetoothAutoOnboarding');
      autoOnboardingService.updateVersion(3);
      expect(action.command, 'http://linksys.com/jnap/nodes/autoonboarding/StartBluetoothAutoOnboarding2');
    });

    test('AutoOnboardingAction.all contains all actions', () {
      final actions = AutoOnboardingAction.all;
      expect(actions, contains(isA<GetBluetoothAutoOnboardingSettings>()));
      expect(actions, contains(isA<SetBluetoothAutoOnboardingSettings>()));
      expect(actions, contains(isA<GetBluetoothAutoOnboardingStatus>()));
      expect(actions, contains(isA<StartBluetoothAutoOnboarding>()));
      expect(actions.length, 4);
    });
  });
}
