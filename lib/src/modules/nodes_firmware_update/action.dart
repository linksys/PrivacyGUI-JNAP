import 'package:jnap/src/modules/nodes_firmware_update/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/nodes/firmwareupdate/GetFirmwareUpdateStatus
/// http://linksys.com/jnap/nodes/firmwareupdate/UpdateFirmwareNow
sealed class NodesFirmwareUpdateAction extends JNAPAction {
  NodesFirmwareUpdateAction({required super.name, required super.varients})
      : super(service: nodesFirmwareUpdateService);

  static List<NodesFirmwareUpdateAction> get all => [
        NodeGetFirmwareUpdateStatus.instance,
        NodeUpdateFirmwareNow.instance,
      ];
}

class NodeGetFirmwareUpdateStatus extends NodesFirmwareUpdateAction {
  static final NodeGetFirmwareUpdateStatus instance = NodeGetFirmwareUpdateStatus._();

  NodeGetFirmwareUpdateStatus._()
      : super(
            name: 'GetFirmwareUpdateStatus', varients: [VersionVarients(1, 1)]);
}

class NodeUpdateFirmwareNow extends NodesFirmwareUpdateAction {
  static final NodeUpdateFirmwareNow instance = NodeUpdateFirmwareNow._();

  NodeUpdateFirmwareNow._()
      : super(name: 'UpdateFirmwareNow', varients: [VersionVarients(1, 1)]);
}
