
import 'package:jnap/src/modules/network_connections/action.dart';
import 'package:jnap/src/modules/network_connections/service.dart';
import 'package:test/test.dart';

void main() {
  group('NetworkConnections actions', () {
    test('GetNetworkConnections has correct properties', () {
      final action = GetNetworkConnections.instance;
      expect(action.name, 'GetNetworkConnections');
      expect(action.service, networkConnectionsService);
      expect(action.command, 'http://linksys.com/jnap/networkconnections/GetNetworkConnections');
    });

    test('GetNetworkConnections handles versioning', () {
      final action = GetNetworkConnections.instance;
      networkConnectionsService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/networkconnections/GetNetworkConnections2');
    });
  });
}
