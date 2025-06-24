import 'package:jnap/src/modules/firewall/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

///   http://linksys.com/jnap/firewall/GetPortRangeForwardingRules
///   http://linksys.com/jnap/firewall/GetPortRangeTriggeringRules
///   http://linksys.com/jnap/firewall/GetSinglePortForwardingRules
///   http://linksys.com/jnap/firewall/SetPortRangeForwardingRules
///   http://linksys.com/jnap/firewall/SetPortRangeTriggeringRules
///   http://linksys.com/jnap/firewall/SetSinglePortForwardingRules
///   http://linksys.com/jnap/firewall/GetIPv6FirewallRules
///   http://linksys.com/jnap/firewall/SetIPv6FirewallRules
///   http://linksys.com/jnap/firewall/GetFirewallSettings
///   http://linksys.com/jnap/firewall/SetFirewallSettings
///   http://linksys.com/jnap/firewall/GetDMZSettings
///   http://linksys.com/jnap/firewall/SetDMZSettings
///   http://linksys.com/jnap/firewall/GetALGSettings
///   http://linksys.com/jnap/firewall/SetALGSettings

sealed class FirewallAction extends JNAPAction {
  FirewallAction({
    required super.name,
    required super.varients,
  }) : super(service: firewallService);

  static List<FirewallAction> get all => [
        GetPortRangeForwardingRules.instance,
        GetPortRangeTriggeringRules.instance,
        GetSinglePortForwardingRules.instance,
        SetPortRangeForwardingRules.instance,
        SetPortRangeTriggeringRules.instance,
        SetSinglePortForwardingRules.instance,
        GetIPv6FirewallRules.instance,
        SetIPv6FirewallRules.instance,
        GetFirewallSettings.instance,
        SetFirewallSettings.instance,
        GetDMZSettings.instance,
        SetDMZSettings.instance,
        GetALGSettings.instance,
        SetALGSettings.instance,
      ];
}

/// http://linksys.com/jnap/firewall/GetPortRangeForwardingRules
class GetPortRangeForwardingRules extends FirewallAction {
  static final GetPortRangeForwardingRules instance =
      GetPortRangeForwardingRules._();
  GetPortRangeForwardingRules._()
      : super(
            name: 'GetPortRangeForwardingRules',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/GetPortRangeTriggeringRules
class GetPortRangeTriggeringRules extends FirewallAction {
  static final GetPortRangeTriggeringRules instance =
      GetPortRangeTriggeringRules._();
  GetPortRangeTriggeringRules._()
      : super(
            name: 'GetPortRangeTriggeringRules',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/GetSinglePortForwardingRules
class GetSinglePortForwardingRules extends FirewallAction {
  static final GetSinglePortForwardingRules instance =
      GetSinglePortForwardingRules._();
  GetSinglePortForwardingRules._()
      : super(
            name: 'GetSinglePortForwardingRules',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetPortRangeForwardingRules
class SetPortRangeForwardingRules extends FirewallAction {
  static final SetPortRangeForwardingRules instance =
      SetPortRangeForwardingRules._();
  SetPortRangeForwardingRules._()
      : super(
            name: 'SetPortRangeForwardingRules',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetPortRangeTriggeringRules
class SetPortRangeTriggeringRules extends FirewallAction {
  static final SetPortRangeTriggeringRules instance =
      SetPortRangeTriggeringRules._();
  SetPortRangeTriggeringRules._()
      : super(
            name: 'SetPortRangeTriggeringRules',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetSinglePortForwardingRules
class SetSinglePortForwardingRules extends FirewallAction {
  static final SetSinglePortForwardingRules instance =
      SetSinglePortForwardingRules._();
  SetSinglePortForwardingRules._()
      : super(
            name: 'SetSinglePortForwardingRules',
            varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/GetIPv6FirewallRules
class GetIPv6FirewallRules extends FirewallAction {
  static final GetIPv6FirewallRules instance = GetIPv6FirewallRules._();
  GetIPv6FirewallRules._()
      : super(name: 'GetIPv6FirewallRules', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetIPv6FirewallRules
class SetIPv6FirewallRules extends FirewallAction {
  static final SetIPv6FirewallRules instance = SetIPv6FirewallRules._();
  SetIPv6FirewallRules._()
      : super(name: 'SetIPv6FirewallRules', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/GetFirewallSettings
class GetFirewallSettings extends FirewallAction {
  static final GetFirewallSettings instance = GetFirewallSettings._();
  GetFirewallSettings._()
      : super(name: 'GetFirewallSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetFirewallSettings
class SetFirewallSettings extends FirewallAction {
  static final SetFirewallSettings instance = SetFirewallSettings._();
  SetFirewallSettings._()
      : super(name: 'SetFirewallSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/GetDMZSettings
class GetDMZSettings extends FirewallAction {
  static final GetDMZSettings instance = GetDMZSettings._();
  GetDMZSettings._()
      : super(name: 'GetDMZSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetDMZSettings
class SetDMZSettings extends FirewallAction {
  static final SetDMZSettings instance = SetDMZSettings._();
  SetDMZSettings._()
      : super(name: 'SetDMZSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/GetALGSettings
class GetALGSettings extends FirewallAction {
  static final GetALGSettings instance = GetALGSettings._();
  GetALGSettings._()
      : super(name: 'GetALGSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/firewall/SetALGSettings
class SetALGSettings extends FirewallAction {
  static final SetALGSettings instance = SetALGSettings._();
  SetALGSettings._()
      : super(name: 'SetALGSettings', varients: [VersionVarients(1, 1)]);
}
