import 'package:jnap/src/modules/iptv/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/iptv/GetIPTVSettings
/// http://linksys.com/jnap/iptv/SetIPTVSettings
sealed class IPTVAction extends JNAPAction {
  IPTVAction({required super.name, required super.varients})
      : super(service: iptvService);
  static List<IPTVAction> get all => [
        GetIPTVSettings.instance,
        SetIPTVSettings.instance,
      ];
}

/// http://linksys.com/jnap/iptv/GetIPTVSettings
class GetIPTVSettings extends IPTVAction {
  static final GetIPTVSettings instance = GetIPTVSettings._();
  GetIPTVSettings._()
      : super(name: 'GetIPTVSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/iptv/SetIPTVSettings
class SetIPTVSettings extends IPTVAction {
  static final SetIPTVSettings instance = SetIPTVSettings._();
  SetIPTVSettings._()
      : super(name: 'SetIPTVSettings', varients: [VersionVarients(1, 1)]);
}
