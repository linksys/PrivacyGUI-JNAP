
import 'package:jnap/src/modules/device_list/action.dart';
import 'package:jnap/src/modules/device_list/service.dart';
import 'package:test/test.dart';

void main() {
  group('DeviceList actions', () {
    test('GetDevices has correct properties', () {
      final action = GetDevices.instance;
      expect(action.name, 'GetDevices');
      expect(action.service, deviceListService);
      expect(action.command, 'http://linksys.com/jnap/devicelist/GetDevices');
    });

    test('GetLocalDevice has correct properties', () {
      final action = GetLocalDevice.instance;
      expect(action.name, 'GetLocalDevice');
      expect(action.service, deviceListService);
      expect(action.command, 'http://linksys.com/jnap/devicelist/GetLocalDevice');
    });

    test('SetDeviceProperties has correct properties', () {
      final action = SetDeviceProperties.instance;
      expect(action.name, 'SetDeviceProperties');
      expect(action.service, deviceListService);
      expect(action.command, 'http://linksys.com/jnap/devicelist/SetDeviceProperties');
    });

    test('DeleteDevice has correct properties', () {
      final action = DeleteDevice.instance;
      expect(action.name, 'DeleteDevice');
      expect(action.service, deviceListService);
      expect(action.command, 'http://linksys.com/jnap/devicelist/DeleteDevice');
    });

    test('GetDevices handles versioning', () {
      final action = GetDevices.instance;
      deviceListService.updateVersion(4);
      expect(action.latestVersion, '3');
      expect(action.command, 'http://linksys.com/jnap/devicelist/GetDevices3');
    });
  });
}
