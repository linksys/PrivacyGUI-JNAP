
import 'package:jnap/src/modules/firmware_update/action.dart';
import 'package:jnap/src/modules/firmware_update/service.dart';
import 'package:test/test.dart';

void main() {
  group('FirmwareUpdate actions', () {
    test('GetFirmwareUpdateStatus has correct properties', () {
      final action = GetFirmwareUpdateStatus.instance;
      expect(action.name, 'GetFirmwareUpdateStatus');
      expect(action.service, firmwareUpdateService);
      expect(action.command, 'http://linksys.com/jnap/firmwareupdate/GetFirmwareUpdateStatus');
    });

    test('GetFirmwareUpdateSettings has correct properties', () {
      final action = GetFirmwareUpdateSettings.instance;
      expect(action.name, 'GetFirmwareUpdateSettings');
      expect(action.service, firmwareUpdateService);
      expect(action.command, 'http://linksys.com/jnap/firmwareupdate/GetFirmwareUpdateSettings');
    });

    test('SetFirmwareUpdateSettings has correct properties', () {
      final action = SetFirmwareUpdateSettings.instance;
      expect(action.name, 'SetFirmwareUpdateSettings');
      expect(action.service, firmwareUpdateService);
      expect(action.command, 'http://linksys.com/jnap/firmwareupdate/SetFirmwareUpdateSettings');
    });
  });
}
