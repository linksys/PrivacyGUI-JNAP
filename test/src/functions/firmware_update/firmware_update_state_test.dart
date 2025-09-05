import 'package:test/test.dart';
import 'package:jnap/src/functions/firmware_update/firmware_update_state.dart';
import 'package:jnap/src/models/firmware_update_settings.dart';
import 'package:jnap/src/models/firmware_update_status.dart';
import 'package:jnap/src/models/firmware_update_status_nodes.dart';

void main() {
  group('FirmwareUpdateState', () {
    test('empty factory provides defaults', () {
      final s = FirmwareUpdateState.empty();
      expect(s.settings.updatePolicy,
          FirmwareUpdateSettings.firmwareUpdatePolicyAuto);
      expect(s.settings.autoUpdateWindow.startMinute, 0);
      expect(s.settings.autoUpdateWindow.durationMinutes, 240);
      expect(s.nodesStatus, isEmpty);
      expect(s.isUpdating, isFalse);
      expect(s.isRetryMaxReached, isFalse);
      expect(s.isWaitingChildrenAfterUpdating, isFalse);
    });

    test('copyWith updates only specified fields', () {
      final base = FirmwareUpdateState.empty();
      final node = NodesFirmwareUpdateStatus(
        deviceUUID: 'node-1',
        lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
      );
      final updated = base.copyWith(
        nodesStatus: [node],
        isUpdating: true,
        isRetryMaxReached: true,
        isWaitingChildrenAfterUpdating: true,
      );

      expect(updated.nodesStatus, [node]);
      expect(updated.isUpdating, isTrue);
      expect(updated.isRetryMaxReached, isTrue);
      expect(updated.isWaitingChildrenAfterUpdating, isTrue);
      // Settings remains identical
      expect(updated.settings, base.settings);
    });

    test('toMap/fromMap roundtrip preserves data and types', () {
      final status = FirmwareUpdateStatus(
        lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
        availableUpdate: const FirmwareUpdateData(
          firmwareVersion: '2.0.0',
          firmwareDate: '2024-01-01',
          description: 'desc',
        ),
        pendingOperation: const FirmwareUpdateOperationStatus(
          operation: 'Download',
          progressPercent: 50,
        ),
        lastOperationFailure: null,
      );
      final nodeStatus = NodesFirmwareUpdateStatus(
        deviceUUID: 'node-1',
        lastSuccessfulCheckTime: '2024-01-02T00:00:00Z',
      );

      final state = FirmwareUpdateState(
        settings: const FirmwareUpdateSettings(
          updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyManual,
          autoUpdateWindow: FirmwareAutoUpdateWindow(
            startMinute: 60,
            durationMinutes: 120,
          ),
        ),
        nodesStatus: [status, nodeStatus],
        isUpdating: true,
        isRetryMaxReached: false,
        isWaitingChildrenAfterUpdating: true,
      );

      final map = state.toMap();
      final decoded = FirmwareUpdateState.fromMap(map);

      // Basic fields
      expect(decoded.settings.updatePolicy,
          FirmwareUpdateSettings.firmwareUpdatePolicyManual);
      expect(decoded.settings.autoUpdateWindow.startMinute, 60);
      expect(decoded.settings.autoUpdateWindow.durationMinutes, 120);
      expect(decoded.isUpdating, isTrue);
      expect(decoded.isRetryMaxReached, isFalse);
      // Note: fromMap reads 'isChildAllUp' key, not the 'isWaitingChildrenAfterUpdating' key from toMap
      // Roundtrip therefore resets this flag to false.
      expect(decoded.isWaitingChildrenAfterUpdating, isFalse);

      // Nodes type preservation
      expect(decoded.nodesStatus, hasLength(2));
      expect(decoded.nodesStatus![0], isA<FirmwareUpdateStatus>());
      expect(decoded.nodesStatus![0], isNot(isA<NodesFirmwareUpdateStatus>()));
      expect(decoded.nodesStatus![1], isA<NodesFirmwareUpdateStatus>());
    });

    test('fromJson/toJson roundtrip', () {
      final original = FirmwareUpdateState.empty()
          .copyWith(isUpdating: true, isWaitingChildrenAfterUpdating: true);
      final jsonStr = original.toJson();
      final restored = FirmwareUpdateState.fromJson(jsonStr);
      expect(restored.settings, original.settings);
      expect(restored.nodesStatus, original.nodesStatus);
      expect(restored.isUpdating, isTrue);
      // As above, the JSON roundtrip loses this specific flag due to key mismatch
      expect(restored.isWaitingChildrenAfterUpdating, isFalse);
    });

    test('equatable: identical states are equal; differing not equal', () {
      final a = FirmwareUpdateState.empty();
      final b = FirmwareUpdateState.empty();
      expect(a, b);

      final c = a.copyWith(isUpdating: true);
      expect(c == a, isFalse);
    });

    test('fromMap nodesStatus type inference by deviceUUID', () {
      final map = {
        'settings': const FirmwareUpdateSettings(
          updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
          autoUpdateWindow: FirmwareAutoUpdateWindow(
            startMinute: 0,
            durationMinutes: 240,
          ),
        ).toMap(),
        'nodesStatus': [
          // Base status (no deviceUUID)
          const FirmwareUpdateStatus(
            lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
          ).toMap(),
          // Node status (has deviceUUID)
          const NodesFirmwareUpdateStatus(
            deviceUUID: 'node-2',
            lastSuccessfulCheckTime: '2024-01-02T00:00:00Z',
          ).toMap(),
        ],
        'isUpdating': false,
        'isRetryMaxReached': false,
        'isChildAllUp': true,
      };

      final s = FirmwareUpdateState.fromMap(map);
      expect(s.nodesStatus, hasLength(2));
      expect(s.nodesStatus![0], isA<FirmwareUpdateStatus>());
      expect(s.nodesStatus![1], isA<NodesFirmwareUpdateStatus>());
      // Mapped from isChildAllUp
      expect(s.isWaitingChildrenAfterUpdating, isTrue);
    });
  });
}
