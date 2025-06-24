import 'package:jnap/src/modules/dfs/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/wirelessap/GetDFSSettings
/// http://linksys.com/jnap/wirelessap/SetDFSSettings
class DFSSAction extends JNAPAction {
  DFSSAction({required super.name, required super.varients})
      : super(service: dfsService);
  static List<DFSSAction> get all => [
        GetDFSSettings.instance,
        SetDFSSettings.instance,
      ];
}

/// http://linksys.com/jnap/wirelessap/GetDFSSettings
class GetDFSSettings extends DFSSAction {
  static final GetDFSSettings instance = GetDFSSettings._();
  GetDFSSettings._()
      : super(name: 'GetDFSSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/wirelessap/SetDFSSettings
class SetDFSSettings extends DFSSAction {
  static final SetDFSSettings instance = SetDFSSettings._();
  SetDFSSettings._()
      : super(name: 'SetDFSSettings', varients: [VersionVarients(1, 1)]);
}
