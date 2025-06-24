import 'package:jnap/src/modules/power_table/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/powertable/GetPowerTableSettings
/// http://linksys.com/jnap/powertable/SetPowerTableSettings
sealed class PowerTableAction extends JNAPAction {
  PowerTableAction({
    required super.name,
    required super.varients,
  }) : super(service: powerTableService);

  static List<PowerTableAction> get all => [
        GetPowerTableSettings.instance,
        SetPowerTableSettings.instance,
      ];
}

class GetPowerTableSettings extends PowerTableAction {
  static final GetPowerTableSettings instance = GetPowerTableSettings._();
  GetPowerTableSettings._()
      : super(name: 'GetPowerTableSettings', varients: [VersionVarients(1, 1)]);
}

class SetPowerTableSettings extends PowerTableAction {
  static final SetPowerTableSettings instance = SetPowerTableSettings._();
  SetPowerTableSettings._()
      : super(name: 'SetPowerTableSettings', varients: [VersionVarients(1, 1)]);
}
