import 'dart:async';

import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/internet_connection/internet_connection_provider.dart';
import 'package:jnap/src/functions/internet_connection/internet_connection_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockInternetConnectionService extends Mock
    implements InternetConnectionService {}

void main() {
  group('InternetConnectionProvider', () {
    late ProviderContainer container;
    late MockInternetConnectionService mockService;

    setUp(() {
      mockService = MockInternetConnectionService();
      container = ProviderContainer(
        overrides: [
          internetConnectionServiceProvider.overrideWithValue(mockService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is not connected', () async {
      final state = container.read(internetConnectionProvider);
      expect(state.isInternetConnected, isFalse);
    });

    test('check() updates state to connected on InternetConnected', () async {
      final stream = Stream.value(JNAPSuccess(result: 'OK', output: {
        'connectionStatus': 'InternetConnected',
      }));
      when(() => mockService.scheduleCheckInternetConnection(any(), any(), any()))
          .thenAnswer((_) => stream);

      final notifier = container.read(internetConnectionProvider.notifier);
      notifier.check();

      // Allow the stream event to be processed
      await Future<void>.delayed(const Duration(milliseconds: 1));

      final state = container.read(internetConnectionProvider);
      expect(state.isInternetConnected, isTrue);
    });

    test('check() updates state to false on not connected', () async {
      final stream = Stream.value(JNAPSuccess(result: 'OK', output: {
        'connectionStatus': 'NoInternet',
      }));
      when(() => mockService.scheduleCheckInternetConnection(any(), any(), any()))
          .thenAnswer((_) => stream);

      final notifier = container.read(internetConnectionProvider.notifier);
      notifier.check();
      await Future<void>.delayed(const Duration(milliseconds: 1));

      final state = container.read(internetConnectionProvider);
      expect(state.isInternetConnected, isFalse);
    });

    test('check() sets false on error', () async {
      final controller = StreamController<JNAPResult>();
      controller.addError(Exception('some error'));
      when(() => mockService.scheduleCheckInternetConnection(any(), any(), any()))
          .thenAnswer((_) => controller.stream);

      final notifier = container.read(internetConnectionProvider.notifier);
      notifier.check();
      await Future<void>.delayed(const Duration(milliseconds: 1));

      final state = container.read(internetConnectionProvider);
      expect(state.isInternetConnected, isFalse);
    });
  });
}

