import 'package:jnap/src/modules/nodes_diagnostics/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/nodes/diagnostics/GetBackhaulInfo
/// http://linksys.com/jnap/nodes/diagnostics/GetBackhaulInfo2
/// http://linksys.com/jnap/nodes/diagnostics/GetNodeNeighborInfo
/// http://linksys.com/jnap/nodes/diagnostics/GetSlaveBackhaulStatus
/// http://linksys.com/jnap/nodes/diagnostics/RefreshSlaveBackhaulData
sealed class NodesDiagnosticsAction extends JNAPAction {
  NodesDiagnosticsAction({required super.name, required super.varients})
      : super(service: nodesDiagnosticsService);

  static List<NodesDiagnosticsAction> get all => [
        GetBackhaulInfo.instance,
        GetNodeNeighborInfo.instance,
        GetSlaveBackhaulStatus.instance,
        RefreshSlaveBackhaulData.instance,
      ];
}

/// http://linksys.com/jnap/nodes/diagnostics/GetBackhaulInfo
/// http://linksys.com/jnap/nodes/diagnostics/GetBackhaulInfo2
class GetBackhaulInfo extends NodesDiagnosticsAction {
  static final GetBackhaulInfo instance = GetBackhaulInfo._();
  GetBackhaulInfo._()
      : super(
            name: 'GetBackhaulInfo',
            varients: [VersionVarients(1, 1), VersionVarients(2, 6)]);
}

/// http://linksys.com/jnap/nodes/diagnostics/GetNodeNeighborInfo
class GetNodeNeighborInfo extends NodesDiagnosticsAction {
  static final GetNodeNeighborInfo instance = GetNodeNeighborInfo._();
  GetNodeNeighborInfo._()
      : super(name: 'GetNodeNeighborInfo', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/diagnostics/GetSlaveBackhaulStatus
class GetSlaveBackhaulStatus extends NodesDiagnosticsAction {
  static final GetSlaveBackhaulStatus instance = GetSlaveBackhaulStatus._();
  GetSlaveBackhaulStatus._()
      : super(
            name: 'GetSlaveBackhaulStatus', varients: [VersionVarients(1, 1)]);
}

/// http://linksys.com/jnap/nodes/diagnostics/RefreshSlaveBackhaulData
class RefreshSlaveBackhaulData extends NodesDiagnosticsAction {
  static final RefreshSlaveBackhaulData instance = RefreshSlaveBackhaulData._();
  RefreshSlaveBackhaulData._()
      : super(
            name: 'RefreshSlaveBackhaulData',
            varients: [VersionVarients(1, 1)]);
}
