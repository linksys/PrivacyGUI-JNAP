import 'package:jnap/src/modules/health_check_manager/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

///   'http://linksys.com/jnap/healthcheck/ClearHealthCheckHistory'),
///   'http://linksys.com/jnap/healthcheck/GetHealthCheckResults'),
///   'http://linksys.com/jnap/healthcheck/GetHealthCheckStatus'),
///   'http://linksys.com/jnap/healthcheck/GetSupportedHealthCheckModules'),
///   'http://linksys.com/jnap/healthcheck/RunHealthCheck'),
///   'http://linksys.com/jnap/healthcheck/StopHealthCheck'),
sealed class HealthCheckManagerAction extends JNAPAction {
  HealthCheckManagerAction({
    required super.name,
    required super.varients,
  }) : super(service: healthCheckManagerService);

  static List<HealthCheckManagerAction> get all => [
        ClearHealthCheckHistory.instance,
        GetHealthCheckResults.instance,
        GetHealthCheckStatus.instance,
        GetSupportedHealthCheckModules.instance,
        RunHealthCheck.instance,
        StopHealthCheck.instance,
      ];
}

///   'http://linksys.com/jnap/healthcheck/ClearHealthCheckHistory'),
class ClearHealthCheckHistory extends HealthCheckManagerAction {
  static final ClearHealthCheckHistory instance = ClearHealthCheckHistory._();
  ClearHealthCheckHistory._()
      : super(name: 'ClearHealthCheckHistory', varients: [
          VersionVarients(1, 1),
        ]);
}

///   'http://linksys.com/jnap/healthcheck/GetHealthCheckResults'),
class GetHealthCheckResults extends HealthCheckManagerAction {
  static final GetHealthCheckResults instance = GetHealthCheckResults._();
  GetHealthCheckResults._()
      : super(name: 'GetHealthCheckResults', varients: [
          VersionVarients(1, 1),
        ]);
}

///   'http://linksys.com/jnap/healthcheck/GetHealthCheckStatus'),
class GetHealthCheckStatus extends HealthCheckManagerAction {
  static final GetHealthCheckStatus instance = GetHealthCheckStatus._();
  GetHealthCheckStatus._()
      : super(name: 'GetHealthCheckStatus', varients: [
          VersionVarients(1, 1),
        ]);
}

///   'http://linksys.com/jnap/healthcheck/GetSupportedHealthCheckModules'),
class GetSupportedHealthCheckModules extends HealthCheckManagerAction {
  static final GetSupportedHealthCheckModules instance =
      GetSupportedHealthCheckModules._();
  GetSupportedHealthCheckModules._()
      : super(name: 'GetSupportedHealthCheckModules', varients: [
          VersionVarients(1, 1),
        ]);
}

///   'http://linksys.com/jnap/healthcheck/RunHealthCheck'),
class RunHealthCheck extends HealthCheckManagerAction {
  static final RunHealthCheck instance = RunHealthCheck._();
  RunHealthCheck._()
      : super(name: 'RunHealthCheck', varients: [
          VersionVarients(1, 1),
        ]);
}

///   'http://linksys.com/jnap/healthcheck/StopHealthCheck'),
class StopHealthCheck extends HealthCheckManagerAction {
  static final StopHealthCheck instance = StopHealthCheck._();
  StopHealthCheck._()
      : super(name: 'StopHealthCheck', varients: [
          VersionVarients(1, 1),
        ]);
}
