import 'package:test/test.dart';
import 'package:jnap/src/utilties/http/client/mobile_client.dart';
import 'package:http/io_client.dart';

void main() {
  group('Mobile Client', () {
    test('getClient returns an IOClient', () {
      final client = getClient();
      expect(client, isA<IOClient>());
    });
  });
}
