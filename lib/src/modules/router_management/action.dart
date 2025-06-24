import 'package:jnap/src/modules/router_management/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/routermanagement/GetManagementSettings
/// http://linksys.com/jnap/routermanagement/GetManagementSettings2
/// http://linksys.com/jnap/routermanagement/SetManagementSettings
/// http://linksys.com/jnap/routermanagement/SetManagementSettings2
class RouterManagementAction extends JNAPAction {
  RouterManagementAction({required super.name, required super.varients})
      : super(service: routerManagementService);

  static List<RouterManagementAction> all = [
    GetManagementSettings.instance,
    SetManagementSettings.instance,
  ];
}

/// http://linksys.com/jnap/routermanagement/GetManagementSettings
/// http://linksys.com/jnap/routermanagement/GetManagementSettings2
class GetManagementSettings extends RouterManagementAction {
  static final GetManagementSettings instance = GetManagementSettings._();
  GetManagementSettings._()
      : super(
            name: 'GetManagementSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}

/// http://linksys.com/jnap/routermanagement/SetManagementSettings
/// http://linksys.com/jnap/routermanagement/SetManagementSettings2
class SetManagementSettings extends RouterManagementAction {
  static final SetManagementSettings instance = SetManagementSettings._();
  SetManagementSettings._()
      : super(
            name: 'SetManagementSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}
