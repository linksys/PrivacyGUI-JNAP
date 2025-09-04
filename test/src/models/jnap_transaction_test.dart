import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_transaction.dart';
import 'package:jnap/src/modules/jnap_action.dart';
import 'package:mocktail/mocktail.dart';

class MockJNAPAction extends Mock implements JNAPAction {}

void main() {
  group('JNAPTransactionBuilder', () {
    late JNAPTransactionBuilder builder;
    late JNAPAction mockAction1;
    late JNAPAction mockAction2;

    setUp(() {
      builder = JNAPTransactionBuilder();
      mockAction1 = MockJNAPAction();
      mockAction2 = MockJNAPAction();
    });

    test('initializes with empty commands list', () {
      expect(builder.commands, isEmpty);
    });

    test('add should add a command to the list', () {
      builder.add(mockAction1, data: {'key': 'value'});
      expect(builder.commands.length, 1);
      expect(builder.commands.first.key, mockAction1);
      expect(builder.commands.first.value, {'key': 'value'});
    });

    test('addAll should add multiple commands to the list', () {
      final commands = [
        MapEntry(mockAction1, {'key1': 'value1'}),
        MapEntry(mockAction2, {'key2': 'value2'}),
      ];
      builder.addAll(commands);
      expect(builder.commands.length, 2);
      expect(builder.commands, commands);
    });

    test('remove should remove a command from the list', () {
      builder.add(mockAction1);
      builder.add(mockAction2);
      builder.remove(mockAction1);
      expect(builder.commands.length, 1);
      expect(builder.commands.first.key, mockAction2);
    });

    test('remove should do nothing if command is not in the list', () {
      builder.add(mockAction1);
      builder.remove(mockAction2);
      expect(builder.commands.length, 1);
      expect(builder.commands.first.key, mockAction1);
    });
  });
}