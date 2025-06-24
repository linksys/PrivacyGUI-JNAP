import 'package:jnap/src/modules/jnap_service.dart';

///   http://linksys.com/jnap/networkconnections/NetworkConnections
///   http://linksys.com/jnap/networkconnections/NetworkConnections2
///   http://linksys.com/jnap/networkconnections/NetworkConnections3
final networkConnectionsService = JNAPService(
  name: 'NetworkConnections',
  path: 'networkconnections/',
);
