import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/nodes/topologyoptimization/TopologyOptimization
/// http://linksys.com/jnap/nodes/topologyoptimization/TopologyOptimization2
final nodesTopologyOptimizationService = JNAPService(
  name: 'TopologyOptimization',
  path: 'nodes/topologyoptimization/',
  supportedServices: [
    JNAPServiceSupported(name: 'TopologyOptimization', supportedVersion: 2),
  ],
);
