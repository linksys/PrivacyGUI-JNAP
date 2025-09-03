import 'package:collection/collection.dart';
import 'package:jnap/src/modules/modules.dart';
import 'package:jnap/src/modules/jnap_action.dart'; // Import JNAPAction

class WebJNAPAction {
  static JNAPAction? getVersionedAction(JNAPAction action) {
    return getVersionedActionJS(action.rawCommand);
  }

  static JNAPAction? getVersionedActionJS(String action) {
    // identify if action has digit at last
    RegExp regExp = RegExp(r'.*(\d)$');
    final match = regExp.firstMatch(action);
    if (match != null) {
      action = action.replaceAll(match.group(1)!, '');
    }
    final jnapAction = JNAPAction.all
        .firstWhereOrNull((element) => element.rawCommand == action);
    return jnapAction;
  }
}