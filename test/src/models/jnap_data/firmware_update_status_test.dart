import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/firmware_update_status.dart';

void main() {
  group('FirmwareUpdateData', () {
    const firmwareUpdateData = FirmwareUpdateData(
      firmwareVersion: '1.0.0',
      firmwareDate: '2023-01-01',
      description: 'Bug fixes and performance improvements',
    );

    final Map<String, dynamic> firmwareUpdateDataMap = {
      'firmwareVersion': '1.0.0',
      'firmwareDate': '2023-01-01',
      'description': 'Bug fixes and performance improvements',
    };

    test('toMap returns a valid map', () {
      expect(firmwareUpdateData.toMap(), firmwareUpdateDataMap);
    });

    test('fromMap creates a valid object', () {
      expect(FirmwareUpdateData.fromMap(firmwareUpdateDataMap), firmwareUpdateData);
    });

    test('toJson returns a valid JSON string', () {
      expect(firmwareUpdateData.toJson(), json.encode(firmwareUpdateDataMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(FirmwareUpdateData.fromJson(json.encode(firmwareUpdateDataMap)), firmwareUpdateData);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedData = firmwareUpdateData.copyWith(
        firmwareVersion: '1.0.1',
      );
      expect(updatedData.firmwareVersion, '1.0.1');
      expect(updatedData.firmwareDate, firmwareUpdateData.firmwareDate);
    });

    test('props are correct', () {
      final data1 = FirmwareUpdateData(firmwareVersion: '1', firmwareDate: 'd1');
      final data2 = FirmwareUpdateData(firmwareVersion: '1', firmwareDate: 'd1');
      final data3 = FirmwareUpdateData(firmwareVersion: '2', firmwareDate: 'd2');
      expect(data1, data2);
      expect(data1.props, data2.props);
      expect(data1 == data3, false);
      expect(data1.props == data3.props, false);
    });
  });

  group('FirmwareUpdateOperationStatus', () {
    const firmwareUpdateOperationStatus = FirmwareUpdateOperationStatus(
      operation: 'Downloading',
      progressPercent: 50,
    );

    final Map<String, dynamic> firmwareUpdateOperationStatusMap = {
      'operation': 'Downloading',
      'progressPercent': 50,
    };

    test('toMap returns a valid map', () {
      expect(firmwareUpdateOperationStatus.toMap(), firmwareUpdateOperationStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(FirmwareUpdateOperationStatus.fromMap(firmwareUpdateOperationStatusMap), firmwareUpdateOperationStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(firmwareUpdateOperationStatus.toJson(), json.encode(firmwareUpdateOperationStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(FirmwareUpdateOperationStatus.fromJson(json.encode(firmwareUpdateOperationStatusMap)), firmwareUpdateOperationStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = firmwareUpdateOperationStatus.copyWith(
        progressPercent: 75,
      );
      expect(updatedStatus.progressPercent, 75);
      expect(updatedStatus.operation, firmwareUpdateOperationStatus.operation);
    });

    test('props are correct', () {
      final status1 = FirmwareUpdateOperationStatus(operation: 'op1', progressPercent: 1);
      final status2 = FirmwareUpdateOperationStatus(operation: 'op1', progressPercent: 1);
      final status3 = FirmwareUpdateOperationStatus(operation: 'op2', progressPercent: 2);
      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });

  group('FirmwareUpdateStatus', () {
    const firmwareUpdateData = FirmwareUpdateData(
      firmwareVersion: '1.0.0',
      firmwareDate: '2023-01-01',
      description: 'Bug fixes',
    );

    const firmwareUpdateOperationStatus = FirmwareUpdateOperationStatus(
      operation: 'Downloading',
      progressPercent: 50,
    );

    const firmwareUpdateStatus = FirmwareUpdateStatus(
      lastSuccessfulCheckTime: '2023-01-01T10:00:00Z',
      availableUpdate: firmwareUpdateData,
      pendingOperation: firmwareUpdateOperationStatus,
      lastOperationFailure: 'Network Error',
    );

    final Map<String, dynamic> firmwareUpdateStatusMap = {
      'lastSuccessfulCheckTime': '2023-01-01T10:00:00Z',
      'availableUpdate': firmwareUpdateData.toMap(),
      'pendingOperation': firmwareUpdateOperationStatus.toMap(),
      'lastOperationFailure': 'Network Error',
    };

    test('toMap returns a valid map', () {
      expect(firmwareUpdateStatus.toMap(), firmwareUpdateStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(FirmwareUpdateStatus.fromMap(firmwareUpdateStatusMap), firmwareUpdateStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(firmwareUpdateStatus.toJson(), json.encode(firmwareUpdateStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(FirmwareUpdateStatus.fromJson(json.encode(firmwareUpdateStatusMap)), firmwareUpdateStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = firmwareUpdateStatus.copyWith(
        lastSuccessfulCheckTime: '2023-01-02T10:00:00Z',
        availableUpdate: () => null,
      );
      expect(updatedStatus.lastSuccessfulCheckTime, '2023-01-02T10:00:00Z');
      expect(updatedStatus.availableUpdate, null);
      expect(updatedStatus.pendingOperation, firmwareUpdateStatus.pendingOperation);
    });

    test('props are correct', () {
      final status1 = FirmwareUpdateStatus(
        lastSuccessfulCheckTime: 'time1',
        availableUpdate: firmwareUpdateData,
        pendingOperation: firmwareUpdateOperationStatus,
        lastOperationFailure: 'fail1',
      );
      final status2 = FirmwareUpdateStatus(
        lastSuccessfulCheckTime: 'time1',
        availableUpdate: firmwareUpdateData,
        pendingOperation: firmwareUpdateOperationStatus,
        lastOperationFailure: 'fail1',
      );
      final status3 = FirmwareUpdateStatus(
        lastSuccessfulCheckTime: 'time2',
        availableUpdate: null,
        pendingOperation: null,
        lastOperationFailure: 'fail2',
      );

      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });
}
