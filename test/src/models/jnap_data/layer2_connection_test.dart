import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

void main() {
  group('Layer2Connection', () {
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

    const layer2Connection = Layer2Connection(
      macAddress: 'AA:BB:CC:DD:EE:FF',
      negotiatedMbps: 1000,
      wireless: wirelessConnection,
    );

    final Map<String, dynamic> layer2ConnectionMap = {
      'macAddress': 'AA:BB:CC:DD:EE:FF',
      'negotiatedMbps': 1000,
      'wireless': wirelessConnection.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(layer2Connection.toMap(), layer2ConnectionMap);
    });

    test('fromMap creates a valid object', () {
      expect(Layer2Connection.fromMap(layer2ConnectionMap), layer2Connection);
    });

    test('toJson returns a valid JSON string', () {
      expect(layer2Connection.toJson(), json.encode(layer2ConnectionMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(Layer2Connection.fromJson(json.encode(layer2ConnectionMap)), layer2Connection);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedConnection = layer2Connection.copyWith(
        negotiatedMbps: 500,
      );
      expect(updatedConnection.negotiatedMbps, 500);
      expect(updatedConnection.macAddress, layer2Connection.macAddress);
    });

    test('props are correct', () {
      final conn1 = Layer2Connection(macAddress: 'm1', negotiatedMbps: 1, wireless: wirelessConnection);
      final conn2 = Layer2Connection(macAddress: 'm1', negotiatedMbps: 1, wireless: wirelessConnection);
      final conn3 = Layer2Connection(macAddress: 'm2', negotiatedMbps: 2, wireless: null);
      expect(conn1, conn2);
      expect(conn1.props, conn2.props);
      expect(conn1 == conn3, false);
      expect(conn1.props == conn3.props, false);
    });
  });

  group('NodeWirelessLayer2Connections', () {
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

    final Map<String, dynamic> nodeWirelessLayer2ConnectionsMap = {
      'macAddress': 'AA:BB:CC:DD:EE:FF',
      'negotiatedMbps': 1000,
      'timestamp': '2023-01-01T12:00:00Z',
      'wireless': wirelessConnection.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(nodeWirelessLayer2Connections.toMap(), nodeWirelessLayer2ConnectionsMap);
    });

    test('fromMap creates a valid object', () {
      expect(NodeWirelessLayer2Connections.fromMap(nodeWirelessLayer2ConnectionsMap), nodeWirelessLayer2Connections);
    });

    test('toJson returns a valid JSON string', () {
      expect(nodeWirelessLayer2Connections.toJson(), json.encode(nodeWirelessLayer2ConnectionsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NodeWirelessLayer2Connections.fromJson(json.encode(nodeWirelessLayer2ConnectionsMap)), nodeWirelessLayer2Connections);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedConnection = nodeWirelessLayer2Connections.copyWith(
        negotiatedMbps: 500,
        timestamp: '2023-01-02T12:00:00Z',
      );
      expect(updatedConnection.negotiatedMbps, 500);
      expect(updatedConnection.timestamp, '2023-01-02T12:00:00Z');
      expect(updatedConnection.macAddress, nodeWirelessLayer2Connections.macAddress);
    });

    test('props are correct', () {
      final conn1 = NodeWirelessLayer2Connections(macAddress: 'm1', negotiatedMbps: 1, timestamp: 't1', wireless: wirelessConnection);
      final conn2 = NodeWirelessLayer2Connections(macAddress: 'm1', negotiatedMbps: 1, timestamp: 't1', wireless: wirelessConnection);
      final conn3 = NodeWirelessLayer2Connections(macAddress: 'm2', negotiatedMbps: 2, timestamp: 't2', wireless: null);
      expect(conn1, conn2);
      expect(conn1.props, conn2.props);
      expect(conn1 == conn3, false);
      expect(conn1.props == conn3.props, false);
    });
  });
}
