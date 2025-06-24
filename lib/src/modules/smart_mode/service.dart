import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/nodes/smartmode/SmartMode
/// http://linksys.com/jnap/nodes/smartmode/SmartMode2
final smartModeService = JNAPService(
  name: 'SmartMode',
  path: 'nodes/smartmode/',
);
