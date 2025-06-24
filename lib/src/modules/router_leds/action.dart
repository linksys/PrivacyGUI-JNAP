import 'package:jnap/src/modules/router_leds/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/routerleds/GetLedNightModeSetting
/// http://linksys.com/jnap/routerleds/SetLedNightModeSetting
/// http://linksys.com/jnap/routerleds/SetLedNightModeSetting2
class RouterLEDsAction extends JNAPAction {
  RouterLEDsAction({required super.name, required super.varients})
      : super(service: routerLEDsService);
  static List<RouterLEDsAction> all = [
    GetLedNightModeSetting.instance,
    SetLedNightModeSetting.instance,
  ];
}

/// http://linksys.com/jnap/routerleds/GetLedNightModeSetting
class GetLedNightModeSetting extends RouterLEDsAction {
  static final GetLedNightModeSetting instance = GetLedNightModeSetting._();
  GetLedNightModeSetting._()
      : super(
            name: 'GetLedNightModeSetting', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/routerleds/SetLedNightModeSetting
/// http://linksys.com/jnap/routerleds/SetLedNightModeSetting2
class SetLedNightModeSetting extends RouterLEDsAction {
  static final SetLedNightModeSetting instance = SetLedNightModeSetting._();
  SetLedNightModeSetting._()
      : super(
            name: 'SetLedNightModeSetting',
            varients: [VersionVarients(1, 1), VersionVarients(2, 4)]);
}
