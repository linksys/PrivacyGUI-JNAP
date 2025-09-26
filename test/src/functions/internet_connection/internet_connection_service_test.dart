import 'dart:async';

import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/internet_connection/internet_connection_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJnap extends Mock implements Jnap {}

void main() {
  group('InternetConnectionService', () {
    late InternetConnectionService service;
    late MockJnap mockJnap;

    setUp(() {
      mockJnap = MockJnap();
      service = InternetConnectionService(mockJnap);
    });

    test('scheduleCheckInternetConnection uses defaults and returns stream',
        () async {
      final stream = Stream.value(JNAPSuccess(result: 'OK', output: {
        'connectionStatus': 'InternetConnected',
      }));

      when(() => mockJnap.scheduled(
            action: GetInternetConnectionStatus.instance,
            retryDelayInMilliSec: 3000,
            maxRetry: 1,
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
          )).thenAnswer((_) => stream);

      final result = service.scheduleCheckInternetConnection(null, null, null);

      await expectLater(
        result,
        emitsInOrder([
          isA<JNAPSuccess>()
              .having((e) => e.output['connectionStatus'], 'status',
                  'InternetConnected'),
          emitsDone,
        ]),
      );

      verify(() => mockJnap.scheduled(
            action: GetInternetConnectionStatus.instance,
            retryDelayInMilliSec: 3000,
            maxRetry: 1,
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
          )).called(1);
    });

    test('scheduleCheckInternetConnection passes custom params + timeout',
        () async {
      final stream = Stream<JNAPResult>.empty();

      when(() => mockJnap.scheduled(
            action: GetInternetConnectionStatus.instance,
            retryDelayInMilliSec: 1000,
            maxRetry: 5,
            overrides: any(named: 'overrides'),
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
          )).thenAnswer((_) => stream);

      final result = service.scheduleCheckInternetConnection(5, 1000, 2500);

      await expectLater(result, emitsDone);

      verify(() => mockJnap.scheduled(
            action: GetInternetConnectionStatus.instance,
            retryDelayInMilliSec: 1000,
            maxRetry: 5,
            overrides: any(named: 'overrides'),
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
          )).called(1);
    });

    test('scheduleCheckInternetConnection propagates stream error', () async {
      final controller = StreamController<JNAPResult>();
      controller.addError(Exception('network error'));

      when(() => mockJnap.scheduled(
            action: GetInternetConnectionStatus.instance,
            retryDelayInMilliSec: 3000,
            maxRetry: 1,
            condition: any(named: 'condition'),
            onComplete: any(named: 'onComplete'),
          )).thenAnswer((_) => controller.stream);

      final result = service.scheduleCheckInternetConnection(null, null, null);

      await expectLater(result, emitsError(isA<Exception>()));
    });
  });
}

