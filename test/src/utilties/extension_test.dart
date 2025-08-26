import 'package:test/test.dart';
import 'package:jnap/src/utilties/extension.dart';

void main() {
  group('MapExt', () {
    final map = {
      'a': {
        'b': {
          'c': 123,
        },
      },
      'd': 'hello',
      'e': [1, 2, 3],
    };

    test('getValueByPath should return correct value for nested map', () {
      expect(map.getValueByPath('a.b.c'), 123);
    });

    test('getValueByPath should return correct value for direct path', () {
      expect(map.getValueByPath('d'), 'hello');
    });

    test('getValueByPath should return null for non-existent path', () {
      expect(map.getValueByPath('a.x.c'), isNull);
    });

    test('getValueByPath should return null for path through non-map', () {
      expect(map.getValueByPath('d.x'), isNull);
    });

    test('getValueByPath should return list', () {
      expect(map.getValueByPath('e'), [1, 2, 3]);
    });
  });

  group('StringExt', () {
    test('capitalize should capitalize the first letter', () {
      expect('word'.capitalize(), 'Word');
      expect('Word'.capitalize(), 'Word');
      expect('WORD'.capitalize(), 'WORD');
      expect(''.capitalize(), '');
      expect('1word'.capitalize(), '1word');
    });

    test('camelCapitalize should capitalize words in camel case', () {
      expect('hello world'.camelCapitalize(), 'Hello World');
      expect('hello   world'.camelCapitalize(), 'Hello   World');
    });

    test('capitalizeWords should capitalize all words', () {
      expect('hello world'.capitalizeWords(), 'Hello World');
    });

    test('capitalizeSentence should capitalize sentences', () {
      expect('hello. world'.capitalizeSentence(), 'Hello. World');
    });

    test('kebab should convert to kebab case', () {
      expect('helloWorld'.kebab(), 'hello-world');
      expect('Hello World'.kebab(), 'hello-world');
      expect('helloWorld123'.kebab(), 'hello-world123');
    });

    test('isJsonFormat should check for valid JSON', () {
      expect('{"key": "value"}'.isJsonFormat(), isTrue);
      expect('not json'.isJsonFormat(), isFalse);
      expect('''{"key": 'value'}'''.isJsonFormat(), isFalse); // single quotes are not valid json
    });

    test('toMd5 should return correct MD5 hash', () {
      expect('hello'.toMd5(), '5d41402abc4b2a76b9719d911017c592');
    });

    test('compareToVersion should compare version strings', () {
      expect('1.0.0'.compareToVersion('1.0.1'), -1);
      expect('1.0.1'.compareToVersion('1.0.0'), 1);
      expect('1.0.0'.compareToVersion('1.0.0'), 0);
      expect('1.10.0'.compareToVersion('1.2.0'), 1);
      expect('2.0.0'.compareToVersion('1.9.9'), 1);
      expect('1.0'.compareToVersion('1.0.0'), -1);
    });

    test('base64Encode should encode to base64', () {
      expect('hello'.base64Encode(), 'aGVsbG8=');
    });

    test('base64Decode should decode from base64', () {
      expect('aGVsbG8='.base64Decode(), 'hello');
    });

    test('isBase64 should check for valid base64', () {
      expect('aGVsbG8='.isBase64(), isTrue);
      expect('not base64'.isBase64(), isFalse);
      expect('aGVsbG8'.isBase64(), isTrue); // without padding
    });
  });
}