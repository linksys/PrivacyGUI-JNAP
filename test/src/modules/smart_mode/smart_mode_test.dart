
import 'package:jnap/src/modules/smart_mode/action.dart';
import 'package:jnap/src/modules/smart_mode/service.dart';
import 'package:test/test.dart';

void main() {
  group('SmartMode actions', () {
    test('GetDeviceMode has correct properties', () {
      final action = GetDeviceMode.instance;
      expect(action.name, 'GetDeviceMode');
      expect(action.service, smartModeService);
      expect(action.command, 'http://linksys.com/jnap/nodes/smartmode/GetDeviceMode');
    });

    test('GetSupportedDeviceModes has correct properties', () {
      final action = GetSupportedDeviceModes.instance;
      expect(action.name, 'GetSupportedDeviceModes');
      expect(action.service, smartModeService);
      expect(action.command, 'http://linksys.com/jnap/nodes/smartmode/GetSupportedDeviceModes');
    });

    test('SetDeviceMode has correct properties', () {
      final action = SetDeviceMode.instance;
      expect(action.name, 'SetDeviceMode');
      expect(action.service, smartModeService);
      expect(action.command, 'http://linksys.com/jnap/nodes/smartmode/SetDeviceMode');
    });
  });
}
