import 'dart:async';

import 'package:test/test.dart';
import 'package:jnap/src/models/firmware_update_status.dart';
import 'package:jnap/src/providers/firmware_update_provider.dart';
import 'package:jnap/src/providers/firmware_update_service.dart';
import 'package:jnap/src/providers/firmware_update_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/src/models/firmware_update_settings.dart';
import 'package:jnap/src/models/firmware_update_status_nodes.dart';

class MockFirmwareUpdateService extends Mock implements FirmwareUpdateService {}

class MockJnap extends Mock implements Jnap {}

// class MockJNAPSuccess extends Mock implements JNAPSuccess {}

void main() {
  group('FirmwareUpdateNotifier', () {
    late ProviderContainer container;
    late MockFirmwareUpdateService mockFirmwareUpdateService;

    setUp(() {
      mockFirmwareUpdateService = MockFirmwareUpdateService();

      container = ProviderContainer(
        overrides: [
          firmwareUpdateServiceProvider
              .overrideWithValue(mockFirmwareUpdateService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('setFirmwareUpdatePolicy updates state on success', () async {
      final notifier = container.read(firmwareUpdateProvider.notifier);

      // Initial state
      final initialSettings = FirmwareUpdateSettings(
        updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
        autoUpdateWindow: FirmwareAutoUpdateWindow.simple(),
      );
      notifier.state = FirmwareUpdateState(
        settings: initialSettings,
        nodesStatus: const [],
      );

      // Delay service completion to verify state updates after service resolves
      final completer = Completer<void>();
      when(() => mockFirmwareUpdateService.updateFirmwareUpdateSettings(any()))
          .thenAnswer((_) => completer.future);

      final future = notifier.setFirmwareUpdatePolicy(
        FirmwareUpdateSettings.firmwareUpdatePolicyManual,
      );

      // State should not update until service completes
      expect(
        notifier.state.settings.updatePolicy,
        FirmwareUpdateSettings.firmwareUpdatePolicyAuto,
      );

      // Complete the service call
      completer.complete();
      await future;

      // Verify service was called with expected payload
      final expectedMap = initialSettings
          .copyWith(updatePolicy: FirmwareUpdateSettings.firmwareUpdatePolicyManual)
          .toMap();
      final captured = verify(
        () => mockFirmwareUpdateService.updateFirmwareUpdateSettings(
          captureAny(),
        ),
      ).captured.single as Map<String, dynamic>;
      expect(captured, expectedMap);

      // Verify state updated and other fields unchanged
      expect(
        notifier.state.settings.updatePolicy,
        FirmwareUpdateSettings.firmwareUpdatePolicyManual,
      );
      expect(notifier.state.nodesStatus, isEmpty);
    });

    test('fetchNodeFirmwareStatus updates state on success', () async {
      final notifier = container.read(firmwareUpdateProvider.notifier);

      // Arrange mock responses
      when(() => mockFirmwareUpdateService.checkAvailableFirmwareUpdates())
          .thenAnswer((_) async => JNAPSuccess(result: 'OK'));

      final status1 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node-1',
        lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
      );
      final status2 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node-2',
        lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
      );

      final jnapSuccess1 = JNAPSuccess(result: 'OK', output: {
        'firmwareUpdateStatus': [status1.toMap()],
      });
      final jnapSuccess2 = JNAPSuccess(result: 'OK', output: {
        'firmwareUpdateStatus': [status1.toMap(), status2.toMap()],
      });

      when(() => mockFirmwareUpdateService.scheduleCheckFirmwareUpdateStatus(
            retryTimes: 2,
            onCompleted: any(named: 'onCompleted'),
          )).thenAnswer((_) => Stream.fromIterable([jnapSuccess1, jnapSuccess2]));

      // Act
      await notifier.fetchNodeFirmwareStatus();

      // Assert
      expect(notifier.state.nodesStatus, [status1, status2]);
      expect(notifier.state.isWaitingChildrenAfterUpdating, isFalse);
      verify(() => mockFirmwareUpdateService.checkAvailableFirmwareUpdates())
          .called(1);
      verify(() => mockFirmwareUpdateService.scheduleCheckFirmwareUpdateStatus(
            retryTimes: 2,
            onCompleted: any(named: 'onCompleted'),
          )).called(1);
    });

    test('fetchNodeFirmwareStatus respects cached candidates when inconsistent',
        () async {
      final notifier = container.read(firmwareUpdateProvider.notifier);

      // Cached candidates (e.g., saved at update start)
      final cached1 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node-1',
        lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
        availableUpdate: const FirmwareUpdateData(
          firmwareVersion: '2.0.0',
          firmwareDate: '2024-01-01',
        ),
      );
      final cached2 = NodesFirmwareUpdateStatus(
        deviceUUID: 'node-2',
        lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
        availableUpdate: const FirmwareUpdateData(
          firmwareVersion: '2.0.0',
          firmwareDate: '2024-01-01',
        ),
      );
      container
          .read(firmwareUpdateCandidateProvider.notifier)
          .state = [cached1, cached2];

      // Service emits only one node status (children not yet back online)
      when(() => mockFirmwareUpdateService.checkAvailableFirmwareUpdates())
          .thenAnswer((_) async => JNAPSuccess(result: 'OK'));
      final partial = JNAPSuccess(result: 'OK', output: {
        'firmwareUpdateStatus': [
          NodesFirmwareUpdateStatus(
            deviceUUID: 'node-1',
            lastSuccessfulCheckTime: '2024-01-01T00:00:00Z',
          ).toMap()
        ],
      });
      when(() => mockFirmwareUpdateService.scheduleCheckFirmwareUpdateStatus(
            retryTimes: 2,
            onCompleted: any(named: 'onCompleted'),
          )).thenAnswer((_) => Stream.value(partial));

      // Act
      await notifier.fetchNodeFirmwareStatus();

      // Assert: should keep cached list but clear availableUpdate
      final expected1 = cached1.copyWith(availableUpdate: () => null);
      final expected2 = cached2.copyWith(availableUpdate: () => null);
      expect(notifier.state.nodesStatus, [expected1, expected2]);
      expect(notifier.state.isWaitingChildrenAfterUpdating, isTrue);
    });
/*
    test('updateFirmware updates state and starts listening to status stream',
        () async {
      final notifier = container.read(firmwareUpdateProvider.notifier);
      final status = NodesFirmwareUpdateStatus(
          deviceUUID: '123', lastSuccessfulCheckTime: 0);
      final jnapSuccess = MockJNAPSuccess();
      when(() => jnapSuccess.output).thenReturn({
        'firmwareUpdateStatus': [status.toMap()]
      });
      when(() => mockFirmwareUpdateService.updateFirmwareNow())
          .thenAnswer((_) async => MockJNAPSuccess());
      when(() => mockFirmwareUpdateService.scheduleCheckFirmwareUpdateStatus(
            retryTimes: any(named: 'retryTimes'),
            stopCondition: any(named: 'stopCondition'),
            onCompleted: any(named: 'onCompleted'),
          )).thenAnswer((_) => Stream.value(jnapSuccess));

      await notifier.updateFirmware();

      expect(notifier.state.isUpdating, isTrue);
      verify(() => mockFirmwareUpdateService.updateFirmwareNow()).called(1);
      verify(() => mockFirmwareUpdateService.scheduleCheckFirmwareUpdateStatus(
            retryTimes: any(named: 'retryTimes'),
            stopCondition: any(named: 'stopCondition'),
            onCompleted: any(named: 'onCompleted'),
          )).called(1);
    });

    test('finishFirmwareUpdate updates state', () async {
      final notifier = container.read(firmwareUpdateProvider.notifier);
      final jnapSuccess = MockJNAPSuccess();
      when(() => jnapSuccess.output).thenReturn({'firmwareUpdateStatus': []});
      when(() => mockFirmwareUpdateService.checkAvailableFirmwareUpdates())
          .thenAnswer((_) async => MockJNAPSuccess());
      when(() => mockFirmwareUpdateService.scheduleCheckFirmwareUpdateStatus(
            retryTimes: 2,
            onCompleted: any(named: 'onCompleted'),
          )).thenAnswer((_) => Stream.value(jnapSuccess));

      notifier.state = notifier.state.copyWith(isUpdating: true);

      await notifier.finishFirmwareUpdate();

      expect(notifier.state.isUpdating, isFalse);
    });
    */
  });
}
