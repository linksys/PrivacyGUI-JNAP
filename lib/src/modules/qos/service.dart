import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/qos/QoS
/// http://linksys.com/jnap/qos/QoS2
/// http://linksys.com/jnap/qos/QoS3
final qosService = JNAPService(
  name: 'QoS',
  path: 'qos/',
);
