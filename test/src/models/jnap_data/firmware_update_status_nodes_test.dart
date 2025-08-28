import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/firmware_update_status.dart';
import 'package:jnap/src/models/jnap_data/firmware_update_status_nodes.dart';

void main() {
  group('NodesFirmwareUpdateStatus', () {
    const firmwareUpdateData = FirmwareUpdateData(
      firmwareVersion: '1.0.0',
      firmwareDate: '2023-01-01',
      description: 'Bug fixes',
    );

    const firmwareUpdateOperationStatus = FirmwareUpdateOperationStatus(
      operation: 'Downloading',
      progressPercent: 50,
    );

    const nodesFirmwareUpdateStatus = NodesFirmwareUpdateStatus(
      deviceUUID: 'node123',
      lastSuccessfulCheckTime: '2023-01-01T10:00:00Z',
      availableUpdate: firmwareUpdateData,
      pendingOperation: firmwareUpdateOperationStatus,
      lastOperationFailure: 'Network Error',
    );

    final Map<String, dynamic> nodesFirmwareUpdateStatusMap = {
      'deviceUUID': 'node123',
      'lastSuccessfulCheckTime': '2023-01-01T10:00:00Z',
      'availableUpdate': firmwareUpdateData.toMap(),
      'pendingOperation': firmwareUpdateOperationStatus.toMap(),
      'lastOperationFailure': 'Network Error',
    };

    test('toMap returns a valid map', () {
      expect(nodesFirmwareUpdateStatus.toMap(), nodesFirmwareUpdateStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(NodesFirmwareUpdateStatus.fromMap(nodesFirmwareUpdateStatusMap), nodesFirmwareUpdateStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(nodesFirmwareUpdateStatus.toJson(), json.encode(nodesFirmwareUpdateStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NodesFirmwareUpdateStatus.fromJson(json.encode(nodesFirmwareUpdateStatusMap)), nodesFirmwareUpdateStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = nodesFirmwareUpdateStatus.copyWith(
        deviceUUID: 'node456',
        lastSuccessfulCheckTime: '2023-01-02T10:00:00Z',
      );
      expect(updatedStatus.deviceUUID, 'node456');
      expect(updatedStatus.lastSuccessfulCheckTime, '2023-01-02T10:00:00Z');
      expect(updatedStatus.availableUpdate, nodesFirmwareUpdateStatus.availableUpdate);
    });

    test('props are correct', () {
      final status1 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node1',
        lastSuccessfulCheckTime: 'time1',
      );
      final status2 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node1',
        lastSuccessfulCheckTime: 'time1',
      );
      final status3 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node2',
        lastSuccessfulCheckTime: 'time2',
      );

      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });
}
