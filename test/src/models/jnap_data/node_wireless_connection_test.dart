import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/node_wireless_connection.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

void main() {
  group('NodeWirelessConnections', () {
    const wirelessConnection = WirelessConnection(
      bssid: '00:11:22:33:44:55',
      isGuest: false,
      radioID: 'radio1',
      band: '2.4GHz',
      signalDecibels: -50,
      txRate: 100,
      rxRate: 200,
      isMLOCapable: true,
    );

    const nodeWirelessLayer2Connections = NodeWirelessLayer2Connections(
      macAddress: 'AA:BB:CC:DD:EE:FF',
      negotiatedMbps: 1000,
      timestamp: '2023-01-01T12:00:00Z',
      wireless: wirelessConnection,
    );

    const nodeWirelessConnections = NodeWirelessConnections(
      deviceID: 'device123',
      connections: [nodeWirelessLayer2Connections],
    );

    final Map<String, dynamic> nodeWirelessConnectionsMap = {
      'deviceID': 'device123',
      'connections': [nodeWirelessLayer2Connections.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(nodeWirelessConnections.toMap(), nodeWirelessConnectionsMap);
    });

    test('fromMap creates a valid object', () {
      expect(NodeWirelessConnections.fromMap(nodeWirelessConnectionsMap), nodeWirelessConnections);
    });

    test('toJson returns a valid JSON string', () {
      expect(nodeWirelessConnections.toJson(), json.encode(nodeWirelessConnectionsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NodeWirelessConnections.fromJson(json.encode(nodeWirelessConnectionsMap)), nodeWirelessConnections);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedConnections = nodeWirelessConnections.copyWith(
        deviceID: 'device456',
      );
      expect(updatedConnections.deviceID, 'device456');
      expect(updatedConnections.connections, nodeWirelessConnections.connections);
    });

    test('props are correct', () {
      final connections1 = NodeWirelessConnections(deviceID: 'd1', connections: [nodeWirelessLayer2Connections]);
      final connections2 = NodeWirelessConnections(deviceID: 'd1', connections: [nodeWirelessLayer2Connections]);
      final connections3 = NodeWirelessConnections(deviceID: 'd2', connections: []);
      expect(connections1, connections2);
      expect(connections1.props, connections2.props);
      expect(connections1 == connections3, false);
      expect(connections1.props == connections3.props, false);
    });
  });
}
