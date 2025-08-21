
import 'package:jnap/src/modules/motion_sensing/action.dart';
import 'package:jnap/src/modules/motion_sensing/service.dart';
import 'package:test/test.dart';

void main() {
  group('MotionSensing actions', () {
    test('GetActiveMotionSensingBots has correct properties', () {
      final action = GetActiveMotionSensingBots.instance;
      expect(action.name, 'GetActiveMotionSensingBots');
      expect(action.service, motionSensingService);
      expect(action.command, 'http://linksys.com/jnap/motionsensing/GetActiveMotionSensingBots');
    });

    test('GetMotionSensingSettings has correct properties', () {
      final action = GetMotionSensingSettings.instance;
      expect(action.name, 'GetMotionSensingSettings');
      expect(action.service, motionSensingService);
      expect(action.command, 'http://linksys.com/jnap/motionsensing/GetMotionSensingSettings');
    });
  });
}
