import 'package:jnap/src/modules/jnap_action.dart';
import 'package:jnap/src/modules/smart_mode/service.dart';

/// http://linksys.com/jnap/nodes/smartmode/GetDeviceMode
/// http://linksys.com/jnap/nodes/smartmode/GetSupportedDeviceModes
/// http://linksys.com/jnap/nodes/smartmode/SetDeviceMode
sealed class SmartModeAction extends JNAPAction {
  SmartModeAction({required super.name, required super.varients})
      : super(service: smartModeService);
  static List<SmartModeAction> get all => [
        GetDeviceMode.instance,
        GetSupportedDeviceModes.instance,
        SetDeviceMode.instance,
      ];
}

/// http://linksys.com/jnap/nodes/smartmode/GetDeviceMode
class GetDeviceMode extends SmartModeAction {
  static final GetDeviceMode instance = GetDeviceMode._();
  GetDeviceMode._()
      : super(name: 'GetDeviceMode', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/smartmode/GetSupportedDeviceModes
class GetSupportedDeviceModes extends SmartModeAction {
  static final GetSupportedDeviceModes instance = GetSupportedDeviceModes._();
  GetSupportedDeviceModes._()
      : super(
            name: 'GetSupportedDeviceModes', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/smartmode/SetDeviceMode
class SetDeviceMode extends SmartModeAction {
  static final SetDeviceMode instance = SetDeviceMode._();
  SetDeviceMode._()
      : super(name: 'SetDeviceMode', varients: [VersionVarients(1, 1)]);
}
