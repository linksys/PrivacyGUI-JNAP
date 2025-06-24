import 'package:jnap/src/modules/mac_filter/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/macfilter/GetMACFilterSettings
/// http://linksys.com/jnap/macfilter/SetMACFilterSettings
/// http://linksys.com/jnap/macfilter/GetSTABSSIDS
sealed class MACFilterAction extends JNAPAction {
  MACFilterAction({
    required super.name,
    required super.varients,
  }) : super(service: macFilterService);

  static List<MACFilterAction> get all => [
        GetMACFilterSettings.instance,
        SetMACFilterSettings.instance,
        GetSTABSSIDS.instance,
      ];
}

/// http://linksys.com/jnap/macfilter/GetMACFilterSettings
class GetMACFilterSettings extends MACFilterAction {
  static final GetMACFilterSettings instance = GetMACFilterSettings._();
  GetMACFilterSettings._()
      : super(name: 'GetMACFilterSettings', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/macfilter/SetMACFilterSettings
class SetMACFilterSettings extends MACFilterAction {
  static final SetMACFilterSettings instance = SetMACFilterSettings._();
  SetMACFilterSettings._()
      : super(name: 'SetMACFilterSettings', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/macfilter/GetSTABSSIDS
class GetSTABSSIDS extends MACFilterAction {
  static final GetSTABSSIDS instance = GetSTABSSIDS._();
  GetSTABSSIDS._()
      : super(name: 'GetSTABSSIDS', varients: [
          VersionVarients(1, 2),
        ]);
}
