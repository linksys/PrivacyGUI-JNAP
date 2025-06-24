import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/parentalcontrol/ParentalControl
/// http://linksys.com/jnap/parentalcontrol/ParentalControl2
final parentalControlService = JNAPService(
  name: 'ParentalControl',
  path: 'parentalcontrol/',
);
