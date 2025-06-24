import 'package:jnap/src/modules/router/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/router/GetDHCPClientLeases
/// http://linksys.com/jnap/router/GetIPv6Settings
/// http://linksys.com/jnap/router/GetIPv6Settings2
/// http://linksys.com/jnap/router/GetLANSettings
/// http://linksys.com/jnap/router/GetMACAddressCloneSettings
/// http://linksys.com/jnap/router/GetWANSettings
/// http://linksys.com/jnap/router/GetWANSettings2
/// http://linksys.com/jnap/router/GetWANSettings3
/// http://linksys.com/jnap/router/GetWANSettings4
/// http://linksys.com/jnap/router/GetWANSettings5
/// http://linksys.com/jnap/router/GetWANStatus
/// http://linksys.com/jnap/router/GetWANStatus2
/// http://linksys.com/jnap/router/GetWANStatus3
/// http://linksys.com/jnap/router/GetRoutingSettings
/// http://linksys.com/jnap/router/SetIPv6Settings
/// http://linksys.com/jnap/router/SetIPv6Settings2
/// http://linksys.com/jnap/router/SetMACAddressCloneSettings
/// http://linksys.com/jnap/router/SetWANSettings
/// http://linksys.com/jnap/router/SetWANSettings2
/// http://linksys.com/jnap/router/SetWANSettings3
/// http://linksys.com/jnap/router/SetWANSettings4
/// http://linksys.com/jnap/router/SetWANSettings5
/// http://linksys.com/jnap/router/SetLANSettings
/// http://linksys.com/jnap/router/SetRoutingSettings
/// http://linksys.com/jnap/router/ReleaseDHCPWANLease
/// http://linksys.com/jnap/router/ReleaseDHCPIPv6WANLease
/// http://linksys.com/jnap/router/RenewDHCPWANLease
/// http://linksys.com/jnap/router/RenewDHCPIPv6WANLease
/// http://linksys.com/jnap/router/GetEthernetPortConnections
/// http://linksys.com/jnap/router/GetExpressForwardingSettings
/// http://linksys.com/jnap/router/SetExpressForwardingSettings
/// http://linksys.com/jnap/router/GetWANExternal
sealed class RouterAction extends JNAPAction {
  RouterAction({required super.name, required super.varients})
      : super(service: routerService);

  static List<RouterAction> get all => [
        GetDHCPClientLeases.instance,
        GetIPv6Settings.instance,
        GetWANSettings.instance,
        GetWANStatus.instance,
        GetRoutingSettings.instance,
        SetIPv6Settings.instance,
        SetWANSettings.instance,
        SetLANSettings.instance,
        SetRoutingSettings.instance,
        ReleaseDHCPWANLease.instance,
        ReleaseDHCPIPv6WANLease.instance,
        RenewDHCPWANLease.instance,
        RenewDHCPIPv6WANLease.instance,
        GetEthernetPortConnections.instance,
        GetExpressForwardingSettings.instance,
        SetExpressForwardingSettings.instance,
        GetWANExternal.instance,
      ];
}

