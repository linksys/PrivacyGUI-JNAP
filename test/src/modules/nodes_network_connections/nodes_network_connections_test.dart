
import 'package:jnap/src/modules/nodes_network_connections/action.dart';
import 'package:jnap/src/modules/nodes_network_connections/service.dart';
import 'package:test/test.dart';

void main() {
  group('NodesNetworkConnections actions', () {
    test('GetNodesWirelessNetworkConnections has correct properties', () {
      final action = GetNodesWirelessNetworkConnections.instance;
      expect(action.name, 'GetNodesWirelessNetworkConnections');
      expect(action.service, nodesNetworkConnectionsService);
      expect(action.command, 'http://linksys.com/jnap/nodes/networkconnections/GetNodesWirelessNetworkConnections');
    });

    test('GetNodesWirelessNetworkConnections handles versioning', () {
      final action = GetNodesWirelessNetworkConnections.instance;
      nodesNetworkConnectionsService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/nodes/networkconnections/GetNodesWirelessNetworkConnections2');
    });
  });
}
