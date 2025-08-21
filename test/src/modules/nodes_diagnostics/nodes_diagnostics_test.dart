
import 'package:jnap/src/modules/nodes_diagnostics/action.dart';
import 'package:jnap/src/modules/nodes_diagnostics/service.dart';
import 'package:test/test.dart';

void main() {
  group('NodesDiagnostics actions', () {
    test('GetBackhaulInfo has correct properties', () {
      final action = GetBackhaulInfo.instance;
      expect(action.name, 'GetBackhaulInfo');
      expect(action.service, nodesDiagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/nodes/diagnostics/GetBackhaulInfo');
    });

    test('GetNodeNeighborInfo has correct properties', () {
      final action = GetNodeNeighborInfo.instance;
      expect(action.name, 'GetNodeNeighborInfo');
      expect(action.service, nodesDiagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/nodes/diagnostics/GetNodeNeighborInfo');
    });

    test('GetSlaveBackhaulStatus has correct properties', () {
      final action = GetSlaveBackhaulStatus.instance;
      expect(action.name, 'GetSlaveBackhaulStatus');
      expect(action.service, nodesDiagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/nodes/diagnostics/GetSlaveBackhaulStatus');
    });

    test('RefreshSlaveBackhaulData has correct properties', () {
      final action = RefreshSlaveBackhaulData.instance;
      expect(action.name, 'RefreshSlaveBackhaulData');
      expect(action.service, nodesDiagnosticsService);
      expect(action.command, 'http://linksys.com/jnap/nodes/diagnostics/RefreshSlaveBackhaulData');
    });

    test('GetBackhaulInfo handles versioning', () {
      final action = GetBackhaulInfo.instance;
      nodesDiagnosticsService.updateVersion(6);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/nodes/diagnostics/GetBackhaulInfo2');
    });
  });
}
