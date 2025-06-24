import 'package:jnap/src/modules/gaming_prioritization/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/gamingprioritization/GetGamingPrioritizationSettings
/// http://linksys.com/jnap/gamingprioritization/SetGamingPrioritizationSettings

sealed class GamingPrioritizationAction extends JNAPAction {
  GamingPrioritizationAction({
    required super.name,
    required super.varients,
  }) : super(service: gamingPrioritizationService);

  static List<GamingPrioritizationAction> get all => [
        GetGamingPrioritizationSettings.instance,
        SetGamingPrioritizationSettings.instance,
      ];
}

/// http://linksys.com/jnap/gamingprioritization/GetGamingPrioritizationSettings
class GetGamingPrioritizationSettings extends GamingPrioritizationAction {
  static final GetGamingPrioritizationSettings instance =
      GetGamingPrioritizationSettings._();
  GetGamingPrioritizationSettings._()
      : super(
            name: 'GetGamingPrioritizationSettings',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/gamingprioritization/SetGamingPrioritizationSettings
class SetGamingPrioritizationSettings extends GamingPrioritizationAction {
  static final SetGamingPrioritizationSettings instance =
      SetGamingPrioritizationSettings._();
  SetGamingPrioritizationSettings._()
      : super(
            name: 'SetGamingPrioritizationSettings',
            varients: [VersionVarients(1, 1)]);
}
