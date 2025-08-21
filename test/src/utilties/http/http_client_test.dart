import 'dart:async';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:jnap/src/utilties/http/http_client.dart';

void main() {
  group('HttpClient', () {
    test('successful request', () async {
      final mockClient = MockClient((request) async {
        return Response('ok', 200);
      });
      final httpClient = HttpClient(client: mockClient);
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 200);
      expect(response.body, 'ok');
    });

    test('retry on 503', () async {
      var i = 0;
      final mockClient = MockClient((request) async {
        i++;
        if (i == 1) {
          return Response('error', 503);
        }
        return Response('ok', 200);
      });
      final httpClient = HttpClient(client: mockClient);
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 200);
      expect(response.body, 'ok');
      expect(i, 2);
    });

    test('retry on 404', () async {
      var i = 0;
      final mockClient = MockClient((request) async {
        i++;
        if (i == 1) {
          return Response('error', 404);
        }
        return Response('ok', 200);
      });
      final httpClient = HttpClient(client: mockClient);
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 200);
      expect(response.body, 'ok');
      expect(i, 2);
    });

    test('retry on 401', () async {
      var i = 0;
      final mockClient = MockClient((request) async {
        i++;
        if (i == 1) {
          return Response('error', 401);
        }
        return Response('ok', 200);
      });
      final httpClient = HttpClient(client: mockClient);
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 200);
      expect(response.body, 'ok');
      expect(i, 2);
    });

    test('retry on TimeoutException', () async {
      var i = 0;
      final mockClient = MockClient((request) async {
        i++;
        if (i == 1) {
          throw TimeoutException('timeout');
        }
        return Response('ok', 200);
      });
      final httpClient = HttpClient(client: mockClient);
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 200);
      expect(response.body, 'ok');
      expect(i, 2);
    });

    test('max retries exceeded', () async {
      var i = 0;
      final mockClient = MockClient((request) async {
        i++;
        return Response('error', 503);
      });
      final httpClient = HttpClient(client: mockClient);
      httpClient.retries = 2;
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 503);
      expect(i, 3);
    });

    test('no retry on other status codes', () async {
      var i = 0;
      final mockClient = MockClient((request) async {
        i++;
        return Response('error', 500);
      });
      final httpClient = HttpClient(client: mockClient);
      final response = await httpClient.get(Uri.parse('http://example.com'));
      expect(response.statusCode, 500);
      expect(i, 1);
    });
  });
}
