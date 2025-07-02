import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/router/Router
/// http://linksys.com/jnap/router/Router3
/// http://linksys.com/jnap/router/Router4
/// http://linksys.com/jnap/router/Router5
/// http://linksys.com/jnap/router/Router6
/// http://linksys.com/jnap/router/Router7
/// http://linksys.com/jnap/router/Router8
/// http://linksys.com/jnap/router/Router9
/// http://linksys.com/jnap/router/Router10
/// http://linksys.com/jnap/router/Router11
/// http://linksys.com/jnap/router/Router12
/// http://linksys.com/jnap/router/Router13
/// http://linksys.com/jnap/router/Router14
final routerService = JNAPService(
  name: 'Router',
  path: 'router/',
  supportedServices: [
    JNAPServiceSupported(name: 'WANExternal', supportedVersion: 13),
  ],
);
