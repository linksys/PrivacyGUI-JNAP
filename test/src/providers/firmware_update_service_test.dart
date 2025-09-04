import 'dart:async';
import 'package:jnap/jnap.dart';
import 'package:jnap/src/providers/firmware_update_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJnap extends Mock implements Jnap {}

void main() {
  group('FirmwareUpdateService', () {
    late FirmwareUpdateService firmwareUpdateService;
    late MockJnap mockJnap;

    setUp(() {
      mockJnap = MockJnap();
      firmwareUpdateService = FirmwareUpdateService(mockJnap);
    });

    test('updateFirmwareUpdateSettings sends OK actions', () async {
      final data = {'some_key': 'some_value'};
      final jnapSuccess = JNAPSuccess(result: 'OK');

      when(() => mockJnap.send(
            action: SetFirmwareUpdateSettings.instance,
            data: data,
            overrides: JNAPConfigOverrides(cached: false),
          )).thenAnswer((_) async => jnapSuccess);

      when(() => mockJnap.send(
            action: GetFirmwareUpdateSettings.instance,
            overrides: JNAPConfigOverrides(forceRemote: true),
          )).thenAnswer((_) async => jnapSuccess);

      await firmwareUpdateService.updateFirmwareUpdateSettings(data);

      verify(() => mockJnap.send(
            action: SetFirmwareUpdateSettings.instance,
            data: data,
            overrides: JNAPConfigOverrides(cached: false),
          )).called(1);

      verify(() => mockJnap.send(
            action: GetFirmwareUpdateSettings.instance,
            overrides: JNAPConfigOverrides(forceRemote: true),
          )).called(1);
    });

    test('updateFirmwareUpdateSettings throws an exception', () async {
      final data = {'some_key': 'some_value'};
      final exception = Exception('some error');

      when(() => mockJnap.send(
            action: SetFirmwareUpdateSettings.instance,
            data: data,
            overrides: JNAPConfigOverrides(cached: false),
          )).thenThrow(exception);

      expect(
        () => firmwareUpdateService.updateFirmwareUpdateSettings(data),
        throwsA(
          predicate((p0) =>
              p0 is Exception && p0.toString() == 'Exception: some error'),
        ),
      );
    });

    test('checkAvailableFirmwareUpdates sends OK action', () async {
      final jnapSuccess = JNAPSuccess(result: 'OK');

      when(() => mockJnap.send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': true},
            overrides: JNAPConfigOverrides(
              retries: 0,
              cached: false,
              forceRemote: true,
            ),
          )).thenAnswer((_) async => jnapSuccess);

      await firmwareUpdateService.checkAvailableFirmwareUpdates();

      verify(() => mockJnap.send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': true},
            overrides: JNAPConfigOverrides(
              retries: 0,
              cached: false,
              forceRemote: true,
            ),
          )).called(1);
    });

    test('checkAvailableFirmwareUpdates throws an exception', () async {
      final exception = Exception('some error');

      when(() => mockJnap.send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': true},
            overrides: JNAPConfigOverrides(
              retries: 0,
              cached: false,
              forceRemote: true,
            ),
          )).thenThrow(exception);

      expect(
        () => firmwareUpdateService.checkAvailableFirmwareUpdates(),
        throwsA(predicate((p0) =>
            p0 is Exception && p0.toString() == 'Exception: some error')),
      );
    });

    test('scheduleCheckFirmwareUpdateStatus scheduled with OK action', () async {
      final stream = Stream.value(JNAPResult.fromMap({keyJnapResult: 'OK'}));

      when(() => mockJnap.scheduled(
            action: NodeGetFirmwareUpdateStatus.instance,
            maxRetry: -1,
            retryDelayInMilliSec: 2000,
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
            requestTimeoutOverride: 3000,
          )).thenAnswer((_) => stream);

      final result = firmwareUpdateService.scheduleCheckFirmwareUpdateStatus();

      await expectLater(
        result,
        emitsInOrder([
          isA<JNAPSuccess>(),
          emitsDone,
        ]),
      );

      verify(() => mockJnap.scheduled(
            action: NodeGetFirmwareUpdateStatus.instance,
            maxRetry: -1,
            retryDelayInMilliSec: 2000,
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
            requestTimeoutOverride: 3000,
          )).called(1);
    });

    test('scheduleCheckFirmwareUpdateStatus returns a stream with an error',
        () async {
      final streamController = StreamController<JNAPResult>();
      streamController.addError(Exception('some error'));

      when(() => mockJnap.scheduled(
            action: NodeGetFirmwareUpdateStatus.instance,
            maxRetry: -1,
            retryDelayInMilliSec: 2000,
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
            requestTimeoutOverride: 3000,
          )).thenAnswer((_) => streamController.stream);

      final result = firmwareUpdateService.scheduleCheckFirmwareUpdateStatus();

      await expectLater(result, emitsError(isA<Exception>()));
    });

    test('updateFirmwareNow sends OK action', () async {
      final jnapSuccess = JNAPSuccess(result: 'OK');

      when(() => mockJnap.send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': false},
            overrides: JNAPConfigOverrides(
              retries: 0,
              cached: false,
              forceRemote: true,
            ),
          )).thenAnswer((_) async => jnapSuccess);

      await firmwareUpdateService.updateFirmwareNow();

      verify(() => mockJnap.send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': false},
            overrides: JNAPConfigOverrides(
              retries: 0,
              cached: false,
              forceRemote: true,
            ),
          )).called(1);
    });

    test('updateFirmwareNow throws an exception', () async {
      final exception = Exception('some error');

      when(() => mockJnap.send(
            action: NodeUpdateFirmwareNow.instance,
            data: {'onlyCheck': false},
            overrides: JNAPConfigOverrides(
              retries: 0,
              cached: false,
              forceRemote: true,
            ),
          )).thenThrow(exception);

      expect(
        () => firmwareUpdateService.updateFirmwareNow(),
        throwsA(predicate((p0) =>
            p0 is Exception && p0.toString() == 'Exception: some error')),
      );
    });
  });
}
