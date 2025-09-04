import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/utilties/http/http_client.dart' as client;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements client.HttpClient {}

class MockJnap extends Mock implements Jnap {}

class MockDataCacheManager extends Mock implements DataCacheManager {}

class FakeUri extends Fake implements Uri {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

class FakeJNAPAction extends Fake implements JNAPAction {}

class FakeJNAPConfigOverrides extends Fake implements JNAPConfigOverrides {}

class FakeJNAPTransactionBuilder extends Fake
    implements JNAPTransactionBuilder {}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  group('Jnap unit tests', () {
    late MockHttpClient mockHttpClient;
    late MockDataCacheManager mockDataCacheManager;

    setUpAll(() {
      registerFallbackValue(FakeUri());
      registerFallbackValue(FakeBaseRequest());
      registerFallbackValue(FakeJNAPAction());
      registerFallbackValue(FakeJNAPConfigOverrides());
      registerFallbackValue(FakeJNAPTransactionBuilder());
    });

    setUp(() {
      // Reset config before each test
      Jnap.init(baseUrl: '', path: '', extraHeaders: {});
      CommandQueue.reset();
      mockHttpClient = MockHttpClient();
      mockDataCacheManager = MockDataCacheManager();
      DataCacheManager.setInstance(mockDataCacheManager);

      when(() => mockDataCacheManager.checkCacheDataValid(any())).thenReturn(false);
      when(() => mockDataCacheManager.lastSerialNumber).thenReturn('');
      when(() => mockDataCacheManager.handleJNAPCached(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockDataCacheManager.data).thenReturn({});
    });

    group('init', () {
      test('should set config values correctly', () {
        Jnap.init(
          baseUrl: 'http://example.com',
          path: '/api',
          extraHeaders: {'X-Test': 'true'},
          auth: 'YWRtaW46cGFzc3dvcmQ=', // admin:password
          authType: AuthType.basic,
        );

        expect(Config.baseUrl, 'http://example.com');
        expect(Config.path, '/api');
        expect(Config.extraHeaders, {'X-Test': 'true'});
        expect(Config.auth, 'YWRtaW46cGFzc3dvcmQ=');
        expect(Config.authType, AuthType.basic);
      });

      test('should throw exception for invalid url', () {
        expect(
            () => Jnap.init(
                  baseUrl: 'invalid-url',
                  path: '/api',
                  extraHeaders: {},
                ),
            throwsException);
      });

      test('should throw exception for non-base64 basic auth', () {
        expect(
            () => Jnap.init(
                  baseUrl: 'http://example.com',
                  path: '/api',
                  extraHeaders: {},
                  auth: 'not-base64',
                  authType: AuthType.basic,
                ),
            throwsException);
      });
    });

    group('updateUrl', () {
      test('should update url correctly', () {
        Jnap.updateUrl(baseUrl: 'http://new-example.com', path: '/new-api');
        expect(Config.baseUrl, 'http://new-example.com');
        expect(Config.path, '/new-api');
      });

      test('should throw exception for invalid url', () {
        Jnap.init(
            baseUrl: 'http://example.com', path: '/api', extraHeaders: {});
        expect(() => Jnap.updateUrl(baseUrl: 'invalid-url'), throwsException);
      });
    });

    group('updateAuth', () {
      test('should update auth correctly', () {
        Jnap.updateAuth(
            auth: 'bmV3LWF1dGg=', authType: AuthType.token); // new-auth
        expect(Config.auth, 'bmV3LWF1dGg=');
        expect(Config.authType, AuthType.token);
      });

      test('should throw exception for non-base64 basic auth', () {
        expect(
            () => Jnap.updateAuth(auth: 'not-base64', authType: AuthType.basic),
            throwsException);
      });
    });

    group('CommandQueue', () {
      test('should enqueue and process commands', () async {
        final commandQueue = CommandQueue();
        final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer(
                (_) async => http.Response(jsonEncode({'result': 'OK'}), 200));

        final future = commandQueue.enqueue(command);
        expect(commandQueue.queue.length, 1);

        await future;
        expect(commandQueue.queue.length, 0);
      });

      test('should pause and resume command processing', () async {
        final commandQueue = CommandQueue();
        commandQueue.pause = true;

        final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer(
                (_) async => http.Response(jsonEncode({'result': 'OK'}), 200));

        commandQueue.enqueue(command);
        expect(commandQueue.queue.length, 1);

        await Future.delayed(Duration(milliseconds: 100));
        expect(commandQueue.queue.length, 1);

        commandQueue.pause = false;
        await Future.delayed(Duration(milliseconds: 100));
        expect(commandQueue.queue.length, 0);
      });
    });

    group('JNAPCommand', () {
      test('should execute command and return success', () async {
        final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer(
                (_) async => http.Response(jsonEncode({'result': 'OK'}), 200));

        final result = await command.execute();
        expect(result, isA<JNAPSuccess>());
        expect(result.result, 'OK');
      });

      test('should use cache when available', () async {
        final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockDataCacheManager.checkCacheDataValid(any())).thenReturn(true);
        when(() => mockDataCacheManager.data).thenReturn({
          'testAction': {
            'data': {'result': 'OK', 'output': <String, dynamic>{}}
          }
        });

        final result = await command.execute();
        expect(result, isA<JNAPSuccess>());
        verifyNever(() => mockHttpClient.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')));
      });

      test('should fetch from remote when cache is invalid', () async {
        final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer(
                (_) async => http.Response(jsonEncode({'result': 'OK'}), 200));

        await command.execute();
        verify(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .called(1);
      });

      test('should throw ErrorResponse on http error', () async {
        final command = JNAPCommand(
          action: 'testAction',
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(jsonEncode({'error': 'Unauthorized'}), 401));

        expect(command.execute(), throwsA(isA<ErrorResponse>()));
      });
    });

    group('Jnap.send', () {
      test('should enqueue a command and return success', () async {
        final jnap = Jnap.instance;
        final action = GetDeviceInfo.instance;

        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(
                jsonEncode({
                  'result': 'OK',
                  'output': {'deviceName': 'TestDevice'}
                }),
                200));

        final result =
            await jnap.send(action: action, httpClient: mockHttpClient);

        expect(result, isA<JNAPSuccess>());
      });

      test('should throw JNAPError on command failure', () async {
        final jnap = Jnap.instance;
        final action = GetDeviceInfo.instance;

        when(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(jsonEncode({'result': 'ERROR', 'error': 'Device not found'}), 200));

        expect(jnap.send(action: action, httpClient: mockHttpClient), throwsA(isA<JNAPError>()));
      });
    });

    group('JNAPConfigOverrides', () {
      test('should override default config', () async {
        Jnap.init(
          baseUrl: 'http://example.com',
          path: '/api',
          extraHeaders: {},
        );

        final overrides = JNAPConfigOverrides(
          baseUrl: 'http://override.com',
          path: '/override',
          extraHeaders: {'X-Override': 'true'},
          timeoutMs: 5000,
        );

        final command = JNAPCommand(
          action: 'testAction',
          overrides: overrides,
          httpClient: mockHttpClient,
          cacheManager: mockDataCacheManager,
        );

        when(() => mockHttpClient.post(any(),
                body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer(
                (_) async => http.Response(jsonEncode({'result': 'OK'}), 200));

        await command.execute();

        final captured = verify(() => mockHttpClient.post(captureAny(),
                body: any(named: 'body'), headers: captureAny(named: 'headers')))
            .captured;
        final uri = captured[0] as Uri;
        final headers = captured[1] as Map<String, String>;

        expect(uri.toString(), 'http://override.com/override');
        expect(headers['X-Override'], 'true');
        verify(() => mockHttpClient.timeoutMs = 5000);
      });
    });

    group('Jnap.transaction', () {
      test('should send a transaction and return success', () async {
        final jnap = Jnap.instance;
        final action1 = GetDeviceInfo.instance;
        final action2 = GetNetworkConnections.instance;

        final transactionBuilder = JNAPTransactionBuilder()
            .add(action1)
            .add(action2, data: {'some_key': 'some_value'});

        final transactionResponse = {
          'result': 'OK',
          'responses': [
            {'result': 'OK', 'output': {'deviceName': 'TestDevice'}},
            {'result': 'OK', 'output': {'connections': []}}
          ]
        };

        when(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(jsonEncode(transactionResponse), 200));

        final result = await jnap.transaction(
          transactionBuilder: transactionBuilder,
          httpClient: mockHttpClient,
        );

        expect(result, isA<JNAPTransactionSuccessWrap>());
        expect(result.data.length, 2);
        expect(result.data[0].key, action1);
        expect(result.data[0].value.result, 'OK');
        expect((result.data[0].value as JNAPSuccess).output, {'deviceName': 'TestDevice'});
        expect(result.data[1].key, action2);
        expect(result.data[1].value.result, 'OK');
        expect((result.data[1].value as JNAPSuccess).output, {'connections': []});

        final captured = verify(() => mockHttpClient.post(any(), body: captureAny(named: 'body'), headers: any(named: 'headers'))).captured;
        final body = jsonDecode(captured.first);

        expect(body, isA<List>());
        expect(body.length, 2);
        expect(body[0]['action'], action1.command);
        expect(body[1]['action'], action2.command);
        expect(body[1]['request'], {'some_key': 'some_value'});
      });

      test('should use cache when available for transaction', () async {
        final jnap = Jnap.instance;
        final action1 = GetDeviceInfo.instance;
        final action2 = GetNetworkConnections.instance;

        final transactionBuilder = JNAPTransactionBuilder()
            .add(action1)
            .add(action2, data: {'some_key': 'some_value'});

        when(() => mockDataCacheManager.checkCacheDataValid(any())).thenReturn(true);
        when(() => mockDataCacheManager.data).thenReturn({
          'http://linksys.com/jnap/core/GetDeviceInfo': {
            'data': {'result': 'OK', 'output': {'deviceName': 'CachedDevice'}}
          },
          'http://linksys.com/jnap/networkconnections/GetNetworkConnections': {
            'data': {'result': 'OK', 'output': {'connections': ['cached_connection']}}
          }
        });

        final result = await jnap.transaction(
          transactionBuilder: transactionBuilder,
          httpClient: mockHttpClient,
        );

        expect(result, isA<JNAPTransactionSuccessWrap>());
        expect(result.data.length, 2);
        expect(result.data[0].key, action1);
        expect(result.data[0].value.result, 'OK');
        expect((result.data[0].value as JNAPSuccess).output, {'deviceName': 'CachedDevice'});
        expect(result.data[1].key, action2);
        expect(result.data[1].value.result, 'OK');
        expect((result.data[1].value as JNAPSuccess).output, {'connections': ['cached_connection']});

        verifyNever(() => mockHttpClient.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')));
      });

      test('should send HTTP request when some commands are not cached in transaction', () async {
        Jnap.init(baseUrl: 'http://linksys.com', path: '/jnap', extraHeaders: {}); // Added Jnap.init
        final jnap = Jnap.instance;
        final action1 = GetDeviceInfo.instance; // This one will be cached
        final action2 = GetNetworkConnections.instance; // This one will NOT be cached

        final transactionBuilder = JNAPTransactionBuilder()
            .add(action1)
            .add(action2, data: {'some_key': 'some_value'});

        final remoteTransactionResponse = {
          'result': 'OK',
          'responses': [
            {'result': 'OK', 'output': {'deviceName': 'RemoteDevice'}},
            {'result': 'OK', 'output': {'connections': ['remote_connection']}}
          ]
        };

        when(() => mockDataCacheManager.checkCacheDataValid(action1.command)).thenReturn(true);
        when(() => mockDataCacheManager.checkCacheDataValid(action2.command)).thenReturn(false);

        when(() => mockDataCacheManager.data).thenReturn({
          action1.command: {
            'data': {'result': 'OK', 'output': {'deviceName': 'CachedDevice'}}
          }
        });

        when(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(jsonEncode(remoteTransactionResponse), 200));

        final result = await jnap.transaction(
          transactionBuilder: transactionBuilder,
          httpClient: mockHttpClient,
        );

        expect(result, isA<JNAPTransactionSuccessWrap>());
        expect(result.data.length, 2);

        expect(result.data[0].key, action1);
        expect(result.data[0].value.result, 'OK');
        expect((result.data[0].value as JNAPSuccess).output, {'deviceName': 'RemoteDevice'});

        expect(result.data[1].key, action2);
        expect(result.data[1].value.result, 'OK');
        expect((result.data[1].value as JNAPSuccess).output, {'connections': ['remote_connection']});

        final captured = verify(() => mockHttpClient.post(captureAny(), body: captureAny(named: 'body'), headers: captureAny(named: 'headers'))).captured;
        final uri = captured[0] as Uri;
        final body = jsonDecode(captured[1]);
        final headers = captured[2] as Map<String, String>;

        expect(uri.toString(), 'http://linksys.com/jnap');
        expect(headers['X-JNAP-Action'], 'http://linksys.com/jnap/core/Transaction');
        expect(headers['content-type'], 'application/json');

        expect(body, isA<List>());
        expect(body.length, 2);
        expect(body[0]['action'], action1.command);
        expect(body[1]['action'], action2.command);
        expect(body[1]['request'], {'some_key': 'some_value'});
      });
    });

    group('Jnap.scheduled', () {
      test('should poll and retry until condition is met', () async {
        final jnap = Jnap.instance;
        final action = GetDeviceInfo.instance;

        var callCount = 0;
        when(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
            .thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            return http.Response(jsonEncode({'result': 'OK', 'output': {'status': 'pending'}}), 200);
          } else {
            return http.Response(jsonEncode({'result': 'OK', 'output': {'status': 'completed'}}), 200);
          }
        });

        final stream = jnap.scheduled(
          action: action,
          condition: (result) {
            if (result is JNAPSuccess) {
              return result.output['status'] == 'pending';
            }
            return true;
          },
          maxRetry: 5,
          firstDelayInMilliSec: 10,
          retryDelayInMilliSec: 10,
          httpClient: mockHttpClient,
        );

        final results = await stream.toList();

        expect(results.length, 2);
        expect(results[0], isA<JNAPSuccess>());
        expect((results[0] as JNAPSuccess).output['status'], 'pending');
        expect(results[1], isA<JNAPSuccess>());
        expect((results[1] as JNAPSuccess).output['status'], 'completed');

        verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(2);
      });
    });
  });
}
