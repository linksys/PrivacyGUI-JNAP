import 'package:jnap/src/modules/parental_control/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/parentalcontrol/GetParentalControlSettings
class ParentalControlAction extends JNAPAction {
  ParentalControlAction({
    required super.name,
    required super.varients,
  }) : super(service: parentalControlService);

  static List<ParentalControlAction> get all => [
        GetParentalControlSettings.instance,
      ];
}

class GetParentalControlSettings extends ParentalControlAction {
  static final GetParentalControlSettings instance =
      GetParentalControlSettings._();
  GetParentalControlSettings._()
      : super(
            name: 'GetParentalControlSettings',
            varients: [VersionVarients(1, 1)]);
}
