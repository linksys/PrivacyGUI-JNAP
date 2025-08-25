
import 'package:jnap/jnap.dart';

const noCacheJNAPRegex = '(?:/Set)';

bool isMatchedJNAPNoCachePolicy(JNAPAction action) {
  RegExp exp = RegExp(noCacheJNAPRegex);
  return exp.hasMatch(action.name);
}
