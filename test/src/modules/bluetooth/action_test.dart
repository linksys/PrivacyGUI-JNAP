import 'package:test/test.dart';
import 'package:jnap/src/modules/bluetooth/action.dart';
import 'package:jnap/src/modules/bluetooth/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

void main() {
  group('BluetoothAction', () {
    test('BTGetScanUnconfiguredResult has correct properties', () {
      final action = BTGetScanUnconfiguredResult.instance;
      expect(action.name, 'BTGetScanUnconfiguredResult');
      expect(action.service, bluetoothService);
      bluetoothService.updateVersion(2);
      expect(action.command, 'http://linksys.com/jnap/nodes/bluetooth/BTGetScanUnconfiguredResult2');
    });

    test('BTRequestScanUnconfigured has correct properties', () {
      final action = BTRequestScanUnconfigured.instance;
      expect(action.name, 'BTRequestScanUnconfigured');
      expect(action.service, bluetoothService);
      bluetoothService.updateVersion(2);
      expect(action.command, 'http://linksys.com/jnap/nodes/bluetooth/BTRequestScanUnconfigured2');
    });

    test('BluetoothAction.all contains all actions', () {
      final actions = BluetoothAction.all;
      expect(actions, contains(isA<BTGetScanUnconfiguredResult>()));
      expect(actions, contains(isA<BTRequestScanUnconfigured>()));
      expect(actions.length, 2);
    });
  });
}
