import 'package:jnap/src/modules/auto_onboarding/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// Auto Onboarding Actions
/// http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingSettings'),
/// http://linksys.com/jnap/nodes/autoonboarding/SetBluetoothAutoOnboardingSettings'),
/// http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingStatus'),
/// http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingStatus2'),
/// http://linksys.com/jnap/nodes/autoonboarding/StartBluetoothAutoOnboarding'),
/// http://linksys.com/jnap/nodes/autoonboarding/StartBluetoothAutoOnboarding2'),

sealed class AutoOnboardingAction extends JNAPAction {
  AutoOnboardingAction({
    required super.name,
    required super.varients,
  }) : super(service: autoOnboardingService);

  static List<AutoOnboardingAction> get all => [
        GetBluetoothAutoOnboardingSettings.instance,
        SetBluetoothAutoOnboardingSettings.instance,
        GetBluetoothAutoOnboardingStatus.instance,
        StartBluetoothAutoOnboarding.instance,
      ];
}

///   http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingSettings
class GetBluetoothAutoOnboardingSettings extends AutoOnboardingAction {
  GetBluetoothAutoOnboardingSettings()
      : super(name: 'GetBluetoothAutoOnboardingSettings', varients: [
          VersionVarients(1, 1),
        ]);
  static final GetBluetoothAutoOnboardingSettings instance =
      GetBluetoothAutoOnboardingSettings();
}

///   http://linksys.com/jnap/nodes/autoonboarding/SetBluetoothAutoOnboardingSettings
///
class SetBluetoothAutoOnboardingSettings extends AutoOnboardingAction {
  SetBluetoothAutoOnboardingSettings()
      : super(name: 'SetBluetoothAutoOnboardingSettings', varients: [
          VersionVarients(1, 1),
        ]);
  static final SetBluetoothAutoOnboardingSettings instance =
      SetBluetoothAutoOnboardingSettings();
}

///   http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingStatus
///   http://linksys.com/jnap/nodes/autoonboarding/GetBluetoothAutoOnboardingStatus2
///
class GetBluetoothAutoOnboardingStatus extends AutoOnboardingAction {
  GetBluetoothAutoOnboardingStatus()
      : super(name: 'GetBluetoothAutoOnboardingStatus', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 2),
        ]);
  static final GetBluetoothAutoOnboardingStatus instance =
      GetBluetoothAutoOnboardingStatus();
}

/// http://linksys.com/jnap/nodes/autoonboarding/StartBluetoothAutoOnboarding'),
/// http://linksys.com/jnap/nodes/autoonboarding/StartBluetoothAutoOnboarding2'),
class StartBluetoothAutoOnboarding extends AutoOnboardingAction {
  StartBluetoothAutoOnboarding()
      : super(name: 'StartBluetoothAutoOnboarding', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 3),
        ]);
  static final StartBluetoothAutoOnboarding instance =
      StartBluetoothAutoOnboarding();
}
