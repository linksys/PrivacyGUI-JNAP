import 'package:jnap/src/modules/router_upnp/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/routerupnp/GetUPnPSettings
/// http://linksys.com/jnap/routerupnp/SetUPnPSettings
sealed class RouterUPnPAction extends JNAPAction {
  RouterUPnPAction({required super.name, required super.varients})
      : super(service: routerUPnPService);

  static List<RouterUPnPAction> all = [
    GetUPnPSettings.instance,
    SetUPnPSettings.instance,
  ];
}

/// http://linksys.com/jnap/routerupnp/GetUPnPSettings
class GetUPnPSettings extends RouterUPnPAction {
  static final GetUPnPSettings instance = GetUPnPSettings._();
  GetUPnPSettings._()
      : super(name: 'GetUPnPSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/routerupnp/SetUPnPSettings
class SetUPnPSettings extends RouterUPnPAction {
  static final SetUPnPSettings instance = SetUPnPSettings._();
  SetUPnPSettings._()
      : super(name: 'SetUPnPSettings', varients: [VersionVarients(1, 1)]);
}
