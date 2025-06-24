import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/networksecurity/NetworkSecurity
/// http://linksys.com/jnap/networksecurity/NetworkSecurity2
/// http://linksys.com/jnap/networksecurity/NetworkSecurity3
final networkSecurityService = JNAPService(
  name: 'NetworkSecurity',
  path: 'networksecurity/',
);
