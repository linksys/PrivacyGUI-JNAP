import 'package:jnap/src/modules/motion_sensing/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/motionsensing/GetActiveMotionSensingBots
/// http://linksys.com/jnap/motionsensing/GetMotionSensingSettings
sealed class MotionSensingAction extends JNAPAction {
  MotionSensingAction({required super.name, required super.varients})
      : super(service: motionSensingService);
  static List<MotionSensingAction> get all => [
        GetActiveMotionSensingBots.instance,
        GetMotionSensingSettings.instance,
      ];
}

/// http://linksys.com/jnap/motionsensing/GetActiveMotionSensingBots
class GetActiveMotionSensingBots extends MotionSensingAction {
  static final GetActiveMotionSensingBots instance =
      GetActiveMotionSensingBots._();
  GetActiveMotionSensingBots._()
      : super(name: 'GetActiveMotionSensingBots', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/motionsensing/GetMotionSensingSettings
class GetMotionSensingSettings extends MotionSensingAction {
  static final GetMotionSensingSettings instance = GetMotionSensingSettings._();
  GetMotionSensingSettings._()
      : super(name: 'GetMotionSensingSettings', varients: [
          VersionVarients(1, 1),
        ]);
}
