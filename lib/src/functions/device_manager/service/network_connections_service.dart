import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/base_service.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/node_wireless_connection.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:riverpod/riverpod.dart';

class NetworkConnectionsService extends BaseService {
  final Ref _ref;

  NetworkConnectionsService(this._ref)
      : super(_ref, [
          MapEntry(GetNetworkConnections.instance, {}),
          MapEntry(GetNodesWirelessNetworkConnections.instance, {}),
        ]);

  List<Layer2Connection> getNetworkConnectionsFromCache() {
    final cache = fetchCacheData();
    Map<String, dynamic>? getNetworkConnectionsData;
    Map<String, dynamic>? getNodesWirelessNetworkConnectionsData;
    if (cache != null) {
      getNetworkConnectionsData =
          (cache[GetNetworkConnections.instance])?.output;
      getNodesWirelessNetworkConnectionsData =
          (cache[GetNodesWirelessNetworkConnections.instance])?.output;
    }
    List<Layer2Connection> connectionData = [];
    if (getNodesWirelessNetworkConnectionsData != null) {
      final nodeWirelessConnections = List.from(
          getNodesWirelessNetworkConnectionsData['nodeWirelessConnections'] ??
              []);
      connectionData = nodeWirelessConnections.fold<List<Layer2Connection>>([],
          (previousValue, element) {
        final nodeWirelessConnection = NodeWirelessConnections.fromMap(element);

        previousValue.addAll(nodeWirelessConnection.connections);
        return previousValue;
      });
    } else {
      connectionData =
          List.from(getNetworkConnectionsData?['connections'] ?? [])
              .map((e) => Layer2Connection.fromMap(e))
              .toList();
    }
    return connectionData;
  }

  Map<String, WirelessConnection> getWirelessConnections(
    List<Layer2Connection>? data,
  ) {
    var connectionsMap = <String, WirelessConnection>{};
    if (data != null) {
      final connections = data;
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

  Map<String, WirelessConnection> updateWirelessConnectionsWithBackhaulInfo({
    required Map<String, WirelessConnection> wirelessConnections,
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
        _wirelessConnections[mac] = WirelessConnection(
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
