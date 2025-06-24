import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/nodes/diagnostics/Diagnostics
/// http://linksys.com/jnap/nodes/diagnostics/Diagnostics2
/// http://linksys.com/jnap/nodes/diagnostics/Diagnostics3
/// http://linksys.com/jnap/nodes/diagnostics/Diagnostics5
/// http://linksys.com/jnap/nodes/diagnostics/Diagnostics6
final nodesDiagnosticsService = JNAPService(
  name: 'Diagnostics',
  path: 'nodes/diagnostics/',
);
