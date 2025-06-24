import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/ui/Settings
/// http://linksys.com/jnap/ui/Settings2
/// http://linksys.com/jnap/ui/Settings3
///
final settingsService = JNAPService(
  name: 'Settings',
  path: 'ui/',
);
