import 'package:jnap/src/modules/bluetooth/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/nodes/bluetooth/BTGetScanUnconfiguredResult2
/// http://linksys.com/jnap/nodes/bluetooth/BTRequestScanUnconfigured2
///
sealed class BluetoothAction extends JNAPAction {
  BluetoothAction({required super.name, required super.varients})
      : super(service: bluetoothService);

  static List<BluetoothAction> get all => [
        BTGetScanUnconfiguredResult.instance,
        BTRequestScanUnconfigured.instance,
      ];
}

/// http://linksys.com/jnap/nodes/bluetooth/BTGetScanUnconfiguredResult2
class BTGetScanUnconfiguredResult extends BluetoothAction {
  static final BTGetScanUnconfiguredResult instance =
      BTGetScanUnconfiguredResult();
  BTGetScanUnconfiguredResult()
      : super(name: 'BTGetScanUnconfiguredResult', varients: [
          VersionVarients(2, 2),
        ]);
}

/// http://linksys.com/jnap/nodes/bluetooth/BTRequestScanUnconfigured2
class BTRequestScanUnconfigured extends BluetoothAction {
  static final BTRequestScanUnconfigured instance = BTRequestScanUnconfigured();
  BTRequestScanUnconfigured()
      : super(name: 'BTRequestScanUnconfigured', varients: [
          VersionVarients(2, 2),
        ]);
}
