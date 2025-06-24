import 'package:jnap/src/modules/nodes_network_connections/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/nodes/networkconnections/GetNodesWirelessNetworkConnections
/// http://linksys.com/jnap/nodes/networkconnections/GetNodesWirelessNetworkConnections2
sealed class NodesNetworkConnectionsAction extends JNAPAction {
  NodesNetworkConnectionsAction({required super.name, required super.varients})
      : super(service: nodesNetworkConnectionsService);

  static List<NodesNetworkConnectionsAction> get all => [
        GetNodesWirelessNetworkConnections.instance,
      ];
}

class GetNodesWirelessNetworkConnections extends NodesNetworkConnectionsAction {
  static final GetNodesWirelessNetworkConnections instance =
      GetNodesWirelessNetworkConnections._();

  GetNodesWirelessNetworkConnections._()
      : super(
            name: 'GetNodesWirelessNetworkConnections',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}
