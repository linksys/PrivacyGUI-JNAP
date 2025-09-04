import 'package:jnap/jnap.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:fake_async/fake_async.dart';

class MockJnap extends Mock implements Jnap {}

// Mock JNAPResult for testing side effects
class MockJNAPResult extends JNAPResult with SideEffectGetter {
  final List<String>? _sideEffects;

  MockJNAPResult({String result = 'OK', List<String>? sideEffects})
      : _sideEffects = sideEffects,
        super(result: result);

  @override
  List<String>? getSideEffects() => _sideEffects;
}

// Mock for the poll function to simulate different scenarios
class MockPollFunction {
  int callCount = 0;
  final List<Future<bool> Function()> responses = [];

  Future<bool> call() async {
    if (callCount < responses.length) {
      return responses[callCount++]();
    }
    return false;
  }

  void whenCall(Future<bool> Function() response) {
    responses.add(response);
  }

  void reset() {
    callCount = 0;
    responses.clear();
  }
}

class FakeJNAPAction extends Fake implements JNAPAction {}

class FakeJNAPConfigOverrides extends Fake implements JNAPConfigOverrides {}

class FakeJNAPSideEffectOverrides extends Fake
    implements JNAPSideEffectOverrides {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJNAPAction());
    registerFallbackValue(FakeJNAPConfigOverrides());
    registerFallbackValue(FakeJNAPSideEffectOverrides());
  });

  group('SideEffectHandler', () {
    late SideEffectHandler sideEffectHandler;
    late MockJnap mockJnap;

    setUp(() {
      mockJnap = MockJnap();
      sideEffectHandler =
          SideEffectHandler(jnap: mockJnap, cachedSerialNumber: 'TEST_SN');
    });

    group('handleSideEffect', () {
      test('should do nothing if there are no side effects', () async {
        final result = MockJNAPResult(sideEffects: []);
        final finalResult = await sideEffectHandler.handleSideEffect(result);

        expect(finalResult, same(result));
        verifyZeroInteractions(mockJnap);
      });

      test('should throw SideEffectMaxRetryException on poll failure',
          () async {
        // Make the underlying poll functions fail
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenAnswer(
            (_) async => JNAPSuccess(result: 'ERROR')); // Simulate failure

        final result = MockJNAPResult(sideEffects: ['DeviceRestart']);

        expect(
          () => sideEffectHandler.handleSideEffect(
            result,
            overrides: JNAPSideEffectOverrides(
                maxRetry: 1, retryDelayInSec: 0, timeDelayStartInSec: 0),
          ),
          throwsA(isA<SideEffectMaxRetryException>().having(
            (e) => e.attached,
            'attached',
            same(result),
          )),
        );
      });

      test('should call beforeHandle and afterHandle overrides', () async {
        var beforeCalled = false;
        var afterCalled = false;

        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenAnswer((invocation) async {
          final action = invocation.namedArguments[#action] as JNAPAction;
          if (action.name == GetWANStatus.instance.name) {
            return JNAPSuccess(
                result: 'OK', output: {'wanStatus': 'Connected'});
          }
          // Add this condition for GetDeviceInfo
          if (action.name == GetDeviceInfo.instance.name) {
            return JNAPSuccess(
                result: 'OK', output: {'serialNumber': 'TEST_SN'});
          }
          return JNAPSuccess(result: 'OK');
        });

        final result = MockJNAPResult(sideEffects: ['DeviceRestart']);
        final overrides = JNAPSideEffectOverrides(
          beforeHandle: () {
            beforeCalled = true;
            return true;
          },
          afterHandle: () {
            afterCalled = true;
            return true;
          },
        );
        sideEffectHandler.setTimeGetter(
            () => DateTime.now().millisecondsSinceEpoch + 21 * 1000);
        await sideEffectHandler.handleSideEffect(result, overrides: overrides);

        expect(beforeCalled, isTrue);
        expect(afterCalled, isTrue);
      });

      test('should call afterHandle even on failure', () async {
        var afterCalled = false;
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenAnswer(
            (_) async => JNAPSuccess(result: 'ERROR')); // Simulate failure

        final result = MockJNAPResult(sideEffects: ['DeviceRestart']);
        final overrides = JNAPSideEffectOverrides(
          afterHandle: () {
            afterCalled = true;
            return true;
          },
          maxRetry: 1,
          retryDelayInSec: 0,
          timeDelayStartInSec: 0,
        );

        await expectLater(
          () =>
              sideEffectHandler.handleSideEffect(result, overrides: overrides),
          throwsA(isA<SideEffectMaxRetryException>()),
        );

        expect(afterCalled, isTrue);
      });
    });

    group('testRouterReconnected', () {
      test('should return true when device reconnected and fully booted',
          () async {
        // Arrange
        when(() => mockJnap.send(
                action: GetDeviceInfo.instance,
                data: any(named: 'data'),
                headers: any(named: 'headers'),
                overrides: any(named: 'overrides'),
                sideEffectOverrides: any(named: 'sideEffectOverrides'),
                httpClient: any(named: 'httpClient')))
            .thenAnswer((_) async =>
                JNAPSuccess(result: 'OK', output: {'serialNumber': 'TEST_SN'}));

        when(() => mockJnap.send(
                action: GetWANStatus.instance,
                data: any(named: 'data'),
                headers: any(named: 'headers'),
                overrides: any(named: 'overrides'),
                sideEffectOverrides: any(named: 'sideEffectOverrides'),
                httpClient: any(named: 'httpClient')))
            .thenAnswer((_) async =>
                JNAPSuccess(result: 'OK', output: {'wanStatus': 'Connected'}));

        // Act
        sideEffectHandler.setTimeGetter(
            () => DateTime.now().millisecondsSinceEpoch + 21 * 1000);
        final result = await sideEffectHandler.testRouterReconnected();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when serial number does not match', () async {
        sideEffectHandler =
            SideEffectHandler(jnap: mockJnap, cachedSerialNumber: 'SN123');

        when(() => mockJnap.send(
                action: GetDeviceInfo.instance,
                data: any(named: 'data'),
                headers: any(named: 'headers'),
                overrides: any(named: 'overrides'),
                sideEffectOverrides: any(named: 'sideEffectOverrides'),
                httpClient: any(named: 'httpClient')))
            .thenAnswer((_) async =>
                JNAPSuccess(result: 'OK', output: {'serialNumber': 'SN456'}));

        final result = await sideEffectHandler.testRouterReconnected();
        expect(result, isFalse);
      });

      test('should return false when GetDeviceInfo fails', () async {
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenThrow(Exception('Network Error'));

        final result = await sideEffectHandler.testRouterReconnected();
        expect(result, isFalse);
      });
    });

    group('testRouterFullyBootedUp', () {
      test('should return true when WAN is connected', () async {
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenAnswer((_) async =>
            JNAPSuccess(result: 'OK', output: {'wanStatus': 'Connected'}));

        sideEffectHandler.setTimeGetter(
            () => DateTime.now().millisecondsSinceEpoch + 21 * 1000);
        final result = await sideEffectHandler.testRouterFullyBootedUp();
        expect(result, isTrue);
      });

      test('should return false when WAN is not connected', () async {
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenAnswer((_) async =>
            JNAPSuccess(result: 'OK', output: {'wanStatus': 'Disconnected'}));

        sideEffectHandler.setTimeGetter(
            () => DateTime.now().millisecondsSinceEpoch + 21 * 1000);
        final result = await sideEffectHandler.testRouterFullyBootedUp();
        expect(result, isFalse);
      });

      test('should return false when router is not responding long enough',
          () async {
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenAnswer((_) async =>
            JNAPSuccess(result: 'OK', output: {'wanStatus': 'Connected'}));

        // Do not set timeGetter, so isRouterRespondingLongEnough is false
        final result = await sideEffectHandler.testRouterFullyBootedUp();
        expect(result, isFalse);
      });

      test('should return false when GetWANStatus fails', () async {
        when(() => mockJnap.send(
          action: any(named: 'action'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
          overrides: any(named: 'overrides'),
          sideEffectOverrides: any(named: 'sideEffectOverrides'),
          httpClient: any(named: 'httpClient'),
        )).thenThrow(Exception('Network Error'));

        final result = await sideEffectHandler.testRouterFullyBootedUp();
        expect(result, isFalse);
      });
    });

    group('poll function tests', () {
      late MockPollFunction mockPollFunc;

      setUp(() {
        mockPollFunc = MockPollFunction();
      });

      tearDown(() {
        mockPollFunc.reset();
      });

      test('should succeed on first attempt', () async {
        mockPollFunc.whenCall(() async => true);

        final result = await sideEffectHandler.poll(
          pollFunc: mockPollFunc,
          retryDelayInSec: 0, // No delay for tests
        );

        expect(result, isTrue);
        expect(mockPollFunc.callCount, 1);
      });

      test('should retry and eventually succeed', () async {
        mockPollFunc.whenCall(() async => false); // First attempt fails
        mockPollFunc.whenCall(() async => false); // Second attempt fails
        mockPollFunc.whenCall(() async => true); // Third attempt succeeds

        final result = await sideEffectHandler.poll(
          pollFunc: mockPollFunc,
          retryDelayInSec: 0,
          maxRetry: 5,
        );

        expect(result, isTrue);
        expect(mockPollFunc.callCount, 3);
      });

      test('should respect maxRetry limit', () async {
        mockPollFunc.whenCall(() async => false);
        mockPollFunc.whenCall(() async => false);
        mockPollFunc.whenCall(() async => false);
        mockPollFunc.whenCall(() async => false);

        await expectLater(
          sideEffectHandler.poll(
            pollFunc: mockPollFunc,
            maxRetry: 3,
            retryDelayInSec: 0,
          ),
          throwsA(isA<MaxRetriesExceededException>()),
        );

        expect(mockPollFunc.callCount, 4); // Initial + maxRetry
      });

      test('should respect maxPollTimeInSec limit', () {
        fakeAsync((async) {
          mockPollFunc.whenCall(() async {
            await Future.delayed(Duration(seconds: 1));
            return false;
          }); // Always returns false

          final future = sideEffectHandler.poll(
            pollFunc: mockPollFunc,
            maxPollTimeInSec: 5, // Max execution time is 2 seconds
            retryDelayInSec: 1,
            maxRetry: 100, // No delay between retries
          );

          expect(future, throwsA(isA<MaxRetriesExceededException>()));
          // Elapse time to trigger the maxExecutionTime
          async.elapse(
              Duration(seconds: 10, milliseconds: 1)); // Just over 2 seconds
          async
              .flushMicrotasks(); // Added to ensure all microtasks are processed
        });
      });
    });
  });
}