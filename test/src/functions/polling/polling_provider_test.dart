import 'package:fake_async/fake_async.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/interfaces_impl.dart';
import 'package:jnap/src/functions/polling/polling_provider.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'polling_provider_test.mocks.dart';

@GenerateMocks(
    [Jnap, PollingConfig, PollingAdditionalTasks, PollingCompletedNotifier])
void main() {
  late MockJnap mockJnap;
  late MockPollingConfig mockPollingConfig;
  late MockPollingAdditionalTasks mockAdditionalTasks;
  late MockPollingCompletedNotifier mockCompletedNotifier;
  late ProviderContainer container;

  setUp(() {
    mockJnap = MockJnap();
    mockPollingConfig = MockPollingConfig();
    mockAdditionalTasks = MockPollingAdditionalTasks();
    mockCompletedNotifier = MockPollingCompletedNotifier();

    // Default mock behaviors
    when(mockPollingConfig.isPaused).thenReturn(false);
    when(mockPollingConfig.pollFirstDelayInSec).thenReturn(1);
    when(mockPollingConfig.refreshInterval)
        .thenReturn(const Duration(seconds: 60));
    when(mockAdditionalTasks.additionalPolling()).thenAnswer((_) async {});
    when(mockJnap.send(
            action: GetDeviceMode.instance, overrides: anyNamed('overrides')))
        .thenAnswer(
            (_) async => JNAPSuccess(result: 'OK', output: {'mode': 'Master'}));
    when(mockJnap.transaction(
            transactionBuilder: anyNamed('transactionBuilder'),
            overrides: anyNamed('overrides')))
        .thenAnswer(
            (_) async => JNAPTransactionSuccessWrap(result: 'OK', data: []));

    container = ProviderContainer(
      overrides: [
        jnapProvider.overrideWithValue(mockJnap),
        pollingConfigProvider.overrideWithValue(mockPollingConfig),
        pollingAdditionalTasksProvider.overrideWithValue(mockAdditionalTasks),
        pollingCompletedNotifierProvider
            .overrideWithValue(mockCompletedNotifier),
        cacheManagerProvider.overrideWithValue(PollingCacheManagerImpl()),
      ],
    );

    Config.auth = 'test-auth';
  });

  tearDown(() {
    container.dispose();
    Config.auth = '';
  });

  group('PollingNotifier', () {
    test('build initializes service and returns correct initial state', () {
      final notifier = container.read(pollingProvider.notifier);
      expect(notifier.state.value,
          const CoreTransactionData(lastUpdate: 0, isReady: false, data: {}));
    });

    test('startPolling does nothing if paused', () async {
      when(mockPollingConfig.isPaused).thenReturn(true);

      final notifier = container.read(pollingProvider.notifier);
      await notifier.startPolling();

      verifyNever(mockJnap.send(action: anyNamed('action')));
    });

    test('startPolling success path sets up timer and polls', () {
      fakeAsync((async) {
        final notifier = container.read(pollingProvider.notifier);
        notifier.startPolling();

        // Let checkSmartMode and its .then() chain run
        async.flushMicrotasks();
        verify(mockJnap.send(
          action: GetDeviceMode.instance,
          overrides: JNAPConfigOverrides(forceRemote: true),
        )).called(1);

        // Elapse time for the first poll delay
        async.elapse(const Duration(seconds: 1));
        verify(mockJnap.transaction(
          transactionBuilder: anyNamed('transactionBuilder'),
          overrides: anyNamed('overrides'),
        )).called(1);

        // Let the polling future complete
        async.flushMicrotasks();

        // Verify timer is set up for periodic polling
        expect(notifier.timer, isNotNull);
        expect(notifier.timer!.isActive, isTrue);

        // Elapse time for the next poll
        async.elapse(const Duration(seconds: 60));
        verify(mockJnap.transaction(
                transactionBuilder: anyNamed('transactionBuilder'),
                overrides: anyNamed('overrides')))
            .called(1); // Called once more

        notifier.stopPolling();
        expect(notifier.timer!.isActive, isFalse);
      });
    });

    test('startPolling handles checkSmartMode error', () async {
      final exception = Exception('Smart mode check failed');
      when(mockJnap.send(
              action: GetDeviceMode.instance, overrides: anyNamed('overrides')))
          .thenThrow(exception);

      final notifier = container.read(pollingProvider.notifier);
      // The startPolling method should throw an exception when checkSmartMode fails.
      // Using expectLater is the idiomatic way to test for exceptions in async code.
      await expectLater(
        () => notifier.startPolling(),
        throwsA(isA<Exception>()),
      );

      verify(mockJnap.send(
              action: GetDeviceMode.instance, overrides: anyNamed('overrides')))
          .called(1);
      verifyNever(mockJnap.transaction(
          transactionBuilder: anyNamed('transactionBuilder'),
          overrides: anyNamed('overrides')));
    });

    test('checkAndStartPolling does nothing if not authenticated', () {
      Config.auth = '';
      final notifier = container.read(pollingProvider.notifier);

      notifier.checkAndStartPolling();

      verifyNever(mockJnap.send(action: GetDeviceMode.instance));
    });

    test('checkAndStartPolling does nothing if timer is active', () {
      fakeAsync((async) {
        final notifier = container.read(pollingProvider.notifier);
        notifier.startPolling();
        async.flushMicrotasks();
        // Elapse time for the first poll delay to set up the timer
        async.elapse(const Duration(seconds: 1));
        expect(notifier.timer!.isActive, isTrue);

        // Reset mock to check for new calls
        clearInteractions(mockJnap);

        notifier.checkAndStartPolling();
        verifyNever(mockJnap.send(action: anyNamed('action')));
      });
    });

    test(
        'checkAndStartPolling with force starts polling even if timer is active',
        () {
      fakeAsync((async) {
        final notifier = container.read(pollingProvider.notifier);
        notifier.startPolling();
        async.flushMicrotasks();
        // Elapse time for the first poll delay to set up the timer
        async.elapse(const Duration(seconds: 1));
        expect(notifier.timer!.isActive, isTrue);

        clearInteractions(mockJnap);
        when(mockJnap.send(
                action: GetDeviceMode.instance,
                overrides: anyNamed('overrides')))
            .thenAnswer((_) async =>
                JNAPSuccess(result: 'OK', output: {'mode': 'Master'}));

        notifier.checkAndStartPolling(true);
        async.flushMicrotasks();
        // Elapse time for the first poll delay to set up the timer
        async.elapse(const Duration(seconds: 1));
        verify(mockJnap.send(
                action: GetDeviceMode.instance,
                overrides: anyNamed('overrides')))
            .called(1);
      });
    });

    test('forcePolling calls _polling with force=true', () {
      fakeAsync((async) {
        final notifier = container.read(pollingProvider.notifier);
        notifier.startPolling();
        async.flushMicrotasks(); // Initial poll

        notifier.forcePolling();
        async.flushMicrotasks();

        verify(mockJnap.transaction(
                transactionBuilder: anyNamed('transactionBuilder'),
                overrides: JNAPConfigOverrides(forceRemote: true)))
            .called(1);
      });
    });

    test('_polling success path updates state correctly', () async {
      final notifier = container.read(pollingProvider.notifier);

      // Manually trigger polling
      final pollingFuture = notifier.forcePolling();

      // State becomes loading immediately
      expect(notifier.state, isA<AsyncLoading>());

      await pollingFuture;

      // State becomes data
      expect(notifier.state, isA<AsyncData>());
      expect(notifier.state.value!.isReady, isTrue);
      verify(mockAdditionalTasks.additionalPolling()).called(1);
    });

    test('_polling failure path updates state and calls notifier', () async {
      final exception = Exception('Polling failed');
      when(mockJnap.transaction(
              transactionBuilder: anyNamed('transactionBuilder'),
              overrides: anyNamed('overrides')))
          .thenThrow(exception);
      final notifier = container.read(pollingProvider.notifier);
      // _polling handles the error internally by setting state to AsyncError,
      // so we don't expect forcePolling to throw.
      await notifier.forcePolling();

      expect(notifier.state, isA<AsyncError>());
      verify(mockCompletedNotifier.onPollingFailed()).called(1);
    });
  });
}
