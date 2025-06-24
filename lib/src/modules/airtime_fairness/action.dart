import 'package:jnap/src/modules/airtime_fairness/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// airtime fairness
///   http://linksys.com/jnap/wirelessap/GetAirtimeFairnessSettings
///   http://linksys.com/jnap/wirelessap/SetAirtimeFairnessSettings
///

sealed class AirtimeFairnessAction extends JNAPAction {
  AirtimeFairnessAction({
    required super.name,
    required super.varients,
  }) : super(service: airtimeFairnessService);

  static List<AirtimeFairnessAction> get all => [
        GetAirtimeFairnessSettings.instance,
        SetAirtimeFairnessSettings.instance,
      ];
}

///   http://linksys.com/jnap/wirelessap/GetAirtimeFairnessSettings
class GetAirtimeFairnessSettings extends AirtimeFairnessAction {
  GetAirtimeFairnessSettings()
      : super(
            name: 'GetAirtimeFairnessSettings',
            varients: [VersionVarients(1, 1)]);
  static final GetAirtimeFairnessSettings instance =
      GetAirtimeFairnessSettings();
}

///   http://linksys.com/jnap/wirelessap/SetAirtimeFairnessSettings
class SetAirtimeFairnessSettings extends AirtimeFairnessAction {
  SetAirtimeFairnessSettings()
      : super(
            name: 'SetAirtimeFairnessSettings',
            varients: [VersionVarients(1, 1)]);
  static final SetAirtimeFairnessSettings instance =
      SetAirtimeFairnessSettings();
}
