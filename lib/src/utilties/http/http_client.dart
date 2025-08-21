import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:async/async.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jnap/http.dart';
import 'package:jnap/logger.dart';
import 'client/get_client.dart'
    if (dart.library.io) 'client/mobile_client.dart'
    if (dart.library.html) 'client/web_client.dart';
///
/// timeout - will throw Timeout exception on ${timeout} seconds
///
class HttpClient extends http.BaseClient {

  HttpClient({
    BaseClient? client,
    FutureOr<bool> Function(http.BaseResponse) when = _defaultWhen,
    FutureOr<bool> Function(Object, StackTrace) whenError = _defaultWhenError,
    Duration Function(int retryCount) delay = _defaultDelay,
    FutureOr<void> Function(BaseRequest, http.BaseResponse?, int retryCount)?
        onRetry,
  })  : _inner = client ?? getClient(),
        _when = when,
        _whenError = whenError,
        _delay = delay,
        _onRetry = onRetry;

  

  final BaseClient _inner;

  /// The callback that determines whether a request should be retried.
  final FutureOr<bool> Function(http.BaseResponse) _when;

  /// The callback that determines whether a request when an error is thrown.
  final FutureOr<bool> Function(Object, StackTrace) _whenError;

  /// The callback that determines how long to wait before retrying a request.
  final Duration Function(int) _delay;

  /// The callback to call to indicate that a request is being retried.
  final FutureOr<void> Function(BaseRequest, http.BaseResponse?, int)? _onRetry;

  int _timeoutMs = 10000;
  int _retries = 1;

  set timeoutMs(int ms) {
    _timeoutMs = ms;
  }

  set retries(int times) {
    _retries = times;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // @Austin workaround - http plugin will add charset automatically to content-type, to remove it.
    final contentTypeValue = request.headers[HttpHeaders.contentTypeHeader];
    if (contentTypeValue != null) {
      final noCharsetValue = contentTypeValue.split(';')[0];
      request.headers[HttpHeaders.contentTypeHeader] = noCharsetValue;
    }

    final splitter = StreamSplitter(request.finalize());

    var i = 0;
    for (;;) {
      StreamedResponse? response;
      try {
        _logRequest(request, retry: i);
        final copied = _copyRequest(request, splitter.split());

        response = await _inner
            .send(copied)
            .timeout(Duration(milliseconds:   _timeoutMs));
      } catch (error, stackTrace) {
        logger.e('Http Request Error: $error');
        if (i == _retries || !await _whenError(error, stackTrace)) {
          //
          rethrow;
        }
      }

      if (response != null) {
        if (i == _retries || !await _when(response)) return response;

        // Make sure the response stream is listened to so that we don't leave
        // dangling connections.
        _unawaited(response.stream.listen((_) {}).cancel().catchError((_) {}));
      }

      await Future<void>.delayed(_delay(i));
      await _onRetry?.call(request, response, i);
      i++;
    }
  }

  /// Returns a copy of [original] with the given [body].
  StreamedRequest _copyRequest(BaseRequest original, Stream<List<int>> body) {
    final request = StreamedRequest(original.method, original.url)
      ..contentLength = original.contentLength
      ..followRedirects = original.followRedirects
      ..headers.addAll(original.headers)
      ..maxRedirects = original.maxRedirects
      ..persistentConnection = original.persistentConnection;

    body.timeout(Duration(milliseconds: _timeoutMs)).listen(request.sink.add,
        onError: request.sink.addError,
        onDone: request.sink.close,
        cancelOnError: true);
    return request;
  }

  @override
  void close() => _inner.close();

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await super
        .delete(url, headers: headers, body: body, encoding: encoding);
    _logResponse(response);
    return response;
  }

  @override
  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await super
        .patch(url, headers: headers, body: body, encoding: encoding);
    _logResponse(response);
    return response;
  }

  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await super
        .put(url, headers: headers, body: body, encoding: encoding);
    _logResponse(response);
    return response;
  }

  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await super
        .post(url, headers: headers, body: body, encoding: encoding);
    _logResponse(response);
    return response;
  }

  @override
  Future<Response> get(Uri url,
      {Map<String, String>? headers, bool ignoreResponse = false}) async {
    final response = await super.get(url, headers: headers);
    _logResponse(response, ignoreResponse: ignoreResponse);
    return response;
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) async {
    final response = await super.head(url, headers: headers);
    _logResponse(response);
    return response;
  }

  Future<Response> download(Uri url,
      {Map<String, String>? headers}) async {
    final response = await super.get(url, headers: headers);
      _logResponse(response, ignoreResponse: true);
      return response;
  }

  Future<Response> upload(Uri url, List<MultipartFile> multipartList,
      {Map<String, String>? headers, Map<String, String>? fields}) async {
    final request = CustomMultipartRequest("POST", url);
    request.headers.addEntries(headers?.entries ?? []);
    request.fields.addAll(fields ?? {});
    request.files.addAll(multipartList);
    final response = await _sendUnstreamedRequest(request);
    _logResponse(
      response,
    );
    return response;
  }

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<Response> _sendUnstreamedRequest(BaseRequest request) async {
    return Response.fromStream(await send(request));
  }

  _logRequest(http.BaseRequest request, {int retry = 0}) {
    logger.i(
        '\nREQUEST-------------------------------------------------------------------------\n'
        '${retry == 0 ? '' : 'RETRY: $retry\n'}'
        'URL: ${request.url}, METHOD: ${request.method}\n'
        'HEADERS: ${request.headers}\n'
        '${request is http.Request ? 'BODY: ${request.body}' : request is http.MultipartRequest ? 'Content-Length: ${request.contentLength}' : ''}\n'
        '---------------------------------------------------------------------REQUEST END\n');
  }

  _logResponse(http.Response response, {bool ignoreResponse = false}) {
    final request = response.request;
    String responseBody = '';
    try {
      responseBody = utf8.decode(response.bodyBytes);
    } catch (e) {
      responseBody = '';
    }
    if (request != null) {
      logger.i(
          '\nRESPONSE------------------------------------------------------------------------\n'
          'URL: ${request.url}, METHOD: ${request.method}\n'
          'REQUEST HEADERS: ${request.headers}\n'
          'RESPONSE HEADERS: ${response.headers}\n'
          'RESPONSE: ${response.statusCode}, ${ignoreResponse ? '' : responseBody}\n'
          '--------------------------------------------------------------------RESPONSE END\n');
    }
  }
}

bool _defaultWhen(http.BaseResponse response) {
  try {
    if (response.statusCode == 503) {
      return true;
    }
    if (response.statusCode == 404) {
      return true;
    }
    if (response.statusCode == 401) {
      return true;
    }
    return false;
  } catch (_) {
    return false;
  }
}

bool _defaultWhenError(Object error, StackTrace stackTrace) =>
    error is TimeoutException;

Duration _defaultDelay(int retryCount) =>
    const Duration(milliseconds: 500) * math.pow(1.5, retryCount);

void _unawaited(Future<void>? f) {}
