import 'package:jnap/src/modules/network_connections/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/networkconnections/GetNetworkConnections
/// http://linksys.com/jnap/networkconnections/GetNetworkConnections2
class NetworkConnectionsAction extends JNAPAction {
  NetworkConnectionsAction({required super.name, required super.varients})
      : super(service: networkConnectionsService);
  static List<NetworkConnectionsAction> get all => [
        GetNetworkConnections.instance,
      ];
}

/// http://linksys.com/jnap/networkconnections/GetNetworkConnections
/// http://linksys.com/jnap/networkconnections/GetNetworkConnections2
class GetNetworkConnections extends NetworkConnectionsAction {
  static final GetNetworkConnections instance = GetNetworkConnections._();
  GetNetworkConnections._()
      : super(name: 'GetNetworkConnections', varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 2),
        ]);
}
