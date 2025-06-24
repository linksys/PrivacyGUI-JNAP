import 'package:jnap/src/modules/network_security/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/networksecurity/GetNetworkSecuritySettings
/// http://linksys.com/jnap/networksecurity/GetNetworkSecuritySettings2
/// http://linksys.com/jnap/networksecurity/SetNetworkSecuritySettings
/// http://linksys.com/jnap/networksecurity/SetNetworkSecuritySettings2
///
sealed class NetworkSecurityAction extends JNAPAction {
  NetworkSecurityAction({required super.name, required super.varients})
      : super(service: networkSecurityService);
  static List<NetworkSecurityAction> get all => [
        GetNetworkSecuritySettings.instance,
        SetNetworkSecuritySettings.instance,
      ];
}

/// http://linksys.com/jnap/networksecurity/GetNetworkSecuritySettings
/// http://linksys.com/jnap/networksecurity/GetNetworkSecuritySettings2
class GetNetworkSecuritySettings extends NetworkSecurityAction {
  static final GetNetworkSecuritySettings instance =
      GetNetworkSecuritySettings._();
  GetNetworkSecuritySettings._()
      : super(
            name: 'GetNetworkSecuritySettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 3)]);
}

/// http://linksys.com/jnap/networksecurity/SetNetworkSecuritySettings
/// http://linksys.com/jnap/networksecurity/SetNetworkSecuritySettings2
class SetNetworkSecuritySettings extends NetworkSecurityAction {
  static final SetNetworkSecuritySettings instance =
      SetNetworkSecuritySettings._();
  SetNetworkSecuritySettings._()
      : super(
            name: 'SetNetworkSecuritySettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 3)]);
}
