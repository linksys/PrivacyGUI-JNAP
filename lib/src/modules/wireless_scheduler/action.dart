import 'package:jnap/src/modules/jnap_action.dart';
import 'package:jnap/src/modules/wireless_scheduler/service.dart';

/// http://linksys.com/jnap/wirelessscheduler/GetWirelessSchedulerSettings
sealed class WirelessSchedulerAction extends JNAPAction {
  WirelessSchedulerAction({required super.name, required super.varients})
      : super(service: wirelessSchedulerService);
  static List<WirelessSchedulerAction> get all => [
        GetWirelessSchedulerSettings.instance,
      ];
}

class GetWirelessSchedulerSettings extends WirelessSchedulerAction {
  GetWirelessSchedulerSettings._()
      : super(
            name: 'GetWirelessSchedulerSettings',
            varients: [VersionVarients(1, 1)]);

  static final GetWirelessSchedulerSettings instance =
      GetWirelessSchedulerSettings._();
}
