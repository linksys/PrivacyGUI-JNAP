import 'package:test/test.dart';
import 'package:jnap/src/config.dart';

void main() {
  group('Config', () {
    test('has correct default values', () {
      expect(Config.isRelease, isFalse);
      expect(Config.baseUrl, 'localhost');
      expect(Config.path, '');
      expect(Config.extraHeaders, {});
      expect(Config.auth, '');
      expect(Config.authType, AuthType.basic);
    });

    test('can be updated', () {
      Config.isRelease = true;
      Config.baseUrl = 'example.com';
      Config.path = '/api';
      Config.extraHeaders = {'X-Test': 'true'};
      Config.auth = 'new_auth';
      Config.authType = AuthType.token;

      expect(Config.isRelease, isTrue);
      expect(Config.baseUrl, 'example.com');
      expect(Config.path, '/api');
      expect(Config.extraHeaders, {'X-Test': 'true'});
      expect(Config.auth, 'new_auth');
      expect(Config.authType, AuthType.token);
    });
  });
}
