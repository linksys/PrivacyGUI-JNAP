import 'package:jnap/src/modules/qos/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/qos/GetQoSSettings
/// http://linksys.com/jnap/qos/GetQoSSettings2
class QoSAction extends JNAPAction {
  QoSAction({
    required super.name,
    required super.varients,
  }) : super(service: qosService);

  static List<QoSAction> get all => [
        GetQoSSettings.instance,
      ];
}

class GetQoSSettings extends QoSAction {
  static final GetQoSSettings instance = GetQoSSettings._();
  GetQoSSettings._()
      : super(
            name: 'GetQoSSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 3)]);
}
