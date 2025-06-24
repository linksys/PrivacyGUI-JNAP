import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/routermanagement/RouterManagement
/// http://linksys.com/jnap/routermanagement/RouterManagement2
/// http://linksys.com/jnap/routermanagement/RouterManagement3
final routerManagementService = JNAPService(
  name: 'RouterManagement',
  path: 'routermanagement/',
);
