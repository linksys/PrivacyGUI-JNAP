import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jnap/http.dart' as my_http;
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/cache/cache_manager_base.dart'
    if (dart.library.io) 'package:jnap/src/cache/cache_manager_mobile.dart'
    if (dart.library.html) 'package:jnap/src/cache/cache_manager_web.dart';
import 'package:jnap/utils.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements my_http.HttpClient {}

class MockResponse extends Mock implements Response {}

class MockBasedCacheManager extends Mock implements BasedCacheManager {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockResponse mockResponse;
  late MockBasedCacheManager mockBasedCacheManager;
  late DataCacheManager cacheManager;

  setUpAll(() {
    registerFallbackValue(FakeUri());
    registerFallbackValue(http.Request('GET', FakeUri()));
  });

  setUp(() {
    logger.d('JNAP Command setUp');
    mockHttpClient = MockHttpClient();
    mockResponse = MockResponse();
    mockBasedCacheManager = MockBasedCacheManager();
    when(() => mockBasedCacheManager.get()).thenAnswer((_) async => '');
    cacheManager = DataCacheManager(mockBasedCacheManager);

    when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

    Config.baseUrl = 'http://default.com';
    Config.path = '/jnap';
    Config.extraHeaders = {};
    Config.auth = '';
    Config.authType = AuthType.basic;
  });

  group('JNAPCommand', () {
    tearDown(() {
      cacheManager.releaseInstance();
    });
    test('constructor sets properties correctly', () {
      final overrides = JNAPConfigOverrides(baseUrl: 'http://override.com');
      final command = JNAPCommand(
        action: 'testAction',
        data: '{"key": "value"}',
        headers: {'X-Test': '1'},
        overrides: overrides,
        httpClient: mockHttpClient,
      );
      expect(command.action, 'testAction');
      expect(command.data, '{"key": "value"}');
      expect(command.headers, {'X-Test': '1'});
      expect(command.overrides, overrides);
      expect(command.overrides?.baseUrl, 'http://override.com');
    });

    test('execute sends correct HTTP request with default config', () async {
      Config.auth = 'YWRtaW46cGFzc3dvcmQ='; // admin:password
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body)
          .thenReturn('{"result": "OK", "output": {"status": "success"}}');
      when(() => mockHttpClient.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => mockResponse);

      final command = JNAPCommand(
        action: 'testAction',
        data: '{"param": "value"}',
        httpClient: mockHttpClient,
      );

      final result = await command.execute();

      expect(result, isA<JNAPSuccess>());
      expect((result as JNAPSuccess).result, 'OK');

      final captured = verify(() => mockHttpClient.post(
        Uri.parse('http://default.com/jnap'),
        body: '{"param": "value"}',
        headers: captureAny(named: 'headers'),
      )).captured;

      final headers = captured.first as Map<String, String>;
      expect(headers['X-JNAP-Action'], 'testAction');
      expect(headers['X-Jnap-Authorization'],
          'Basic YWRtaW46cGFzc3dvcmQ=');

      verify(() => mockHttpClient.timeoutMs = 10000).called(1);
      verify(() => mockHttpClient.retries = 1).called(1);
    });

    test('execute sends correct HTTP request with overrides', () async {
      final overrides = JNAPConfigOverrides(
        baseUrl: 'http://override.com',
        path: '/override',
        extraHeaders: {'X-Override': 'true'},
        auth: 'overrideAuth',
        authType: AuthType.token,
        timeoutMs: 5000,
        retries: 3,
        forceRemote: true,
        cached: false,
      );

      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body)
          .thenReturn('{"result": "OK", "output": {"status": "success"}}');
      when(() => mockHttpClient.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => mockResponse);
      await cacheManager.loadCache(serialNumber: 'SN1');
      final command = JNAPCommand(
        action: 'testAction',
        data: '{"param": "value"}',
        headers: {'Custom-Header': 'value'},
        overrides: overrides,
        httpClient: mockHttpClient,
      );

      final result = await command.execute();

      expect(result, isA<JNAPSuccess>());
      expect((result as JNAPSuccess).result, 'OK');

      final captured = verify(() => mockHttpClient.post(
        Uri.parse('http://override.com/override'),
        body: '{"param": "value"}',
        headers: captureAny(named: 'headers'),
      )).captured;

      final headers = captured.first as Map<String, String>;
      expect(headers['X-JNAP-Action'], 'testAction');
      expect(headers[HttpHeaders.authorizationHeader], 'Bearer overrideAuth');
      expect(headers['X-Override'], 'true');
      expect(headers['Custom-Header'], 'value');

      verify(() => mockHttpClient.timeoutMs = 5000).called(1);
      verify(() => mockHttpClient.retries = 3).called(1);
    });

    test('isComplete returns true after complete is called', () {
      final command = JNAPCommand(action: 'test');
      expect(command.isComplete(), isFalse);
      command.complete(JNAPSuccess(result: 'OK'));
      expect(command.isComplete(), isTrue);
    });

