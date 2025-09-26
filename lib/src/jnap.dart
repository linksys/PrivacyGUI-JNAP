import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/utilties/extension.dart';
import 'package:jnap/src/utilties/http/http_client.dart';
import 'package:jnap/src/utilties/retry_strategy/retry.dart';
import 'package:jnap/utils.dart';
import 'package:meta/meta.dart'; // Added import for @visibleForTesting

/// JNAPConfigOverrides is used to override the JNAP configuration
class JNAPConfigOverrides extends Equatable {
  final String? baseUrl;
  final String? path;
  final Map<String, String>? extraHeaders;
  final String? auth;
  final AuthType? authType;
  final int? timeoutMs;
  final int? retries;
  final bool forceRemote;
  final bool cached;

  JNAPConfigOverrides({
    this.baseUrl,
    this.path,
    this.extraHeaders,
    this.auth,
    this.authType,
    this.timeoutMs,
    this.retries,
    this.forceRemote = false,
    this.cached = true,
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
        forceRemote,
        cached,
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
        final valid = UrlUtils.isValidUrl(baseUrl + path);
        if (!valid) {
          throw Exception('Invalid baseUrl + path');
        }
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
        final isValid = UrlUtils.isValidUrl(testBaseUrl + testPath);
        if (!isValid) {
          throw Exception('Invalid baseUrl + path');
        }
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
      if (!auth.isBase64()) {
        throw Exception('Basic auth should be base64 encoded');
      }
    }
  }

  Stream<JNAPResult> scheduled({
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
    void Function(JNAPResult? result, Object? error)? onComplete,
    HttpClient? httpClient,
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
        httpClient: httpClient,
      ),
      shouldRetry: (result) => condition?.call(result) ?? true,
      onRetry: (retryAttempt) {
        logger.d('[Jnap.scheulded] retry <${retryAttempt + 1}> times');
      },
      onProgress: (retryAttempt, result, error) {
        logger.d(
            '[Jnap.scheulded] Progess <${retryAttempt + 1}/$maxRetry> times');
      },
      onComplete: (result, error) {
        logger.d('[Jnap.scheulded] onComplete');
        onComplete?.call(result, error);
      },
    );
  }

  Future<JNAPSuccess> send({
    required JNAPAction action,
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    JNAPConfigOverrides? overrides,
    JNAPSideEffectOverrides? sideEffectOverrides,
    HttpClient? httpClient,
  }) {
    final command = JNAPCommand(
      action: action.command,
      data: jsonEncode(data),
      headers: headers,
      overrides: overrides,
      httpClient: httpClient,
    );
    final sideEffectHandler = SideEffectHandler(jnap: this);
    return CommandQueue().enqueue(command).then((result) {
      return sideEffectHandler.handleSideEffect(result,
          overrides: sideEffectOverrides);
    }).then((result) {
      if (result is JNAPSuccess) {
        return result;
      }
      throw result;
    });
  }

  Future<JNAPTransactionSuccessWrap> transaction({
    required JNAPTransactionBuilder transactionBuilder,
    Map<String, String> headers = const {},
    JNAPConfigOverrides? overrides,
    JNAPSideEffectOverrides? sideEffectOverrides,
    HttpClient? httpClient,
  }) {
    final payload = transactionBuilder.commands
        .map((entry) => {
              'action':
                  transactionBuilder.overrides[entry.key] ?? entry.key.command,
              'request': entry.value
            })
        .toList();

    final command = JNAPCommand(
      action: Transaction.instance.command,
      headers: headers,
      data: jsonEncode(payload),
      overrides: overrides,
      httpClient: httpClient,
    );
    final sideEffectHandler = SideEffectHandler(jnap: this);
    return CommandQueue().enqueue(command).then((result) {
      return sideEffectHandler.handleSideEffect(result,
          overrides: sideEffectOverrides);
    }).then((result) {
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
}

class JNAPCommand {
  final Completer<JNAPResult> _completer = Completer();

  final String action;
  final String? data;
  final Map<String, String> headers;
  final JNAPConfigOverrides? overrides;
  final HttpClient _httpClient;
  final DataCacheManager _cacheManager;

  JNAPCommand({
    required this.action,
    this.data,
    this.headers = const {},
    this.overrides,
    HttpClient? httpClient,
    DataCacheManager? cacheManager,
  })  : _httpClient = httpClient ?? HttpClient(),
        _cacheManager = cacheManager ?? DataCacheManager();

  Future<JNAPResult> execute() async {
    final cachedResult = _checkCache();
    if (cachedResult != null) {
      logger.d('[JNAPCommand] Response from cache for action: $action');
      return cachedResult;
    }

    final baseUrl = overrides?.baseUrl ?? Config.baseUrl;
    final path = overrides?.path ?? Config.path;
    final extraHeaders = overrides?.extraHeaders ?? Config.extraHeaders;
    final auth = overrides?.auth ?? Config.auth;
    final authType = overrides?.authType ?? Config.authType;
    final timeoutMs = overrides?.timeoutMs ?? 10000;
    final retries = overrides?.retries ?? 1;

    final url = baseUrl + path;
    final Map<String, String> header = {
      kJNAPAction: action,
      if (auth.isNotEmpty)
        authType == AuthType.basic ? 'X-Jnap-Authorization' : HttpHeaders.authorizationHeader:
            authType == AuthType.basic ? 'Basic $auth' : 'Bearer $auth',
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    }
      ..addAll(headers)
      ..addAll(extraHeaders);
    _httpClient.timeoutMs = timeoutMs;
    _httpClient.retries = retries;
    return _httpClient
        .post(Uri.parse(url), body: data, headers: header)
        .then((response) async {
      final result = _handleResponse(response);
      logger.d(
          '[JNAPCommand] Response from remote for action: $action, cached: ${overrides?.cached ?? true}');
      // Update to cache
      if (overrides?.cached ?? true) {
        logger.d(
            '[JNAPCommand] save JNAP<${action}> data to <${_cacheManager.lastSerialNumber}>');
        await _cacheManager.handleJNAPCached(result.toMap(), action);
      }
      return result;
    });
  }

  bool isComplete() => _completer.isCompleted;

  complete(JNAPResult result) => _completer.complete(result);

  completeError(Object? error, StackTrace stackTrace) =>
      _completer.completeError(error ?? UnsupportedError, stackTrace);

  Future<JNAPResult> wait() => _completer.future;

  bool isTransaction() => action == Transaction.instance.command;

  JNAPResult? _checkCache() {
    var actions = [action];
    if (isTransaction()) {
      final jsonData = List<Map<String, dynamic>>.from(json.decode(data!));
      actions = jsonData.map((e) => e['action'] as String? ?? '').toList()
        ..removeWhere((e) => e.isEmpty);
    }

    if (_checkCacheValidation(actions)) {
      if (isTransaction()) {
        final results = [];
        for (var action in actions) {
          results.add(_cacheManager.data[action]["data"]);
        }
        final dataMap = {
          keyJnapResult: jnapResultOk,
          keyJnapResponses: results
        };
        logger.d(
            '[CacheManager] responsed with local cache transaction data: ${_cacheManager.lastSerialNumber}dataMap');
        final result = JNAPResult.fromMap(dataMap);
        if (result is JNAPTransactionSuccess) {
          return result;
        } else {
          throw (result as JNAPError);
        }
      } else {
        logger.d('[CacheManager] responsed with local cache data: $action');
        final result = JNAPResult.fromMap(_cacheManager.data[action]["data"]);
        if (result is JNAPSuccess) {
          return result;
        }
        throw result;
      }
    }
    return null;
  }

  /// Check if the cache is valid
  ///
  /// return true if the cache is valid, false otherwise
  bool _checkCacheValidation(List<String> actions) {
    final result = !(overrides?.forceRemote ?? false) &&
        !_checkNonExistActionAndExpiration(actions);
    return result;
  }

  /// Check if the cache is valid
  ///
  /// return true if the cache is invalid, false otherwise
  bool _checkNonExistActionAndExpiration(List<String> actions) {
    final result =
        actions.any((element) => !_cacheManager.checkCacheDataValid(element));
    return result;
  }

  JNAPResult _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      throw ErrorResponse.fromJson(
          response.statusCode, jsonDecode(response.body));
    }
    return JNAPResult.fromMap(jsonDecode(response.body));
  }
}

