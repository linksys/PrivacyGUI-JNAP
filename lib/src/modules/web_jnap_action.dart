import 'package:jnap/src/modules/jnap_action.dart';
import 'package:jnap/src/modules/jnap_service.dart';

class WebJNAPAction extends JNAPAction {
  final String webCommand;

  WebJNAPAction(this.webCommand)
      : super(name: 'WebAction', service: _DummyService());

  @override
  String get command => webCommand;
}

class _DummyService extends JNAPService {
  _DummyService() : super(name: 'dummy', path: 'dummy');
}
