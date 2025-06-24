import 'package:jnap/src/modules/owned_network/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/ownednetwork/GetOwnedNetworkID
/// http://linksys.com/jnap/ownednetwork/IsOwnedNetwork
/// http://linksys.com/jnap/ownednetwork/SetNetworkOwner
sealed class OwnedNetworkAction extends JNAPAction {
  OwnedNetworkAction({
    required super.name,
    required super.varients,
  }) : super(service: ownedNetworkService);

  static List<OwnedNetworkAction> get all => [
        GetOwnedNetworkID.instance,
        IsOwnedNetwork.instance,
        SetNetworkOwner.instance,
      ];
}

/// http://linksys.com/jnap/ownednetwork/GetOwnedNetworkID
class GetOwnedNetworkID extends OwnedNetworkAction {
  static final GetOwnedNetworkID instance = GetOwnedNetworkID._();
  GetOwnedNetworkID._()
      : super(name: 'GetOwnedNetworkID', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/ownednetwork/IsOwnedNetwork
class IsOwnedNetwork extends OwnedNetworkAction {
  static final IsOwnedNetwork instance = IsOwnedNetwork._();
  IsOwnedNetwork._()
      : super(name: 'IsOwnedNetwork', varients: [VersionVarients(1, 2)]);
}

/// http://linksys.com/jnap/ownednetwork/SetNetworkOwner
class SetNetworkOwner extends OwnedNetworkAction {
  static final SetNetworkOwner instance = SetNetworkOwner._();
  SetNetworkOwner._()
      : super(name: 'SetNetworkOwner', varients: [VersionVarients(1, 1)]);
}
