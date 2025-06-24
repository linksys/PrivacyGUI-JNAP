import 'package:jnap/src/modules/mlo/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/wirelessap/GetMLOSettings
/// http://linksys.com/jnap/wirelessap/SetMLOSettings
class MLOAction extends JNAPAction {
  MLOAction({required super.name, required super.varients})
      : super(service: mloService);
  static List<MLOAction> get all => [
        GetMLOSettings.instance,
        SetMLOSettings.instance,
  ];
}

/// http://linksys.com/jnap/wirelessap/GetMLOSettings
class GetMLOSettings extends MLOAction {
  static final GetMLOSettings instance = GetMLOSettings._();
  GetMLOSettings._()
      : super(name: 'GetMLOSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/wirelessap/SetMLOSettings
class SetMLOSettings extends MLOAction {
  static final SetMLOSettings instance = SetMLOSettings._();
  SetMLOSettings._()
      : super(name: 'SetMLOSettings', varients: [VersionVarients(1, 1)]);
}
