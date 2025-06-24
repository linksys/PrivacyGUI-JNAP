import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/diagnostics/Diagnostics
/// http://linksys.com/jnap/diagnostics/Diagnostics2
/// http://linksys.com/jnap/diagnostics/Diagnostics3
/// http://linksys.com/jnap/diagnostics/Diagnostics7
/// http://linksys.com/jnap/diagnostics/Diagnostics8
/// http://linksys.com/jnap/diagnostics/Diagnostics9
/// http://linksys.com/jnap/diagnostics/Diagnostics10
///
final diagnosticsService = JNAPService(
  name: 'Diagnostics',
  path: 'diagnostics/',
);
