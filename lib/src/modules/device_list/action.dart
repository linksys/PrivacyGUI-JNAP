import 'package:jnap/src/modules/device_list/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/devicelist/GetDevices
/// http://linksys.com/jnap/devicelist/GetDevices3
/// http://linksys.com/jnap/devicelist/GetLocalDevice
/// http://linksys.com/jnap/devicelist/SetDeviceProperties
/// http://linksys.com/jnap/devicelist/DeleteDevice

sealed class DeviceListAction extends JNAPAction {
  DeviceListAction({
    required super.name,
    required super.varients,
  }) : super(service: deviceListService);

  static List<DeviceListAction> get all => [
        GetDevices.instance,
        GetLocalDevice.instance,
        SetDeviceProperties.instance,
        DeleteDevice.instance,
      ];
}

/// http://linksys.com/jnap/devicelist/GetDevices
/// http://linksys.com/jnap/devicelist/GetDevices3
class GetDevices extends DeviceListAction {
  static final GetDevices instance = GetDevices._();
  GetDevices._()
      : super(
          name: 'GetDevices',
          varients: [
            VersionVarients(1, 1),
            VersionVarients(3, 4),
          ],
        );
}

/// http://linksys.com/jnap/devicelist/GetLocalDevice
class GetLocalDevice extends DeviceListAction {
  static final GetLocalDevice instance = GetLocalDevice._();
  GetLocalDevice._()
      : super(
          name: 'GetLocalDevice',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/devicelist/SetDeviceProperties
class SetDeviceProperties extends DeviceListAction {
  static final SetDeviceProperties instance = SetDeviceProperties._();
  SetDeviceProperties._()
      : super(
          name: 'SetDeviceProperties',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/devicelist/DeleteDevice
class DeleteDevice extends DeviceListAction {
  static final DeleteDevice instance = DeleteDevice._();
  DeleteDevice._()
      : super(
          name: 'DeleteDevice',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}
