
import 'package:jnap/src/modules/nodes_topology_optimization/action.dart';
import 'package:jnap/src/modules/nodes_topology_optimization/service.dart';
import 'package:test/test.dart';

void main() {
  group('NodesTopologyOptimization actions', () {
    test('SetTopologyOptimizationSettings has correct properties', () {
      final action = SetTopologyOptimizationSettings.instance;
      expect(action.name, 'SetTopologyOptimizationSettings');
      expect(action.service, nodesTopologyOptimizationService);
      expect(action.command, 'http://linksys.com/jnap/nodes/topologyoptimization/SetTopologyOptimizationSettings');
    });

    test('GetTopologyOptimizationSettings has correct properties', () {
      final action = GetTopologyOptimizationSettings.instance;
      expect(action.name, 'GetTopologyOptimizationSettings');
      expect(action.service, nodesTopologyOptimizationService);
      expect(action.command, 'http://linksys.com/jnap/nodes/topologyoptimization/GetTopologyOptimizationSettings');
    });

    test('SetTopologyOptimizationSettings handles versioning', () {
      final action = SetTopologyOptimizationSettings.instance;
      nodesTopologyOptimizationService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/nodes/topologyoptimization/SetTopologyOptimizationSettings2');
    });

    test('GetTopologyOptimizationSettings handles versioning', () {
      final action = GetTopologyOptimizationSettings.instance;
      nodesTopologyOptimizationService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/nodes/topologyoptimization/GetTopologyOptimizationSettings2');
    });
  });
}
