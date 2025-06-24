import 'package:jnap/src/modules/guest_network/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/guestnetwork/GetGuestNetworkClients
/// http://linksys.com/jnap/guestnetwork/GetGuestNetworkSettings
/// http://linksys.com/jnap/guestnetwork/SetGuestNetworkSettings
/// http://linksys.com/jnap/guestnetwork/SetGuestNetworkSettings3
/// http://linksys.com/jnap/guestnetwork/GetGuestRadioSettings
/// http://linksys.com/jnap/guestnetwork/GetGuestRadioSettings2
/// http://linksys.com/jnap/guestnetwork/SetGuestRadioSettings
/// http://linksys.com/jnap/guestnetwork/SetGuestRadioSettings2
///
sealed class GuestNetworkAction extends JNAPAction {
  GuestNetworkAction({
    required super.name,
    required super.varients,
  }) : super(service: guestNetworkService);

  static List<GuestNetworkAction> get all => [
        GetGuestNetworkClients.instance,
        GetGuestNetworkSettings.instance,
        SetGuestNetworkSettings.instance,
        GetGuestRadioSettings.instance,
        SetGuestRadioSettings.instance,
      ];
}

/// http://linksys.com/jnap/guestnetwork/GetGuestNetworkClients
class GetGuestNetworkClients extends GuestNetworkAction {
  static final GetGuestNetworkClients instance = GetGuestNetworkClients._();
  GetGuestNetworkClients._()
      : super(name: 'GetGuestNetworkClients', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/guestnetwork/GetGuestNetworkSettings
class GetGuestNetworkSettings extends GuestNetworkAction {
  static final GetGuestNetworkSettings instance = GetGuestNetworkSettings._();
  GetGuestNetworkSettings._()
      : super(
            name: 'GetGuestNetworkSettings', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/guestnetwork/SetGuestNetworkSettings
/// http://linksys.com/jnap/guestnetwork/SetGuestNetworkSettings3
class SetGuestNetworkSettings extends GuestNetworkAction {
  static final SetGuestNetworkSettings instance = SetGuestNetworkSettings._();
  SetGuestNetworkSettings._()
      : super(name: 'SetGuestNetworkSettings', varients: [
          VersionVarients(1, 1),
          VersionVarients(3, 2),
        ]);
}

/// http://linksys.com/jnap/guestnetwork/GetGuestRadioSettings
/// http://linksys.com/jnap/guestnetwork/GetGuestRadioSettings2
class GetGuestRadioSettings extends GuestNetworkAction {
  static final GetGuestRadioSettings instance = GetGuestRadioSettings._();
  GetGuestRadioSettings._()
      : super(name: 'GetGuestRadioSettings', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 4),
        ]);
}

/// http://linksys.com/jnap/guestnetwork/SetGuestRadioSettings
/// http://linksys.com/jnap/guestnetwork/SetGuestRadioSettings2
class SetGuestRadioSettings extends GuestNetworkAction {
  static final SetGuestRadioSettings instance = SetGuestRadioSettings._();
  SetGuestRadioSettings._()
      : super(name: 'SetGuestRadioSettings', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 4),
        ]);
}
