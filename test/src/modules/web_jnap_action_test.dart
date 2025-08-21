import 'package:test/test.dart';
import 'package:jnap/src/modules/web_jnap_action.dart';
import 'package:jnap/src/modules/jnap_service.dart';

void main() {
  group('WebJNAPAction', () {
    test('constructor initializes name and service correctly', () {
      final action = WebJNAPAction('testCommand');
      expect(action.name, 'WebAction');
      expect(action.service, isA<JNAPService>());
      // Since _DummyService is private, we can't directly check its type.
      // We can check if it's an instance of JNAPService.
    });

    test('command getter returns webCommand', () {
      final action = WebJNAPAction('anotherCommand');
      expect(action.command, 'anotherCommand');
    });
  });

  // Testing the private _DummyService is not directly possible without exposing it.
  // However, its properties are implicitly tested by WebJNAPAction's constructor test.
  // If direct testing is required, _DummyService would need to be made public.
}
