import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/routerleds/RouterLEDs
/// http://linksys.com/jnap/routerleds/RouterLEDs2
/// http://linksys.com/jnap/routerleds/RouterLEDs3
/// http://linksys.com/jnap/routerleds/RouterLEDs4
final routerLEDsService = JNAPService(
  name: 'RouterLEDs',
  path: 'routerleds/',
);
