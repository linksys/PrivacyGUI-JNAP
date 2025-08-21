
import 'package:jnap/src/modules/product/action.dart';
import 'package:jnap/src/modules/product/service.dart';
import 'package:test/test.dart';

void main() {
  group('Product actions', () {
    test('GetSoftSKUSettings has correct properties', () {
      final action = GetSoftSKUSettings.instance;
      expect(action.name, 'GetSoftSKUSettings');
      expect(action.service, productService);
      expect(action.command, 'http://linksys.com/jnap/product/GetSoftSKUSettings');
    });
  });
}
