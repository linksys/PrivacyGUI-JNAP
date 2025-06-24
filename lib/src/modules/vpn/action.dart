import 'package:jnap/src/modules/vpn/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/vpn/GetVPNUser
/// http://linksys.com/jnap/vpn/SetVPNUser
/// http://linksys.com/jnap/vpn/GetVPNGateway
/// http://linksys.com/jnap/vpn/SetVPNGateway
/// http://linksys.com/jnap/vpn/GetVPNService
/// http://linksys.com/jnap/vpn/SetVPNService
/// http://linksys.com/jnap/vpn/TestVPNConnection
/// http://linksys.com/jnap/vpn/GetTunneledUser
/// http://linksys.com/jnap/vpn/SetTunneledUser
/// http://linksys.com/jnap/vpn/SetVPNApply
class VPNAction extends JNAPAction {
  VPNAction({required super.name, required super.varients})
      : super(service: vpnService);
  static List<VPNAction> get all => [
        TestVPNConnection.instance,
        GetTunneledUser.instance,
        SetTunneledUser.instance,
        SetVPNApply.instance,
        GetVPNUser.instance,
        SetVPNUser.instance,
        GetVPNGateway.instance,
        SetVPNGateway.instance,
        GetVPNService.instance,
        SetVPNService.instance,
      ];
}

/// http://linksys.com/jnap/vpn/TestVPNConnection
class TestVPNConnection extends VPNAction {
  TestVPNConnection._()
      : super(name: 'TestVPNConnection', varients: [VersionVarients(1, 1)]);

  static final TestVPNConnection instance = TestVPNConnection._();
}

/// http://linksys.com/jnap/vpn/GetTunneledUser
class GetTunneledUser extends VPNAction {
  GetTunneledUser._()
      : super(name: 'GetTunneledUser', varients: [VersionVarients(1, 1)]);

  static final GetTunneledUser instance = GetTunneledUser._();
}

/// http://linksys.com/jnap/vpn/SetTunneledUser
class SetTunneledUser extends VPNAction {
  SetTunneledUser._()
      : super(name: 'SetTunneledUser', varients: [VersionVarients(1, 1)]);

  static final SetTunneledUser instance = SetTunneledUser._();
}

/// http://linksys.com/jnap/vpn/SetVPNApply
class SetVPNApply extends VPNAction {
  SetVPNApply._()
      : super(name: 'SetVPNApply', varients: [VersionVarients(1, 1)]);

  static final SetVPNApply instance = SetVPNApply._();
}

/// http://linksys.com/jnap/vpn/GetVPNUser
class GetVPNUser extends VPNAction {
  GetVPNUser._() : super(name: 'GetVPNUser', varients: [VersionVarients(1, 1)]);

  static final GetVPNUser instance = GetVPNUser._();
}

/// http://linksys.com/jnap/vpn/SetVPNUser
class SetVPNUser extends VPNAction {
  SetVPNUser._() : super(name: 'SetVPNUser', varients: [VersionVarients(1, 1)]);

  static final SetVPNUser instance = SetVPNUser._();
}

/// http://linksys.com/jnap/vpn/GetVPNGateway
class GetVPNGateway extends VPNAction {
  GetVPNGateway._()
      : super(name: 'GetVPNGateway', varients: [VersionVarients(1, 1)]);

  static final GetVPNGateway instance = GetVPNGateway._();
}

/// http://linksys.com/jnap/vpn/SetVPNGateway
class SetVPNGateway extends VPNAction {
  SetVPNGateway._()
      : super(name: 'SetVPNGateway', varients: [VersionVarients(1, 1)]);

  static final SetVPNGateway instance = SetVPNGateway._();
}

/// http://linksys.com/jnap/vpn/GetVPNService
class GetVPNService extends VPNAction {
  GetVPNService._()
      : super(name: 'GetVPNService', varients: [VersionVarients(1, 1)]);

  static final GetVPNService instance = GetVPNService._();
}

/// http://linksys.com/jnap/vpn/SetVPNService
class SetVPNService extends VPNAction {
  SetVPNService._()
      : super(name: 'SetVPNService', varients: [VersionVarients(1, 1)]);

  static final SetVPNService instance = SetVPNService._();
}
