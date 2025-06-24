import 'package:jnap/src/modules/ddns/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/ddns/GetDDNSSettings
/// http://linksys.com/jnap/ddns/GetDDNSStatus
/// http://linksys.com/jnap/ddns/GetDDNSStatus2
/// http://linksys.com/jnap/ddns/GetSupportedDDNSProviders
/// http://linksys.com/jnap/ddns/SetDDNSSettings

sealed class DDNSAction extends JNAPAction {
  DDNSAction({
    required super.name,
    required super.varients,
  }) : super(service: ddnsService);

  static List<DDNSAction> get all => [
        GetDDNSSettings.instance,
        GetDDNSStatus.instance,
        GetSupportedDDNSProviders.instance,
        SetDDNSSettings.instance,
      ];
}

/// http://linksys.com/jnap/ddns/GetDDNSSettings
class GetDDNSSettings extends DDNSAction {
  static final GetDDNSSettings instance = GetDDNSSettings._();
  GetDDNSSettings._()
      : super(
          name: 'GetDDNSSettings',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/ddns/GetDDNSStatus
/// http://linksys.com/jnap/ddns/GetDDNSStatus2
class GetDDNSStatus extends DDNSAction {
  static final GetDDNSStatus instance = GetDDNSStatus._();
  GetDDNSStatus._()
      : super(
          name: 'GetDDNSStatus',
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 3),
          ],
        );
}

/// http://linksys.com/jnap/ddns/GetSupportedDDNSProviders

class GetSupportedDDNSProviders extends DDNSAction {
  static final GetSupportedDDNSProviders instance =
      GetSupportedDDNSProviders._();
  GetSupportedDDNSProviders._()
      : super(
          name: 'GetSupportedDDNSProviders',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/ddns/SetDDNSSettings
class SetDDNSSettings extends DDNSAction {
  static final SetDDNSSettings instance = SetDDNSSettings._();
  SetDDNSSettings._()
      : super(
          name: 'SetDDNSSettings',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}