    test('wait returns the completed response', () async {
      final command = JNAPCommand(action: 'test');
      final expectedResult = JNAPSuccess(result: 'OK');

      Future.delayed(const Duration(milliseconds: 10), () {
        command.complete(expectedResult);
      });

      final response = await command.wait();
      expect(response, expectedResult);
    });

    test('wait throws error if completeError is called', () async {
      final command = JNAPCommand(action: 'test');
      final expectedError = Exception('Test Error');

      Future.delayed(const Duration(milliseconds: 10), () {
        command.completeError(expectedError, StackTrace.current);
      });

      expect(() => command.wait(), throwsA(equals(expectedError)));
    });

    group('with caching', () {
      setUp(() {
        logger.d('JNAP Command with caching setUp');
      });
      tearDown(() {
        cacheManager.clearAllCache();
        cacheManager.releaseInstance();
      });
      test('execute returns cached result when valid cache exists', () async {
        final cacheData = {
          'testAction': {
            'data': {
              'result': 'OK',
              'output': {'status': 'cached_success'}
            },
            'cachedAt': DateTime.now().millisecondsSinceEpoch,
          }
        };
        when(() => mockBasedCacheManager.get())
            .thenAnswer((_) async => jsonEncode({'SN12345': cacheData}));
        await cacheManager.loadCache(serialNumber: 'SN12345');

        final command = JNAPCommand(
          action: 'testAction',
          overrides: JNAPConfigOverrides(forceRemote: false),
          httpClient: mockHttpClient,
          cacheManager: cacheManager,
        );

        final result = await command.execute();

        expect(result, isA<JNAPSuccess>());
        expect((result as JNAPSuccess).output['status'], 'cached_success');
        verifyNever(() => mockHttpClient.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')));
      });

      test('execute makes HTTP request when cache is expired', () async {
        final cacheData = {
          'testAction': {
            'data': {
              'result': 'OK',
              'output': {'status': 'cached_success'}
            },
            'cachedAt': 0, // A long time ago
          }
        };
        when(() => mockBasedCacheManager.get())
            .thenAnswer((_) async => jsonEncode({'SN1234': cacheData}));
        await cacheManager.loadCache(serialNumber: 'SN1234');

        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(
            '{"result": "OK", "output": {"status": "remote_success"}}');
        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        final command = JNAPCommand(
          action: 'testAction',
          overrides: JNAPConfigOverrides(forceRemote: false),
          httpClient: mockHttpClient,
        );

        final result = await command.execute();

        expect(result, isA<JNAPSuccess>());
        expect((result as JNAPSuccess).output['status'], 'remote_success');
        verify(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .called(1);
        verify(() => mockBasedCacheManager.set(any())).called(1);
      });

      test('execute makes HTTP request when forceRemote is true', () async {
        final overrides = JNAPConfigOverrides(forceRemote: true);
        final cacheData = {
          'testAction': {
            'data': {
              'result': 'OK',
              'output': {'status': 'cached_success'}
            },
            'cachedAt': DateTime.now().millisecondsSinceEpoch,
          }
        };
        when(() => mockBasedCacheManager.get())
            .thenAnswer((_) async => jsonEncode({'SN222': cacheData}));
        await cacheManager.loadCache(serialNumber: 'SN222');

        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(
            '{"result": "OK", "output": {"status": "force_remote_success"}}');
        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        final command = JNAPCommand(
          action: 'testAction',
          overrides: overrides,
          httpClient: mockHttpClient,
          cacheManager: cacheManager,
        );

        final result = await command.execute();

        expect(result, isA<JNAPSuccess>());
        expect(
            (result as JNAPSuccess).output['status'], 'force_remote_success');
        verify(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .called(1);
        verify(() => mockBasedCacheManager.set(any())).called(1);
      });

      test('execute makes HTTP request and does not cache when cached is false',
          () async {
        final overrides = JNAPConfigOverrides(cached: false);
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(
            '{"result": "OK", "output": {"status": "no_cache_success"}}');
        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        final command = JNAPCommand(
          action: 'testAction',
          overrides: overrides,
          httpClient: mockHttpClient,
          cacheManager: cacheManager,
        );

        final result = await command.execute();

        expect(result, isA<JNAPSuccess>());
        expect((result as JNAPSuccess).output['status'], 'no_cache_success');
        verify(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .called(1);
        verifyNever(() => mockBasedCacheManager.set(any()));
      });

      test('execute make transaction request and caching correctly', () async {
        final transactionData = [
          {'action': 'action1', 'request': {}},
          {'action': 'action2', 'request': {}}
        ];

        final now = DateTime.now().millisecondsSinceEpoch;
        final cacheData = {
          'action1': {
            'data': {
              'result': 'OK',
              'output': {'status': 'cached_action1'}
            },
            'cachedAt': now
          },
          'action2': {
            'data': {
              'result': 'OK',
              'output': {'status': 'cached_action2'}
            },
            'cachedAt': now
          }
        };
        when(() => mockBasedCacheManager.get())
            .thenAnswer((_) async => jsonEncode({'SN333': cacheData}));
        await cacheManager.loadCache(serialNumber: 'SN333');

        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(
            '{"result": "OK", "responses": [{"result":"OK","output": {"status": "force_remote_success_1"}},{"result":"OK","output": {"status": "force_remote_success_2"}}]}');
        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => mockResponse);

        final command = JNAPCommand(
          action: 'http://cisco.com/jnap/transaction/Execute',
          data: jsonEncode(transactionData),
          overrides: JNAPConfigOverrides(forceRemote: false),
          httpClient: mockHttpClient,
          cacheManager: cacheManager,
        );

        final result = await command.execute();

        expect(result, isA<JNAPTransactionSuccess>());
        final transactionResult = result as JNAPTransactionSuccess;
        expect(transactionResult.result, 'OK');
        expect(transactionResult.responses.length, 2);
        expect(transactionResult.responses[0].result, 'OK');
        expect(transactionResult.responses[1].result, 'OK');
        verify(() => mockHttpClient.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')));
        verify(() => mockBasedCacheManager.set(any()));
      });
    });
  });

  group('CommandQueue', () {
    late MockHttpClient mockHttpClient;
    late MockResponse mockResponse;

    setUp(() {
      mockHttpClient = MockHttpClient();
      mockResponse = MockResponse();
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.body)
          .thenReturn('{"result": "OK", "output": {"status": "success"}}');

      when(() => mockHttpClient.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => mockResponse);

      CommandQueue.reset();

      Config.baseUrl = 'http://test.com';
      Config.path = '/api';
      Config.extraHeaders = {};
      Config.auth = '';
      Config.authType = AuthType.basic;
    });

    tearDown(() {
      CommandQueue().isPaused = true;
      CommandQueue.reset();
    });

    test('is a singleton', () {
      final queue1 = CommandQueue();
      final queue2 = CommandQueue();
      expect(queue1, same(queue2));
    });

    test('enqueue adds command to queue and processes it', () async {
      final queue = CommandQueue();
      final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: cacheManager);

      final future = queue.enqueue(command);

      expect(queue.queue.contains(command), isTrue);

      final response = await future;
      expect(response, isA<JNAPSuccess>());
      expect(command.isComplete(), isTrue);
    });

    test('commands are consumed in FIFO order', () async {
      final queue = CommandQueue();
      final executionOrder = <String>[];

      final command1 = JNAPCommand(
          action: 'action1',
          httpClient: mockHttpClient,
          cacheManager: cacheManager);
      final command2 = JNAPCommand(
          action: 'action2',
          httpClient: mockHttpClient,
          cacheManager: cacheManager);
      final command3 = JNAPCommand(
          action: 'action3',
          httpClient: mockHttpClient,
          cacheManager: cacheManager);

      when(() => mockHttpClient.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) async {
        final actionHeader = (invocation.namedArguments[#headers]
            as Map<String, String>)['X-JNAP-Action'];
        executionOrder.add(actionHeader!);
        await Future.delayed(const Duration(milliseconds: 10));
        return mockResponse;
      });

      final f1 = queue.enqueue(command1);
      final f2 = queue.enqueue(command2);
      final f3 = queue.enqueue(command3);

      await Future.wait([f1, f2, f3]);

      expect(executionOrder, ['action1', 'action2', 'action3']);
      expect(command1.isComplete(), isTrue);
      expect(command2.isComplete(), isTrue);
      expect(command3.isComplete(), isTrue);
    });

    test('pause prevents command consumption until resumed', () async {
      final queue = CommandQueue();
      final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          overrides: JNAPConfigOverrides(forceRemote: true));

      queue.isPaused = true;
      queue.enqueue(command);

      await Future.delayed(const Duration(milliseconds: 100));
      expect(command.isComplete(), isFalse);
      verifyNever(() => mockHttpClient.post(any(),
          body: any(named: 'body'), headers: any(named: 'headers')));

      queue.isPaused = false;
      await Future.delayed(const Duration(milliseconds: 100));
      expect(command.isComplete(), isTrue);
      verify(() => mockHttpClient.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .called(1);
    });

    test('timer stops after being idle', () async {
      final queue = CommandQueue();
      await queue.enqueue(JNAPCommand(
          action: 'dummy',
          httpClient: mockHttpClient,
          cacheManager: cacheManager));

      expect(queue.timer?.isActive, isTrue);

      await Future.delayed(const Duration(seconds: 4));

      expect(queue.timer, isNull);
    }, timeout: Timeout(Duration(seconds: 10)));

    test('reset clears singleton instance', () {
      final queue1 = CommandQueue();
      CommandQueue.reset();
      final queue2 = CommandQueue();
      expect(queue1, isNot(same(queue2)));
    });
  });
}