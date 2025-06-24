import 'package:jnap/src/modules/nodes_topology_optimization/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/nodes/topologyoptimization/SetTopologyOptimizationSettings
/// http://linksys.com/jnap/nodes/topologyoptimization/SetTopologyOptimizationSettings2
/// http://linksys.com/jnap/nodes/topologyoptimization/GetTopologyOptimizationSettings
/// http://linksys.com/jnap/nodes/topologyoptimization/GetTopologyOptimizationSettings2

class NodesTopologyOptimizationAction extends JNAPAction {
  NodesTopologyOptimizationAction({
    required super.name,
    required super.varients,
  }) : super(service: nodesTopologyOptimizationService);

  static List<NodesTopologyOptimizationAction> get all => [
        SetTopologyOptimizationSettings.instance,
        GetTopologyOptimizationSettings.instance,
      ];
}

/// http://linksys.com/jnap/nodes/topologyoptimization/SetTopologyOptimizationSettings
/// http://linksys.com/jnap/nodes/topologyoptimization/SetTopologyOptimizationSettings2
class SetTopologyOptimizationSettings extends NodesTopologyOptimizationAction {
  static final SetTopologyOptimizationSettings instance =
      SetTopologyOptimizationSettings._();

  SetTopologyOptimizationSettings._()
      : super(
            name: 'SetTopologyOptimizationSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}

/// http://linksys.com/jnap/nodes/topologyoptimization/GetTopologyOptimizationSettings
/// http://linksys.com/jnap/nodes/topologyoptimization/GetTopologyOptimizationSettings2
class GetTopologyOptimizationSettings extends NodesTopologyOptimizationAction {
  static final GetTopologyOptimizationSettings instance =
      GetTopologyOptimizationSettings._();

  GetTopologyOptimizationSettings._()
      : super(
            name: 'GetTopologyOptimizationSettings',
            varients: [VersionVarients(1, 1), VersionVarients(2, 2)]);
}
