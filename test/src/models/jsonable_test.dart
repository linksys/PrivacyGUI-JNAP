import 'package:jnap/src/models/jsonable.dart';
import 'dart:convert';
import 'package:test/test.dart';

class TestJsonable extends Jsonable {
  final String name;
  final int value;

  const TestJsonable({required this.name, required this.value});

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory TestJsonable.fromMap(Map<String, dynamic> map) {
    return TestJsonable(
      name: map['name'] as String,
      value: map['value'] as int,
    );
  }

  factory TestJsonable.fromJson(String json) => TestJsonable.fromMap(jsonDecode(json));

  @override
  TestJsonable copyWith({
    String? name,
    int? value,
  }) {
    return TestJsonable(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [name, value];
}

void main() {
  group('Jsonable', () {
    const testJsonable = TestJsonable(name: 'test', value: 123);

    test('toMap returns correct map', () {
      final map = testJsonable.toMap();
      expect(map, {'name': 'test', 'value': 123});
    });

    test('toJson returns correct JSON string', () {
      final json = testJsonable.toJson();
      expect(json, '{"name":"test","value":123}');
    });

    test('fromJson creates correct object', () {
      const json = '{"name":"test_from_json","value":456}';
      final fromJsonable = TestJsonable.fromJson(json);
      expect(fromJsonable, const TestJsonable(name: 'test_from_json', value: 456));
    });

    test('copyWith returns new object with updated values', () {
      final updatedJsonable = testJsonable.copyWith(name: 'updated_test');
      expect(updatedJsonable, const TestJsonable(name: 'updated_test', value: 123));

      final anotherUpdatedJsonable = testJsonable.copyWith(value: 789);
      expect(anotherUpdatedJsonable, const TestJsonable(name: 'test', value: 789));

      final fullyUpdatedJsonable = testJsonable.copyWith(name: 'full_update', value: 999);
      expect(fullyUpdatedJsonable, const TestJsonable(name: 'full_update', value: 999));

      final noChangeJsonable = testJsonable.copyWith();
      expect(noChangeJsonable, testJsonable);
    });

    test('fromMap throws UnimplementedError for base class', () {
      expect(() => Jsonable.fromMap({}), throwsA(isA<UnimplementedError>()));
    });

    test('fromJson throws UnimplementedError for base class if fromMap is not overridden', () {
      // This test is a bit tricky because Jsonable.fromJson calls Jsonable.fromMap.
      // If a concrete class doesn't override fromMap, it will still call the base
      // Jsonable.fromMap which throws UnimplementedError.
      // We already tested the concrete TestJsonable.fromJson above.
      // This test specifically checks the base class behavior.
      expect(() => Jsonable.fromJson('{}'), throwsA(isA<UnimplementedError>()));
    });
  });
}
