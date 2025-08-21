
import 'package:jnap/src/modules/health_check_manager/action.dart';
import 'package:jnap/src/modules/health_check_manager/service.dart';
import 'package:test/test.dart';

void main() {
  group('HealthCheckManager actions', () {
    test('ClearHealthCheckHistory has correct properties', () {
      final action = ClearHealthCheckHistory.instance;
      expect(action.name, 'ClearHealthCheckHistory');
      expect(action.service, healthCheckManagerService);
      expect(action.command, 'http://linksys.com/jnap/healthcheck/ClearHealthCheckHistory');
    });

    test('GetHealthCheckResults has correct properties', () {
      final action = GetHealthCheckResults.instance;
      expect(action.name, 'GetHealthCheckResults');
      expect(action.service, healthCheckManagerService);
      expect(action.command, 'http://linksys.com/jnap/healthcheck/GetHealthCheckResults');
    });

    test('GetHealthCheckStatus has correct properties', () {
      final action = GetHealthCheckStatus.instance;
      expect(action.name, 'GetHealthCheckStatus');
      expect(action.service, healthCheckManagerService);
      expect(action.command, 'http://linksys.com/jnap/healthcheck/GetHealthCheckStatus');
    });

    test('GetSupportedHealthCheckModules has correct properties', () {
      final action = GetSupportedHealthCheckModules.instance;
      expect(action.name, 'GetSupportedHealthCheckModules');
      expect(action.service, healthCheckManagerService);
      expect(action.command, 'http://linksys.com/jnap/healthcheck/GetSupportedHealthCheckModules');
    });

    test('RunHealthCheck has correct properties', () {
      final action = RunHealthCheck.instance;
      expect(action.name, 'RunHealthCheck');
      expect(action.service, healthCheckManagerService);
      expect(action.command, 'http://linksys.com/jnap/healthcheck/RunHealthCheck');
    });

    test('StopHealthCheck has correct properties', () {
      final action = StopHealthCheck.instance;
      expect(action.name, 'StopHealthCheck');
      expect(action.service, healthCheckManagerService);
      expect(action.command, 'http://linksys.com/jnap/healthcheck/StopHealthCheck');
    });
  });
}
