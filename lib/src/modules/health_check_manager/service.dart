import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/healthcheck/HealthCheckManager
final healthCheckManagerService = JNAPService(
  name: 'HealthCheckManager',
  path: 'healthcheck/',
);
