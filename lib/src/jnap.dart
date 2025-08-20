import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:jnap/http.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:jnap/utils.dart';

/// JNAPConfigOverrides is used to override the JNAP configuration

class JNAPConfigOverrides extends Equatable {
  final String? baseUrl;
  final String? path;
  final Map<String, String>? extraHeaders;
  final String? auth;
  final AuthType? authType;
  final int? timeoutMs;
  final int? retries;

  JNAPConfigOverrides({
    this.baseUrl,
    this.path,
    this.extraHeaders,
    this.auth,
    this.authType,
    this.timeoutMs,
    this.retries,
  });

  @override
  List<Object?> get props => [
        baseUrl,
        path,
        extraHeaders,
        auth,
        authType,
        timeoutMs,
        retries,
      ];
}

class Jnap {
  // singleton
  static final Jnap _instance = Jnap._internal();
  Jnap._internal();
  static Jnap get instance {
    return _instance;
  }

  // Initialize Jnap configurations
  static void init({
    required String baseUrl,
    required String path,
    required Map<String, String> extraHeaders,
    String? auth,
    AuthType authType = AuthType.basic,
  }) {
    if (auth != null) {
      _checkBasicAuthEncoded(auth: auth, authType: authType);
      Config.auth = auth;
    }
    // verify baseUrl + path is valid url
    if (baseUrl.isNotEmpty && path.isNotEmpty) {
      try {
        UrlUtils.isValidUrl(baseUrl + path);
      } catch (e) {
        throw Exception('Invalid baseUrl + path');
      }
      Config.baseUrl = baseUrl;
      Config.path = path;
    }

    Config.extraHeaders = extraHeaders;
    Config.authType = authType;
  }

  static void updateUrl({String? baseUrl, String? path}) {
    // verify baseUrl + path is valid url
    final testBaseUrl = baseUrl ?? Config.baseUrl;
    final testPath = path ?? Config.path;
    if (testBaseUrl.isNotEmpty && testPath.isNotEmpty) {
      try {
        UrlUtils.isValidUrl(testBaseUrl + testPath);
      } catch (e) {
        throw Exception('Invalid baseUrl + path');
      }
    }
    if (baseUrl != null) {
      Config.baseUrl = baseUrl;
    }
    if (path != null) {
      Config.path = path;
    }
  }

  static void updateAuth({String? auth, AuthType? authType}) {
    if (auth != null) {
      _checkBasicAuthEncoded(auth: auth, authType: authType ?? Config.authType);
      Config.auth = auth;
    }
    if (authType != null) {
      Config.authType = authType;
    }
  }

  static void _checkBasicAuthEncoded(
      {required String auth, required AuthType authType}) {
    if (authType == AuthType.basic) {
      if (!Base64Utils.isBase64Encoded(auth)) {
        throw Exception('Basic auth should be base64 encoded');
      }
    }
  }

  Stream<JNAPResult> scheulded({
    required JNAPAction action,
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    JNAPConfigOverrides? overrides,
    int retryDelayInMilliSec = 5000,
    int maxRetry = 10,
    int firstDelayInMilliSec = 3000,
    bool Function(JNAPResult)? condition,
    int? requestTimeoutOverride,
    bool auth = false,
  }) {
    final strategy = FixedRetryStrategy(
      maxRetries: maxRetry,
      initialDelay: Duration(milliseconds: firstDelayInMilliSec),
      maxDelay: Duration(milliseconds: retryDelayInMilliSec),
    );

    return strategy.executeStream<JNAPResult>(
      () => send(
        action: action,
        data: data,
        headers: headers,
        overrides: overrides,
      ),
      shouldRetry: (result) => condition?.call(result) ?? true,
      onRetry: (retryAttempt) {
        logger.d('[Jnap.scheulded] retry <${retryAttempt + 1}> times');
      },
      onProgress: (retryAttempt, result, error) {
        logger.d('[Jnap.scheulded] Progess <${retryAttempt + 1}/$maxRetry> times');
      },
    );
  }

  Future<JNAPSuccess> send({
    required JNAPAction action,
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    JNAPConfigOverrides? overrides,
  }) {
    final baseUrl = overrides?.baseUrl ?? Config.baseUrl;
    final path = overrides?.path ?? Config.path;
    final extraHeaders = overrides?.extraHeaders ?? Config.extraHeaders;
    final auth = overrides?.auth ?? Config.auth;
    final authType = overrides?.authType ?? Config.authType;
    final timeoutMs = overrides?.timeoutMs ?? 10000;
    final retries = overrides?.retries ?? 1;

    final HttpClient client = HttpClient();
    final url = baseUrl + path;
    final Map<String, String> header = {
      kJNAPAction: action.command,
      if (authType == AuthType.basic) kJNAPAuthorization: 'Basic $auth',
      if (authType == AuthType.token)
        HttpHeaders.authorizationHeader:
            'LinksysUserAuth session_token="$auth"',
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    }
      ..addAll(headers)
      ..addAll(extraHeaders);
    client.timeoutMs = timeoutMs;
    client.retries = retries;
    return client
        .post(Uri.parse(url), body: jsonEncode(data), headers: header)
        .then((response) {
      return _handleResponse(response) as JNAPSuccess;
    });
  }

  Future<JNAPTransactionSuccessWrap> transaction({
    required JNAPTransactionBuilder transactionBuilder,
    Map<String, String> headers = const {},
    JNAPConfigOverrides? overrides,
  }) {
    final baseUrl = overrides?.baseUrl ?? Config.baseUrl;
    final path = overrides?.path ?? Config.path;
    final extraHeaders = overrides?.extraHeaders ?? Config.extraHeaders;
    final auth = overrides?.auth ?? Config.auth;
    final authType = overrides?.authType ?? Config.authType;
    final timeoutMs = overrides?.timeoutMs ?? 10000;
    final retries = overrides?.retries ?? 1;

    final HttpClient client = HttpClient();
    final url = baseUrl + path;
    final Map<String, String> header = {
      kJNAPAction: Transaction.instance.command,
      if (authType == AuthType.basic) kJNAPAuthorization: 'Basic $auth',
      if (authType == AuthType.token)
        HttpHeaders.authorizationHeader:
            'LinksysUserAuth session_token="$auth"',
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    }
      ..addAll(headers)
      ..addAll(extraHeaders);
    client.timeoutMs = timeoutMs;
    client.retries = retries;
    final payload = transactionBuilder.commands
        .map((entry) => {
              'action':
                  transactionBuilder.overrides[entry.key] ?? entry.key.command,
              'request': entry.value
            })
        .toList();
    return client
        .post(Uri.parse(url), body: json.encode(payload), headers: header)
        .then((response) {
      final result = _handleResponse(response);
      if (result is JNAPTransactionSuccess) {
        return JNAPTransactionSuccessWrap(
            result: result.result,
            data: result.responses
                .mapIndexed(
                    (i, e) => MapEntry(transactionBuilder.commands[i].key, e))
                .toList(),
            sideEffects: result.sideEffects ?? []);
      }
      return JNAPTransactionSuccessWrap(result: result.result, sideEffects: []);
    });
  }

  JNAPResult _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      throw ErrorResponse.fromJson(
          response.statusCode, jsonDecode(response.body));
    }
    return JNAPResult.fromMap(jsonDecode(response.body));
  }
}
