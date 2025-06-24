import 'package:jnap/src/modules/setup/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/nodes/setup/GetSelectedChannels
/// http://linksys.com/jnap/nodes/setup/StartAutoChannelSelection
/// http://linksys.com/jnap/nodes/setup/GetAutoConfigurationSettings
/// http://linksys.com/jnap/nodes/setup/SetUserAcknowledgedAutoConfiguration
/// http://linksys.com/jnap/nodes/setup/GetWANDetectionStatus
/// http://linksys.com/jnap/nodes/setup/IsAdminPasswordSetByUser
/// http://linksys.com/jnap/nodes/setup/SetAdminPassword
/// http://linksys.com/jnap/nodes/setup/SetAdminPassword2
/// http://linksys.com/jnap/nodes/setup/VerifyRouterResetCode
/// http://linksys.com/jnap/nodes/setup/GetVersionInfo
/// http://linksys.com/jnap/nodes/setup/GetPortConnectionStatus
/// http://linksys.com/jnap/nodes/setup/GetWANPort
/// http://linksys.com/jnap/nodes/setup/SetWANPort
/// http://linksys.com/jnap/nodes/setup/GetInternetConnectionStatus
/// http://linksys.com/jnap/nodes/setup/GetSimpleWiFiSettings
/// http://linksys.com/jnap/nodes/setup/SetSimpleWiFiSettings
/// http://linksys.com/jnap/nodes/setup/GetMACAddress
/// http://linksys.com/jnap/nodes/setup/StartBlinkingNodeLed
/// http://linksys.com/jnap/nodes/setup/StopBlinkingNodeLed

sealed class SetupAction extends JNAPAction {
  SetupAction({required super.name, required super.varients})
      : super(service: setupService);

  static List<SetupAction> all = [
    GetSelectedChannels.instance,
    StartAutoChannelSelection.instance,
    GetAutoConfigurationSettings.instance,
    SetUserAcknowledgedAutoConfiguration.instance,
    GetWANDetectionStatus.instance,
    IsAdminPasswordSetByUser.instance,
    SetAdminPassword.instance,
    VerifyRouterResetCode.instance,
    GetVersionInfo.instance,
    GetPortConnectionStatus.instance,
    GetWANPort.instance,
    SetWANPort.instance,
    GetInternetConnectionStatus.instance,
    GetSimpleWiFiSettings.instance,
    SetSimpleWiFiSettings.instance,
    GetMACAddress.instance,
    StartBlinkingNodeLed.instance,
    StopBlinkingNodeLed.instance,
  ];
}

/// http://linksys.com/jnap/nodes/setup/GetSelectedChannels
class GetSelectedChannels extends SetupAction {
  static final GetSelectedChannels instance = GetSelectedChannels._();
  GetSelectedChannels._()
      : super(name: 'GetSelectedChannels', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/StartAutoChannelSelection
class StartAutoChannelSelection extends SetupAction {
  static final StartAutoChannelSelection instance =
      StartAutoChannelSelection._();
  StartAutoChannelSelection._()
      : super(
            name: 'StartAutoChannelSelection',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetAutoConfigurationSettings
class GetAutoConfigurationSettings extends SetupAction {
  static final GetAutoConfigurationSettings instance =
      GetAutoConfigurationSettings._();
  GetAutoConfigurationSettings._()
      : super(
            name: 'GetAutoConfigurationSettings',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/SetUserAcknowledgedAutoConfiguration
class SetUserAcknowledgedAutoConfiguration extends SetupAction {
  static final SetUserAcknowledgedAutoConfiguration instance =
      SetUserAcknowledgedAutoConfiguration._();
  SetUserAcknowledgedAutoConfiguration._()
      : super(
            name: 'SetUserAcknowledgedAutoConfiguration',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetWANDetectionStatus
class GetWANDetectionStatus extends SetupAction {
  static final GetWANDetectionStatus instance = GetWANDetectionStatus._();
  GetWANDetectionStatus._()
      : super(name: 'GetWANDetectionStatus', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/IsAdminPasswordSetByUser
class IsAdminPasswordSetByUser extends SetupAction {
  static final IsAdminPasswordSetByUser instance = IsAdminPasswordSetByUser._();
  IsAdminPasswordSetByUser._()
      : super(
            name: 'IsAdminPasswordSetByUser',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/SetAdminPassword
/// http://linksys.com/jnap/nodes/setup/SetAdminPassword2
class SetAdminPassword extends SetupAction {
  static final SetAdminPassword instance = SetAdminPassword._();
  SetAdminPassword._()
      : super(
            name: 'SetAdminPassword',
            varients: [VersionVarients(1, 1), VersionVarients(2, 8)]);
}

/// http://linksys.com/jnap/nodes/setup/VerifyRouterResetCode
class VerifyRouterResetCode extends SetupAction {
  static final VerifyRouterResetCode instance = VerifyRouterResetCode._();
  VerifyRouterResetCode._()
      : super(name: 'VerifyRouterResetCode', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetVersionInfo
class GetVersionInfo extends SetupAction {
  static final GetVersionInfo instance = GetVersionInfo._();
  GetVersionInfo._()
      : super(name: 'GetVersionInfo', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetPortConnectionStatus
class GetPortConnectionStatus extends SetupAction {
  static final GetPortConnectionStatus instance = GetPortConnectionStatus._();
  GetPortConnectionStatus._()
      : super(
            name: 'GetPortConnectionStatus', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetWANPort
class GetWANPort extends SetupAction {
  static final GetWANPort instance = GetWANPort._();
  GetWANPort._() : super(name: 'GetWANPort', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/SetWANPort
class SetWANPort extends SetupAction {
  static final SetWANPort instance = SetWANPort._();
  SetWANPort._() : super(name: 'SetWANPort', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetInternetConnectionStatus
class GetInternetConnectionStatus extends SetupAction {
  static final GetInternetConnectionStatus instance =
      GetInternetConnectionStatus._();
  GetInternetConnectionStatus._()
      : super(
            name: 'GetInternetConnectionStatus',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetSimpleWiFiSettings
class GetSimpleWiFiSettings extends SetupAction {
  static final GetSimpleWiFiSettings instance = GetSimpleWiFiSettings._();
  GetSimpleWiFiSettings._()
      : super(name: 'GetSimpleWiFiSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/SetSimpleWiFiSettings
class SetSimpleWiFiSettings extends SetupAction {
  static final SetSimpleWiFiSettings instance = SetSimpleWiFiSettings._();
  SetSimpleWiFiSettings._()
      : super(name: 'SetSimpleWiFiSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/GetMACAddress

class GetMACAddress extends SetupAction {
  static final GetMACAddress instance = GetMACAddress._();
  GetMACAddress._()
      : super(name: 'GetMACAddress', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/StartBlinkingNodeLed
class StartBlinkingNodeLed extends SetupAction {
  static final StartBlinkingNodeLed instance = StartBlinkingNodeLed._();
  StartBlinkingNodeLed._()
      : super(name: 'StartBlinkingNodeLed', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/setup/StopBlinkingNodeLed
class StopBlinkingNodeLed extends SetupAction {
  static final StopBlinkingNodeLed instance = StopBlinkingNodeLed._();
  StopBlinkingNodeLed._()
      : super(name: 'StopBlinkingNodeLed', varients: [VersionVarients(1, 1)]);
}
