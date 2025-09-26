import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/ethernet_port_connections.dart';

void main() {
  group('RouterEthernetPortConnectionsData', () {
    const routerEthernetPortConnections = RouterEthernetPortConnectionsData(
      wanPortConnection: 'WAN_Port_1',
      lanPortConnections: ['LAN_Port_1', 'LAN_Port_2'],
    );

    final Map<String, dynamic> routerEthernetPortConnectionsMap = {
      'wanPortConnection': 'WAN_Port_1',
      'lanPortConnections': ['LAN_Port_1', 'LAN_Port_2'],
    };

    test('toMap returns a valid map', () {
      expect(routerEthernetPortConnections.toMap(), routerEthernetPortConnectionsMap);
    });

    test('fromMap creates a valid object', () {
      expect(RouterEthernetPortConnectionsData.fromMap(routerEthernetPortConnectionsMap), routerEthernetPortConnections);
    });

    test('toJson returns a valid JSON string', () {
      expect(routerEthernetPortConnections.toJson(), json.encode(routerEthernetPortConnectionsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RouterEthernetPortConnectionsData.fromJson(json.encode(routerEthernetPortConnectionsMap)), routerEthernetPortConnections);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedConnections = routerEthernetPortConnections.copyWith(
        wanPortConnection: 'WAN_Port_2',
        lanPortConnections: ['LAN_Port_3'],
      );
      expect(updatedConnections.wanPortConnection, 'WAN_Port_2');
      expect(updatedConnections.lanPortConnections, ['LAN_Port_3']);
    });

    test('props are correct', () {
      final connections1 = RouterEthernetPortConnectionsData(
        wanPortConnection: 'wan1',
        lanPortConnections: ['lan1', 'lan2'],
      );
      final connections2 = RouterEthernetPortConnectionsData(
        wanPortConnection: 'wan1',
        lanPortConnections: ['lan1', 'lan2'],
      );
      final connections3 = RouterEthernetPortConnectionsData(
        wanPortConnection: 'wan2',
        lanPortConnections: ['lan3'],
      );

      expect(connections1, connections2);
      expect(connections1.props, connections2.props);
      expect(connections1 == connections3, false);
      expect(connections1.props == connections3.props, false);
    });
  });
}