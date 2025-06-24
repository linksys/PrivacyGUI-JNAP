import 'package:jnap/src/modules/firmware_update/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

///   http://linksys.com/jnap/firmwareupdate/GetFirmwareUpdateStatus
///   http://linksys.com/jnap/firmwareupdate/GetFirmwareUpdateSettings
///   http://linksys.com/jnap/firmwareupdate/SetFirmwareUpdateSettings
sealed class FirmwareUpdateAction extends JNAPAction {
  FirmwareUpdateAction({
    required super.name,
    required super.varients,
  }) : super(service: firmwareUpdateService);

  static List<FirmwareUpdateAction> get all => [
        GetFirmwareUpdateStatus.instance,
        GetFirmwareUpdateSettings.instance,
        SetFirmwareUpdateSettings.instance,
      ];
}

/// http://linksys.com/jnap/firmwareupdate/GetFirmwareUpdateStatus
class GetFirmwareUpdateStatus extends FirmwareUpdateAction {
  static final GetFirmwareUpdateStatus instance = GetFirmwareUpdateStatus._();
  GetFirmwareUpdateStatus._()
      : super(
            name: 'GetFirmwareUpdateStatus', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firmwareupdate/GetFirmwareUpdateSettings
class GetFirmwareUpdateSettings extends FirmwareUpdateAction {
  static final GetFirmwareUpdateSettings instance =
      GetFirmwareUpdateSettings._();
  GetFirmwareUpdateSettings._()
      : super(
            name: 'GetFirmwareUpdateSettings',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firmwareupdate/SetFirmwareUpdateSettings
class SetFirmwareUpdateSettings extends FirmwareUpdateAction {
  static final SetFirmwareUpdateSettings instance =
      SetFirmwareUpdateSettings._();
  SetFirmwareUpdateSettings._()
      : super(
            name: 'SetFirmwareUpdateSettings',
            varients: [VersionVarients(1, 1)]);
}
