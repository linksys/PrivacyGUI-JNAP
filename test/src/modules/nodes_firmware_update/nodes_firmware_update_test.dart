
import 'package:jnap/src/modules/nodes_firmware_update/action.dart';
import 'package:jnap/src/modules/nodes_firmware_update/service.dart';
import 'package:test/test.dart';

void main() {
  group('NodesFirmwareUpdate actions', () {
    test('NodeGetFirmwareUpdateStatus has correct properties', () {
      final action = NodeGetFirmwareUpdateStatus.instance;
      expect(action.name, 'GetFirmwareUpdateStatus');
      expect(action.service, nodesFirmwareUpdateService);
      expect(action.command, 'http://linksys.com/jnap/nodes/firmwareupdate/GetFirmwareUpdateStatus');
    });

    test('NodeUpdateFirmwareNow has correct properties', () {
      final action = NodeUpdateFirmwareNow.instance;
      expect(action.name, 'UpdateFirmwareNow');
      expect(action.service, nodesFirmwareUpdateService);
      expect(action.command, 'http://linksys.com/jnap/nodes/firmwareupdate/UpdateFirmwareNow');
    });
  });
}
