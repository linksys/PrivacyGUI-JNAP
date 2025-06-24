import 'package:jnap/src/modules/wireless_ap/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/wirelessap/GetRadioInfo
/// http://linksys.com/jnap/wirelessap/GetRadioInfo2
/// http://linksys.com/jnap/wirelessap/GetRadioInfo3
/// http://linksys.com/jnap/wirelessap/GetWPSServerSessionStatus
/// http://linksys.com/jnap/wirelessap/SetRadioSettings
/// http://linksys.com/jnap/wirelessap/ClientDeauth
/// http://linksys.com/jnap/wirelessap/SetRadioSettings2
/// http://linksys.com/jnap/wirelessap/SetRadioSettings3
sealed class WirelessAPAction extends JNAPAction {
  WirelessAPAction({required super.name, required super.varients})
      : super(service: wirelessAPService);
  static List<WirelessAPAction> get all => [
        GetRadioInfo.instance,
        GetWPSServerSessionStatus.instance,
        SetRadioSettings.instance,
        ClientDeauth.instance,
      ];
}

/// http://linksys.com/jnap/wirelessap/GetRadioInfo
/// http://linksys.com/jnap/wirelessap/GetRadioInfo2
/// http://linksys.com/jnap/wirelessap/GetRadioInfo3
class GetRadioInfo extends WirelessAPAction {
  GetRadioInfo._()
      : super(name: 'GetRadioInfo', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 3),
          VersionVarients(3, 4),
        ]);

  static final GetRadioInfo instance = GetRadioInfo._();
}

/// http://linksys.com/jnap/wirelessap/GetWPSServerSessionStatus
class GetWPSServerSessionStatus extends WirelessAPAction {
  GetWPSServerSessionStatus._()
      : super(
            name: 'GetWPSServerSessionStatus',
            varients: [VersionVarients(1, 1)]);

  static final GetWPSServerSessionStatus instance =
      GetWPSServerSessionStatus._();
}

/// http://linksys.com/jnap/wirelessap/ClientDeauth
class ClientDeauth extends WirelessAPAction {
  ClientDeauth._()
      : super(name: 'ClientDeauth', varients: [VersionVarients(1, 5)]);

  static final ClientDeauth instance = ClientDeauth._();
}

/// http://linksys.com/jnap/wirelessap/SetRadioSettings
/// http://linksys.com/jnap/wirelessap/SetRadioSettings2
/// http://linksys.com/jnap/wirelessap/SetRadioSettings3
class SetRadioSettings extends WirelessAPAction {
  SetRadioSettings._()
      : super(name: 'SetRadioSettings', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 3),
          VersionVarients(3, 4),
        ]);

  static final SetRadioSettings instance = SetRadioSettings._();
}
