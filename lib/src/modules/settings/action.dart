import 'package:jnap/src/modules/settings/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/ui/GetRemoteSetting
/// http://linksys.com/jnap/ui/SetRemoteSetting
class SettingsAction extends JNAPAction {
  SettingsAction({required super.name, required super.varients})
      : super(service: settingsService);

  static List<SettingsAction> all = [
    GetRemoteSetting.instance,
    SetRemoteSetting.instance,
  ];
}

/// http://linksys.com/jnap/ui/GetRemoteSetting
class GetRemoteSetting extends SettingsAction {
  static final GetRemoteSetting instance = GetRemoteSetting._();
  GetRemoteSetting._()
      : super(name: 'GetRemoteSetting', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/ui/SetRemoteSetting
class SetRemoteSetting extends SettingsAction {
  static final SetRemoteSetting instance = SetRemoteSetting._();
  SetRemoteSetting._()
      : super(name: 'SetRemoteSetting', varients: [VersionVarients(1, 1)]);
}
