import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math; // Import math

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jnap/src/utilties/http/http_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:http_parser/http_parser.dart'; // Import for MediaType

// Mock classes
class MockBaseClient extends Mock implements http.BaseClient {}

class MockStreamedResponse extends Mock implements http.StreamedResponse {}

class MockResponse extends Mock implements http.Response {}

class MockBaseRequest extends Mock implements http.BaseRequest {}

class MockMultipartFile extends Mock implements http.MultipartFile {}

// Fallback values for mocktail
class FakeUri extends Fake implements Uri {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());
    registerFallbackValue(FakeBaseRequest());
  });

  group('HttpClient', () {
    late MockBaseClient mockBaseClient;
    late HttpClient httpClient;
    late MockStreamedResponse mockStreamedResponse;
    late MockResponse mockResponse;
    late MockMultipartFile mockMultipartFile;

    setUp(() {
      mockBaseClient = MockBaseClient();
      mockStreamedResponse = MockStreamedResponse();
      mockResponse = MockResponse();
      mockMultipartFile = MockMultipartFile();
      httpClient = HttpClient(client: mockBaseClient);

      // Provide default values for mock getters
      when(() => mockStreamedResponse.headers).thenReturn({});
      when(() => mockStreamedResponse.request).thenReturn(MockBaseRequest());
      when(() => mockStreamedResponse.isRedirect).thenReturn(false);
      when(() => mockStreamedResponse.persistentConnection).thenReturn(true);
      when(() => mockStreamedResponse.reasonPhrase).thenReturn('OK');
      when(() => mockStreamedResponse.contentLength).thenReturn(0);

      when(() => mockResponse.headers).thenReturn({});
      when(() => mockResponse.request).thenReturn(MockBaseRequest());
      when(() => mockResponse.isRedirect).thenReturn(false);
      when(() => mockResponse.persistentConnection).thenReturn(true);
      when(() => mockResponse.reasonPhrase).thenReturn('OK');
      when(() => mockResponse.contentLength).thenReturn(0);

      when(() => mockMultipartFile.field).thenReturn('file');
      when(() => mockMultipartFile.filename).thenReturn('test.txt');
    });

    test('should send a request successfully', () async {
      final request = http.Request('GET', Uri.parse('http://example.com'));
      when(() => mockStreamedResponse.statusCode).thenReturn(200);
      when(() => mockStreamedResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('test')])));
      when(() => mockBaseClient.send(any()))
          .thenAnswer((_) async => mockStreamedResponse);

      final response = await httpClient.send(request);

      expect(response.statusCode, 200);
      verify(() => mockBaseClient.send(any())).called(1);
    });

    test('should modify Content-Type header by removing charset', () async {
      final request = http.Request('POST', Uri.parse('http://example.com'));
      request.headers[HttpHeaders.contentTypeHeader] =
          'application/json; charset=utf-8';

      when(() => mockStreamedResponse.statusCode).thenReturn(200);
      when(() => mockStreamedResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('test')])));
      when(() => mockBaseClient.send(any()))
          .thenAnswer((_) async => mockStreamedResponse);

      await httpClient.send(request);

      final captured =
          verify(() => mockBaseClient.send(captureAny())).captured.single;
      expect(
          (captured as http.BaseRequest)
              .headers[HttpHeaders.contentTypeHeader],
          'application/json');
    });

    test('should retry on specific status codes (e.g., 503)', () async {
      httpClient = HttpClient(
        client: mockBaseClient,
        when: (response) => response.statusCode == 503,
        delay: (_) => Duration.zero,
      );
      httpClient.retries = 1;

      final request = http.Request('GET', Uri.parse('http://example.com'));
      final firstResponse = MockStreamedResponse();
      when(() => firstResponse.statusCode).thenReturn(503);
      when(() => firstResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('error')])));

      final secondResponse = MockStreamedResponse();
      when(() => secondResponse.statusCode).thenReturn(200);
      when(() => secondResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('success')])));

      var callCount = 0;
      when(() => mockBaseClient.send(any())).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return firstResponse;
        }
        return secondResponse;
      });

      final response = await httpClient.send(request);

      expect(response.statusCode, 200);
      verify(() => mockBaseClient.send(any())).called(2);
    });

    test('should retry on TimeoutException', () async {
      httpClient = HttpClient(
        client: mockBaseClient,
        whenError: (error, stackTrace) => error is TimeoutException,
        delay: (_) => Duration.zero,
      );
      httpClient.retries = 1;

      final request = http.Request('GET', Uri.parse('http://example.com'));
      final successResponse = MockStreamedResponse();
      when(() => successResponse.statusCode).thenReturn(200);
      when(() => successResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('success')])));

      var callCount = 0;
      when(() => mockBaseClient.send(any())).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw TimeoutException('Request timed out');
        }
        return successResponse;
      });

      final response = await httpClient.send(request);
      expect(response.statusCode, 200);
      verify(() => mockBaseClient.send(any())).called(2);
    });

    test('should not retry if retry limit is reached', () async {
      httpClient = HttpClient(
        client: mockBaseClient,
        when: (response) => response.statusCode == 503,
      );
      httpClient.retries = 0;

      final request = http.Request('GET', Uri.parse('http://example.com'));
      final firstResponse = MockStreamedResponse();
      when(() => firstResponse.statusCode).thenReturn(503);
      when(() => firstResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('error')])));

      when(() => mockBaseClient.send(any()))
          .thenAnswer((_) async => firstResponse);

      final response = await httpClient.send(request);

      expect(response.statusCode, 503);
      verify(() => mockBaseClient.send(any())).called(1);
    });

    test('should call onRetry callback', () async {
      int onRetryCalledCount = 0;
      int? capturedRetryCount;

      httpClient = HttpClient(
        client: mockBaseClient,
        when: (response) => response.statusCode == 503,
        onRetry: (request, response, count) {
          onRetryCalledCount++;
          capturedRetryCount = count;
        },
        delay: (_) => Duration.zero,
      );
      httpClient.retries = 1;

      final request = http.Request('GET', Uri.parse('http://example.com'));
      final firstResponse = MockStreamedResponse();
      when(() => firstResponse.statusCode).thenReturn(503);
      when(() => firstResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('error')])));

      final secondResponse = MockStreamedResponse();
      when(() => secondResponse.statusCode).thenReturn(200);
      when(() => secondResponse.stream)
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('success')])));

      var callCount = 0;
      when(() => mockBaseClient.send(any())).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return firstResponse;
        }
        return secondResponse;
      });

      await httpClient.send(request);

      expect(onRetryCalledCount, 1);
      expect(capturedRetryCount, 0);
      verify(() => mockBaseClient.send(any())).called(2);
    });

    test('should rethrow error if not retriable', () async {
      httpClient = HttpClient(
        client: mockBaseClient,
        whenError: (error, stackTrace) => false,
      );
      httpClient.retries = 1;

      final request = http.Request('GET', Uri.parse('http://example.com'));
      when(() => mockBaseClient.send(any()))
          .thenThrow(SocketException('No internet'));

      expect(() => httpClient.send(request), throwsA(isA<SocketException>()));
      verify(() => mockBaseClient.send(any())).called(1);
    });

    test(
        'should handle different HTTP methods (get, post, put, delete, patch, head)',
        () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.request)
          .thenReturn(http.Request('GET', Uri.parse('http://example.com')));

      when(() => mockBaseClient.send(any())).thenAnswer((_) async {
        final streamedResponse = MockStreamedResponse();
        when(() => streamedResponse.statusCode).thenReturn(200);
        when(() => streamedResponse.stream)
            .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('body')])));
        when(() => streamedResponse.request)
            .thenReturn(http.Request('GET', Uri.parse('http://example.com')));
        when(() => streamedResponse.headers).thenReturn({});
        when(() => streamedResponse.isRedirect).thenReturn(false);
        when(() => streamedResponse.persistentConnection).thenReturn(true);
        when(() => streamedResponse.reasonPhrase).thenReturn('OK');
        when(() => streamedResponse.contentLength).thenReturn(4);
        return streamedResponse;
      });

      await httpClient.get(Uri.parse('http://example.com'), headers: {});
      await httpClient.post(Uri.parse('http://example.com'));
      await httpClient.put(Uri.parse('http://example.com'));
      await httpClient.delete(Uri.parse('http://example.com'));
      await httpClient.patch(Uri.parse('http://example.com'));
      await httpClient.head(Uri.parse('http://example.com'));

      verify(() => mockBaseClient.send(any())).called(6);
    });

    test('should handle download method', () async {
      when(() => mockStreamedResponse.statusCode).thenReturn(200);
      when(() => mockStreamedResponse.stream).thenAnswer(
          (_) => ByteStream(Stream.fromIterable([utf8.encode('file content')])));
      when(() => mockStreamedResponse.request)
          .thenReturn(http.Request('GET', Uri.parse('http://example.com')));
      when(() => mockBaseClient.send(any()))
          .thenAnswer((_) async => mockStreamedResponse);

      final response =
          await httpClient.download(Uri.parse('http://example.com/file'));

      expect(response.statusCode, 200);
      expect(response.bodyBytes, utf8.encode('file content'));
      verify(() => mockBaseClient.send(any())).called(1);
    });

    test('should handle upload method with correct headers', () async {
      when(() => mockStreamedResponse.statusCode).thenReturn(200);
      when(() => mockStreamedResponse.stream).thenAnswer(
          (_) => ByteStream(Stream.fromIterable([utf8.encode('upload success')])));
      when(() => mockStreamedResponse.request)
          .thenReturn(http.Request('POST', Uri.parse('http://example.com/upload')));
      when(() => mockBaseClient.send(any()))
          .thenAnswer((_) async => mockStreamedResponse);

      when(() => mockMultipartFile.filename).thenReturn('test.txt');
      when(() => mockMultipartFile.length).thenReturn(10);
      when(() => mockMultipartFile.contentType)
          .thenReturn(MediaType('text', 'plain'));
      when(() => mockMultipartFile.finalize())
          .thenAnswer((_) => ByteStream(Stream.fromIterable([utf8.encode('test content')])));

      final response = await httpClient.upload(
        Uri.parse('http://example.com/upload'),
        [mockMultipartFile],
        headers: {'Authorization': 'Bearer token'},
        fields: {'key': 'value'},
      );

      expect(response.statusCode, 200);
      expect(response.body, 'upload success');

      final captured =
          verify(() => mockBaseClient.send(captureAny())).captured.single
              as http.StreamedRequest;
      expect(captured.headers['Authorization'], 'Bearer token');
      expect(captured.headers['content-type'],
          startsWith('multipart/form-data; boundary='));
    });

    test('should close the inner client', () {
      when(() => mockBaseClient.close()).thenAnswer((_) {});
      httpClient.close();
      verify(() => mockBaseClient.close()).called(1);
    });

    test('timeoutMs getter and setter should work', () {
      httpClient.timeoutMs = 5000;
      expect(httpClient.timeoutMs, 5000);
    });

    test('retries getter and setter should work', () {
      httpClient.retries = 3;
      expect(httpClient.retries, 3);
    });
  });

  group('Default Callbacks', () {
    late MockStreamedResponse mockResponse;

    setUp(() {
      mockResponse = MockStreamedResponse();
    });

    test('_defaultWhen should return true for 503, 404, 401 status codes', () {
      when(() => mockResponse.statusCode).thenReturn(503);
      expect(_defaultWhen(mockResponse), isTrue);

      when(() => mockResponse.statusCode).thenReturn(404);
      expect(_defaultWhen(mockResponse), isTrue);

      when(() => mockResponse.statusCode).thenReturn(401);
      expect(_defaultWhen(mockResponse), isTrue);
    });

    test('_defaultWhen should return false for other status codes', () {
      when(() => mockResponse.statusCode).thenReturn(200);
      expect(_defaultWhen(mockResponse), isFalse);

      when(() => mockResponse.statusCode).thenReturn(500);
      expect(_defaultWhen(mockResponse), isFalse);
    });

    test('_defaultWhenError should return true for TimeoutException', () {
      expect(
          _defaultWhenError(TimeoutException(''), StackTrace.current), isTrue);
    });

    test('_defaultWhenError should return false for other exceptions', () {
      expect(
          _defaultWhenError(SocketException(''), StackTrace.current), isFalse);
      expect(_defaultWhenError(Exception(''), StackTrace.current), isFalse);
    });

    test('_defaultDelay should calculate delay correctly', () {
      expect(_defaultDelay(0), const Duration(milliseconds: 500));
      expect(_defaultDelay(1), const Duration(milliseconds: 750)); // 500 * 1.5
      expect(_defaultDelay(2),
          const Duration(milliseconds: 1125)); // 500 * 1.5 * 1.5
    });
  });
}

// Helper function to access private _defaultWhen, _defaultWhenError, _defaultDelay
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