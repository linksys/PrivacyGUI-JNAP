import 'dart:convert';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:jnap/src/utilties/http/custom_multipart_request.dart';

void main() {
  group('CustomMultipartRequest', () {
    test('constructor sets method and url', () {
      final uri = Uri.parse('http://example.com');
      final request = CustomMultipartRequest('POST', uri);
      expect(request.method, 'POST');
      expect(request.url, uri);
    });

    test('contentLength increases when a field is added', () {
      final uri = Uri.parse('http://example.com');
      final request = CustomMultipartRequest('POST', uri);
      final initialLength = request.contentLength;
      request.fields['field1'] = 'value1';
      expect(request.contentLength, greaterThan(initialLength));
    });

    test('contentLength increases when a file is added', () {
      final uri = Uri.parse('http://example.com');
      final request = CustomMultipartRequest('POST', uri);
      final initialLength = request.contentLength;
      request.files.add(MultipartFile.fromString('file1', 'content1'));
      expect(request.contentLength, greaterThan(initialLength));
    });

    test('setting contentLength throws an error', () {
      final uri = Uri.parse('http://example.com');
      final request = CustomMultipartRequest('POST', uri);
      expect(() => request.contentLength = 100, throwsUnsupportedError);
    });

    test('finalize produces a valid multipart request', () async {
      final uri = Uri.parse('http://example.com');
      final request = CustomMultipartRequest('POST', uri);
      request.fields['field1'] = 'value1';
      request.files.add(MultipartFile.fromString('file1', 'content1', filename: 'file1.txt'));

      final stream = request.finalize();
      final body = await stream.toBytes();
      final bodyString = utf8.decode(body);

      expect(request.headers['content-type'], startsWith('multipart/form-data; boundary='));

      final boundary = request.headers['content-type']!.split('boundary=')[1];

      final expectedBody = '--$boundary\r\n' 
          'Content-Disposition: form-data; name="field1"\r\n' 
          '\r\n' 
          'value1\r\n' 
          '--$boundary\r\n' 
          'content-type: text/plain; charset=utf-8\r\n' 
          'Content-Disposition: form-data; name="file1"; filename="file1.txt"\r\n' 
          '\r\n' 
          'content1\r\n' 
          '--$boundary--\r\n';

      expect(bodyString.replaceAll(boundary, 'BOUNDARY'), expectedBody.replaceAll(boundary, 'BOUNDARY'));
    });
  });
}
