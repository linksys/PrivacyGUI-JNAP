import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:jnap/http.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/utils.dart';

class Jnap {
  // singleton
  static final Jnap _instance = Jnap._internal();
  Jnap._internal();
  static Jnap get instance {
    // check if init is called, auth should have been set
    if (Config.auth.isEmpty) {
      throw Exception('Jnap is not initialized');
    }
    return _instance;
  }

  // Initialize Jnap configurations
  static void init({
    required String baseUrl,
    required String path,
    required Map<String, String> extraHeaders,
    required String auth,
    AuthType authType = AuthType.basic,
  }) {
    _checkBasicAuthEncoded(auth: auth, authType: authType);
    // verify baseUrl + path is valid url
    if (baseUrl.isNotEmpty && path.isNotEmpty) {
      try {
        UrlUtils.isValidUrl(baseUrl + path);
      } catch (e) {
        throw Exception('Invalid baseUrl + path');
      }
    }
    Config.baseUrl = baseUrl;
    Config.path = path;
    Config.extraHeaders = extraHeaders;
    Config.auth = auth;
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

  Future<JNAPSuccess> send({
    required JNAPAction action,
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    int timeoutMs = 10000,
    int retries = 1,
  }) {
    final HttpClient client = HttpClient();
    final url = Config.baseUrl + Config.path;
    final Map<String, String> header = {
      kJNAPAction: action.command,
      if (Config.authType == AuthType.basic)
        kJNAPAuthorization: 'Basic ${Config.auth}',
      if (Config.authType == AuthType.token)
        HttpHeaders.authorizationHeader:
            'LinksysUserAuth session_token="${Config.auth}"',
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    }
      ..addAll(headers)
      ..addAll(Config.extraHeaders);
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
    int timeoutMs = 10000,
    int retries = 1,
  }) {
    final HttpClient client = HttpClient();
    final url = Config.baseUrl + Config.path;
    final Map<String, String> header = {
      kJNAPAction: Transaction.instance.command,
      if (Config.authType == AuthType.basic)
        kJNAPAuthorization: 'Basic ${Config.auth}',
      if (Config.authType == AuthType.token)
        HttpHeaders.authorizationHeader:
            'LinksysUserAuth session_token="${Config.auth}"',
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    }
      ..addAll(headers)
      ..addAll(Config.extraHeaders);
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
