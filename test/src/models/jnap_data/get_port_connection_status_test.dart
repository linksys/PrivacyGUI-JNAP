import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/get_port_connection_status.dart';

void main() {
  group('PortConnectionStatus', () {
    const portConnectionStatus = PortConnectionStatus(
      portId: 1,
      connectionState: 'Connected',
    );

    final Map<String, dynamic> portConnectionStatusMap = {
      'portId': 1,
      'connectionState': 'Connected',
    };

    test('toMap returns a valid map', () {
      expect(portConnectionStatus.toMap(), portConnectionStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(PortConnectionStatus.fromMap(portConnectionStatusMap), portConnectionStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(portConnectionStatus.toJson(), json.encode(portConnectionStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PortConnectionStatus.fromJson(json.encode(portConnectionStatusMap)), portConnectionStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = portConnectionStatus.copyWith(
        connectionState: 'Disconnected',
      );
      expect(updatedStatus.connectionState, 'Disconnected');
      expect(updatedStatus.portId, portConnectionStatus.portId);
    });

    test('props are correct', () {
      final status1 = PortConnectionStatus(portId: 1, connectionState: 'state1');
      final status2 = PortConnectionStatus(portId: 1, connectionState: 'state1');
      final status3 = PortConnectionStatus(portId: 2, connectionState: 'state2');
      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });

  group('GetPortConnectionStatusData', () {
    const portConnectionStatus1 = PortConnectionStatus(
      portId: 1,
      connectionState: 'Connected',
    );
    const portConnectionStatus2 = PortConnectionStatus(
      portId: 2,
      connectionState: 'Disconnected',
    );

    const getPortConnectionStatus = GetPortConnectionStatusData(
      portConnectionStatus: [portConnectionStatus1, portConnectionStatus2],
    );

    final Map<String, dynamic> getPortConnectionStatusMap = {
      'portConnectionStatus': [portConnectionStatus1.toMap(), portConnectionStatus2.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(getPortConnectionStatus.toMap(), getPortConnectionStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(GetPortConnectionStatusData.fromMap(getPortConnectionStatusMap), getPortConnectionStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(getPortConnectionStatus.toJson(), json.encode(getPortConnectionStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GetPortConnectionStatusData.fromJson(json.encode(getPortConnectionStatusMap)), getPortConnectionStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = getPortConnectionStatus.copyWith(
        portConnectionStatus: [portConnectionStatus1],
      );
      expect(updatedStatus.portConnectionStatus.length, 1);
      expect(updatedStatus.portConnectionStatus.first, portConnectionStatus1);
    });

    test('props are correct', () {
      final status1 = GetPortConnectionStatusData(portConnectionStatus: [portConnectionStatus1]);
      final status2 = GetPortConnectionStatusData(portConnectionStatus: [portConnectionStatus1]);
      final status3 = GetPortConnectionStatusData(portConnectionStatus: [portConnectionStatus2]);

      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });
}