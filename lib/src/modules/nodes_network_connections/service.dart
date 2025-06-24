import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/nodes/networkconnections/NodesNetworkConnections
/// http://linksys.com/jnap/nodes/networkconnections/NodesNetworkConnections2
final nodesNetworkConnectionsService = JNAPService(
  name: 'NodesNetworkConnections',
  path: 'nodes/networkconnections/',
);