/// http://linksys.com/jnap/router/GetDHCPClientLeases
class GetDHCPClientLeases extends RouterAction {
  static final GetDHCPClientLeases instance = GetDHCPClientLeases._();
  GetDHCPClientLeases._()
      : super(name: 'GetDHCPClientLeases', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/GetIPv6Settings
/// http://linksys.com/jnap/router/GetIPv6Settings2
class GetIPv6Settings extends RouterAction {
  static final GetIPv6Settings instance = GetIPv6Settings._();
  GetIPv6Settings._()
      : super(
            name: 'GetIPv6Settings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 5)]);
}

/// http://linksys.com/jnap/router/GetLANSettings
class GetLANSettings extends RouterAction {
  static final GetLANSettings instance = GetLANSettings._();
  GetLANSettings._()
      : super(name: 'GetLANSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/GetMACAddressCloneSettings
class GetMACAddressCloneSettings extends RouterAction {
  static final GetMACAddressCloneSettings instance =
      GetMACAddressCloneSettings._();
  GetMACAddressCloneSettings._()
      : super(
            name: 'GetMACAddressCloneSettings',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/GetWANSettings
/// http://linksys.com/jnap/router/GetWANSettings2
/// http://linksys.com/jnap/router/GetWANSettings3
/// http://linksys.com/jnap/router/GetWANSettings4
/// http://linksys.com/jnap/router/GetWANSettings5
class GetWANSettings extends RouterAction {
  static final GetWANSettings instance = GetWANSettings._();
  GetWANSettings._()
      : super(name: 'GetWANSettings', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 3),
          VersionVarients(3, 7),
          VersionVarients(4, 8),
          VersionVarients(5, 10),
        ]);
}

/// http://linksys.com/jnap/router/GetWANStatus
/// http://linksys.com/jnap/router/GetWANStatus2
/// http://linksys.com/jnap/router/GetWANStatus3
class GetWANStatus extends RouterAction {
  static final GetWANStatus instance = GetWANStatus._();
  GetWANStatus._()
      : super(name: 'GetWANStatus', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 3),
          VersionVarients(3, 5),
        ]);
}

/// http://linksys.com/jnap/router/GetRoutingSettings

class GetRoutingSettings extends RouterAction {
  static final GetRoutingSettings instance = GetRoutingSettings._();
  GetRoutingSettings._()
      : super(name: 'GetRoutingSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/SetIPv6Settings
/// http://linksys.com/jnap/router/SetIPv6Settings2
class SetIPv6Settings extends RouterAction {
  static final SetIPv6Settings instance = SetIPv6Settings._();
  SetIPv6Settings._()
      : super(
            name: 'SetIPv6Settings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 5)]);
}

/// http://linksys.com/jnap/router/SetMACAddressCloneSettings
class SetMACAddressCloneSettings extends RouterAction {
  static final SetMACAddressCloneSettings instance =
      SetMACAddressCloneSettings._();
  SetMACAddressCloneSettings._()
      : super(
            name: 'SetMACAddressCloneSettings',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/SetWANSettings
/// http://linksys.com/jnap/router/SetWANSettings2
/// http://linksys.com/jnap/router/SetWANSettings3
/// http://linksys.com/jnap/router/SetWANSettings4
/// http://linksys.com/jnap/router/SetWANSettings5
class SetWANSettings extends RouterAction {
  static final SetWANSettings instance = SetWANSettings._();
  SetWANSettings._()
      : super(name: 'SetWANSettings', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 3),
          VersionVarients(3, 7),
          VersionVarients(4, 8),
          VersionVarients(5, 14),
        ]);
}

/// http://linksys.com/jnap/router/SetLANSettings
class SetLANSettings extends RouterAction {
  static final SetLANSettings instance = SetLANSettings._();
  SetLANSettings._()
      : super(name: 'SetLANSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/SetRoutingSettings
class SetRoutingSettings extends RouterAction {
  static final SetRoutingSettings instance = SetRoutingSettings._();
  SetRoutingSettings._()
      : super(name: 'SetRoutingSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/ReleaseDHCPWANLease
class ReleaseDHCPWANLease extends RouterAction {
  static final ReleaseDHCPWANLease instance = ReleaseDHCPWANLease._();
  ReleaseDHCPWANLease._()
      : super(name: 'ReleaseDHCPWANLease', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/ReleaseDHCPIPv6WANLease
class ReleaseDHCPIPv6WANLease extends RouterAction {
  static final ReleaseDHCPIPv6WANLease instance = ReleaseDHCPIPv6WANLease._();
  ReleaseDHCPIPv6WANLease._()
      : super(
            name: 'ReleaseDHCPIPv6WANLease', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/RenewDHCPWANLease
class RenewDHCPWANLease extends RouterAction {
  static final RenewDHCPWANLease instance = RenewDHCPWANLease._();
  RenewDHCPWANLease._()
      : super(name: 'RenewDHCPWANLease', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/RenewDHCPIPv6WANLease
class RenewDHCPIPv6WANLease extends RouterAction {
  static final RenewDHCPIPv6WANLease instance = RenewDHCPIPv6WANLease._();
  RenewDHCPIPv6WANLease._()
      : super(name: 'RenewDHCPIPv6WANLease', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/GetEthernetPortConnections
class GetEthernetPortConnections extends RouterAction {
  static final GetEthernetPortConnections instance =
      GetEthernetPortConnections._();
  GetEthernetPortConnections._()
      : super(
            name: 'GetEthernetPortConnections',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/router/GetExpressForwardingSettings
class GetExpressForwardingSettings extends RouterAction {
  static final GetExpressForwardingSettings instance =
      GetExpressForwardingSettings._();
  GetExpressForwardingSettings._()
      : super(
            name: 'GetExpressForwardingSettings',
            varients: [VersionVarients(1, 6)]);
}

/// http://linksys.com/jnap/router/SetExpressForwardingSettings
class SetExpressForwardingSettings extends RouterAction {
  static final SetExpressForwardingSettings instance =
      SetExpressForwardingSettings._();
  SetExpressForwardingSettings._()
      : super(
            name: 'SetExpressForwardingSettings',
            varients: [VersionVarients(1, 6)]);
}

/// http://linksys.com/jnap/router/GetWANExternal
class GetWANExternal extends RouterAction {
  static final GetWANExternal instance = GetWANExternal._();
  GetWANExternal._()
      : super(name: 'GetWANExternal', varients: [VersionVarients(1, 13)]);
}
