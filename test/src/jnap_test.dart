import 'dart:io';

import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/config.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:test/test.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

///
/// These tests are test real JNAP requests
///
///
void main() {
  HttpOverrides.global = MyHttpOverrides();

  group('local JNAP', tags: 'manual', () {
    test('test JNAP send without init auth', () async {
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
      );
      await Jnap.instance.send(action: GetDeviceInfo.instance);
    });
    test('test JNAP send', () async {
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46N3FXMTlzdDVtQA==',
        authType: AuthType.basic,
      );
      await Jnap.instance.send(action: GetDeviceInfo.instance);
    });

    test('test JNAP send with cache', () async {
      CacheConfig.expiration = 2000 * 10;
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46N3FXMTlzdDVtQA==',
        authType: AuthType.basic,
      );
      // 1st send
      await Jnap.instance.send(action: GetDeviceInfo.instance);
      // 2nd send, should use cache
      await Jnap.instance.send(action: GetDeviceInfo.instance);
      // 3rd wait for cache expired
      await Future.delayed(const Duration(seconds: 10));
      // 4th send, should not use cache
      await Jnap.instance.send(action: GetDeviceInfo.instance);
    });

    test('test JNAP transaction', () async {
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46N3FXMTlzdDVtQA==',
        authType: AuthType.basic,
      );
      final result = await Jnap.instance.transaction(
        transactionBuilder: JNAPTransactionBuilder(
          commands: [
            MapEntry(GetDeviceInfo.instance, {}),
            MapEntry(GetWANStatus.instance, {}),
          ],
        ),
      );
      expect(result, isA<JNAPTransactionSuccessWrap>());
      expect(result.data.length, 2);
      expect(result.data[0].key, GetDeviceInfo.instance);
      expect(result.data[0].value, isA<JNAPSuccess>());
      expect(result.data[1].key, GetWANStatus.instance);
      expect(result.data[1].value, isA<JNAPSuccess>());
    });

    test('test JNAP scheulded polls multiple times', () async {
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46N3FXMTlzdDVtQA==',
        authType: AuthType.basic,
      );

      int executionCount = 0;
      const desiredExecutions = 3;

      final stream = Jnap.instance.scheulded(
        action: GetDeviceInfo.instance,
        maxRetry: 5,
        firstDelayInMilliSec: 100, // Use short delays for the test
        retryDelayInMilliSec: 100,
        condition: (result) {
          executionCount++;
          // Return true to keep polling, until we've executed the desired number of times.
          return executionCount < desiredExecutions;
        },
      );

      // We expect the stream to emit a successful result `desiredExecutions` times.
      // The final emission will have shouldRetry=false, so the stream will close.
      final results = await stream.toList();

      expect(results.length, desiredExecutions);
      expect(results.every((r) => r is JNAPSuccess), isTrue);
      expect(executionCount, desiredExecutions);
    });

    test('test JNAP scheulded onComplete is called when condition is met', () async {
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46N3FXMTlzdDVtQA==',
        authType: AuthType.basic,
      );

      int executionCount = 0;
      const desiredExecutions = 2;
      bool onCompleteCalled = false;
      JNAPResult? onCompleteResult;

      final stream = Jnap.instance.scheulded(
        action: GetDeviceInfo.instance,
        maxRetry: 5,
        firstDelayInMilliSec: 100,
        retryDelayInMilliSec: 100,
        condition: (result) {
          executionCount++;
          return executionCount < desiredExecutions;
        },
        onComplete: (result, error) {
          onCompleteCalled = true;
          onCompleteResult = result;
        },
      );

      final results = await stream.toList();

      expect(results.length, desiredExecutions);
      expect(onCompleteCalled, isTrue);
      expect(onCompleteResult, isA<JNAPSuccess>());
      expect(onCompleteResult, results.last);
    });

    test('test JNAP scheulded onComplete is called on error', () async {
      Jnap.init(
        baseUrl: 'https://192.168.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'd3Jvbmc6d3Jvbmc=', // wrong:wrong
        authType: AuthType.basic,
      );

      bool onCompleteCalled = false;
      Object? onCompleteError;

      final stream = Jnap.instance.scheulded(
        action: GetDevices.instance,
        maxRetry: 1,
        firstDelayInMilliSec: 100,
        retryDelayInMilliSec: 100,
        onComplete: (result, error) {
          onCompleteCalled = true;
          onCompleteError = error;
        },
      );

      await stream.toList().catchError((e) {
        // Catch error to prevent test failure
        return <JNAPResult>[];
      });

      expect(onCompleteCalled, isTrue);
      expect(onCompleteError, isNotNull);
      expect(onCompleteError, isA<MaxRetriesExceededException>());
      final lastResult = (onCompleteError as MaxRetriesExceededException).lastResult;
      expect(lastResult, isA<JNAPError>());
    });
  });

  group('remote JNAP', tags: 'manual', () {
    test('test JNAP send', () async {
      const sessionId = 'FB2246D2-2429-4278-85C9-C5B1CD2E1D73';
      Jnap.init(
        baseUrl: 'https://qa.cloud1.linksyssmartwifi.com',
        path:
            '/cloud/v1/guardians/remote-assistances/sessions/$sessionId/actions/jnap/',
        extraHeaders: {
          'X-Linksys-Client-Type-Id': 'BB426FA7-16A9-5C1C-55AF-63A4167B26AD'
        },
        auth:
            'AGENT0879559D914540F18B4DD61485F6C6410854E66E6F03447481EC27B9525',
        authType: AuthType.token,
      );
      await Jnap.instance.send(action: GetDevices.instance);
    });

    test('test JNAP transaction', () async {
      const sessionId = 'FB2246D2-2429-4278-85C9-C5B1CD2E1D73';
      Jnap.init(
        baseUrl: 'https://qa.cloud1.linksyssmartwifi.com',
        path:
            '/cloud/v1/guardians/remote-assistances/sessions/$sessionId/actions/jnap/',
        extraHeaders: {
          'X-Linksys-Client-Type-Id': 'BB426FA7-16A9-5C1C-55AF-63A4167B26AD'
        },
        auth:
            'AGENT0879559D914540F18B4DD61485F6C6410854E66E6F03447481EC27B9525',
        authType: AuthType.token,
      );
      await Jnap.instance.transaction(
        transactionBuilder: JNAPTransactionBuilder(
          commands: [
            MapEntry(GetDevices.instance, {}),
            MapEntry(GetWANStatus.instance, {}),
          ],
        ),
      );
    });
  });

  group('Jnap unit tests', () {
    setUp(() {
      // Reset config before each test
      Jnap.init(baseUrl: '', path: '', extraHeaders: {});
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
  });
}
