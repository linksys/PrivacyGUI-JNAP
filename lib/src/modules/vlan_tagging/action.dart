import 'package:jnap/src/modules/vlan_tagging/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/vlantagging/GetVLANTaggingSettings
/// http://linksys.com/jnap/vlantagging/GetVLANTaggingSettings2
/// http://linksys.com/jnap/vlantagging/SetVLANTaggingSettings
/// http://linksys.com/jnap/vlantagging/SetVLANTaggingSettings2
sealed class VlanTaggingAction extends JNAPAction {
  VlanTaggingAction({required super.name, required super.varients})
      : super(service: vlanTaggingService);

  static List<VlanTaggingAction> get all => [
        GetVLANTaggingSettings.instance,
        SetVLANTaggingSettings.instance,
      ];
}

/// http://linksys.com/jnap/vlantagging/GetVLANTaggingSettings
/// http://linksys.com/jnap/vlantagging/GetVLANTaggingSettings2
class GetVLANTaggingSettings extends VlanTaggingAction {
  static final GetVLANTaggingSettings instance = GetVLANTaggingSettings._();
  GetVLANTaggingSettings._()
      : super(
            name: 'GetVLANTaggingSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}

/// http://linksys.com/jnap/vlantagging/SetVLANTaggingSettings
/// http://linksys.com/jnap/vlantagging/SetVLANTaggingSettings2
class SetVLANTaggingSettings extends VlanTaggingAction {
  static final SetVLANTaggingSettings instance = SetVLANTaggingSettings._();
  SetVLANTaggingSettings._()
      : super(
            name: 'SetVLANTaggingSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}
