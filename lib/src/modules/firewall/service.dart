import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/firewall/Firewall
/// http://linksys.com/jnap/firewall/Firewall2
final firewallService = JNAPService(
  name: 'Firewall',
  path: 'firewall/',
);
