import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/node_wireless_connection.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:riverpod/riverpod.dart';

class NetworkConnectionsService {
  final Ref _ref;

  NetworkConnectionsService(this._ref);

  Future<JNAPSuccess> getNetworkConnections() async {
    return await _ref
        .read(jnapProvider)
        .send(action: GetNetworkConnections.instance);
  }

  Future<JNAPSuccess> getNodesWirelessNetworkConnections() async {
    return await _ref
        .read(jnapProvider)
        .send(action: GetNodesWirelessNetworkConnections.instance);
  }

  Future<List<Layer2ConnectionData>> getNetworkConnectionsList() async {
    final getNetworkConnectionsData = (await getNetworkConnections()).output;
    final getNodesWirelessNetworkConnectionsData =
        (await getNodesWirelessNetworkConnections()).output;
    List<Layer2ConnectionData> connectionsList = [];
    if (getNodesWirelessNetworkConnectionsData.isNotEmpty) {
      final nodeWirelessConnections = List.from(
          getNodesWirelessNetworkConnectionsData['nodeWirelessConnections'] ??
              []);
      connectionsList = nodeWirelessConnections.fold<List<Layer2ConnectionData>>(
          [], (previousValue, element) {
        final nodeWirelessConnection = NodeWirelessConnectionsData.fromMap(element);

        previousValue.addAll(nodeWirelessConnection.connections);
        return previousValue;
      });
    } else {
      connectionsList = List.from(getNetworkConnectionsData['connections'] ?? [])
          .map((e) => Layer2ConnectionData.fromMap(e))
          .toList();
    }
    return connectionsList;
  }

  Map<String, WirelessConnectionData> getWirelessConnectionsMap(
      {List<Layer2ConnectionData>? connectionsList}) {
    var connectionsMap = <String, WirelessConnectionData>{};
    if (connectionsList != null) {
      final connections = connectionsList;
      for (final connectionData in connections) {
        final macAddress = connectionData.macAddress;
        final wirelessData = connectionData.wireless;
        if (wirelessData != null) {
          connectionsMap[macAddress] = wirelessData;
        }
      }
    }
    return connectionsMap;
  }

  Map<String, WirelessConnectionData> updateWirelessConnectionsWithBackhaulInfo({
    required Map<String, WirelessConnectionData> wirelessConnections,
    required List<BackHaulInfoData> backhaulInfoList,
  }) {
    final _wirelessConnections = wirelessConnections;
    backhaulInfoList
        .where((element) =>
            element.connectionType == 'Wireless' &&
            element.wirelessConnectionInfo != null)
        .forEach((element) {
      final mac = element.wirelessConnectionInfo?.stationBSSID;
      final rssi = element.wirelessConnectionInfo?.stationRSSI;
      final band = element.wirelessConnectionInfo?.radioID;
      final bssid = element.wirelessConnectionInfo?.apBSSID;
      if (mac != null && rssi != null) {
        _wirelessConnections[mac] = WirelessConnectionData(
          bssid: bssid ?? '',
          isGuest: false,
          radioID: 'RADIO_${band}z',
          band: '${band}z',
          signalDecibels: rssi,
        );
      }
    });
    return _wirelessConnections;
  }
}