class CommandQueue {
  static const int maxEmptyRetry = 60;
  static CommandQueue? _singleton;
  final Queue<JNAPCommand> _queue = Queue();
  @visibleForTesting
  Queue<JNAPCommand> get queue => _queue;
  bool isPaused = false;
  final dataCacheManger = DataCacheManager();

  @visibleForTesting
  static void reset() {
    _singleton = null;
  }

  set pause(bool pause) {
    logger.d('Command Queue:: pause: $isPaused');
    isPaused = pause;
  }

  Timer? timer;

  int emptyRetry = 0;

  factory CommandQueue() {
    _singleton ??= CommandQueue._();
    return _singleton!;
  }

  CommandQueue._();

  _consumeCommand(Timer timer) {
    if (isPaused) {
      return;
    }
    // Consume the command
    if (_queue.isEmpty) {
      emptyRetry++;
      _stopConsume();
      return;
    }

    final command = _queue.removeFirst();
    logger.d(
        'Command Queue <${_queue.length}>:: handle command: ${command.runtimeType}, ${command.action}');
    command.execute().then((value) => command.complete(value)).onError(
        (error, stackTrace) => command.completeError(error, stackTrace));
    emptyRetry = 0;
  }

  Future<JNAPResult> enqueue(JNAPCommand command) {
    if (!(timer?.isActive ?? false)) {
      _startConsume();
    }
    _queue.add(command);
    logger.d(
        'Command Queue:: enqueue command ${command.runtimeType}, ${command.action}');
    return command.wait();
  }

  _startConsume() {
    if (timer?.isActive ?? false) {
      return;
    }
    emptyRetry = 0;
    timer = Timer.periodic(const Duration(milliseconds: 50), _consumeCommand);
    logger.d('Command Queue:: start to consume commands!');
  }

  _stopConsume() {
    if ((timer?.isActive ?? false) && emptyRetry >= maxEmptyRetry) {
      logger.d('Command Queue:: exceed to empty retry, stop!');
      timer?.cancel();
      timer = null;
    }
  }
}
