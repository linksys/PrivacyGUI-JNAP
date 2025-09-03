import 'package:collection/collection.dart';
import 'package:jnap/src/modules/modules.dart';

/// JNAP action : ${service.servicePath}/$actionName$versionString
/// which versionString = version == 1 ? '' : '$version'
/// example: http://linksys.com/jnap/core/CheckAdminPassword
/// example: http://linksys.com/jnap/core/CheckAdminPassword2
/// example: http://linksys.com/jnap/core/CheckAdminPassword3
///
abstract class JNAPAction {
  final String name;
  final List<VersionVarients> varients;
  final JNAPService service;

  String get id => '${service.name}-$name';

  const JNAPAction({
    required this.name,
    this.varients = const [VersionVarients(1, 1)],
    required this.service,
  });

  String get latestVersion {
    // find the first version that matches the service version, if no match, return 1
    final versions = varients
        .map((element) =>
            (element.version, service.latestVersion - element.serviceVersion))
        .where((e) => e.$2 >= 0)
        .sorted((a, b) {
      final diff = a.$2.compareTo(b.$2);
      if (diff != 0) {
        return diff;
      }
      return b.$1.compareTo(a.$1);
    });
    final version = versions.firstOrNull?.$1 ?? 1;
    return version == 1 ? '' : '$version';
  }

  String get rawCommand {
    return '${service.servicePath}$name';
  }

  String get command {
    return '${service.servicePath}$name$latestVersion';
  }

  

  static List<JNAPAction> get all => [
        ...AirtimeFairnessAction.all,
        ...AutoOnboardingAction.all,
        ...BluetoothAction.all,
        ...CoreAction.all,
        ...DDNSAction.all,
        ...DeviceListAction.all,
        ...DFSSAction.all,
        ...DiagnosticsAction.all,
        ...FirewallAction.all,
        ...FirmwareUpdateAction.all,
        ...GamingPrioritizationAction.all,
        ...GuestNetworkAction.all,
        ...HealthCheckManagerAction.all,
        ...IPTVAction.all,
        ...MACFilterAction.all,
        ...MLOAction.all,
        ...MotionSensingAction.all,
        ...NetworkConnectionsAction.all,
        ...NetworkSecurityAction.all,
        ...NodesDiagnosticsAction.all,
        ...NodesFirmwareUpdateAction.all,
        ...NodesNetworkConnectionsAction.all,
        ...NodesTopologyOptimizationAction.all,
        ...OwnedNetworkAction.all,
        ...ParentalControlAction.all,
        ...PowerTableAction.all,
        ...ProductAction.all,
        ...QoSAction.all,
        ...RouterAction.all,
        ...RouterLEDsAction.all,
        ...RouterManagementAction.all,
        ...RouterUPnPAction.all,
        // ...SelectableWANAction.all,
        ...SettingsAction.all,
        ...SetupAction.all,
        ...SmartModeAction.all,
        // ...StorageAction.all,
        ...VlanTaggingAction.all,
        ...VPNAction.all,
        ...WirelessAPAction.all,
        ...WirelessSchedulerAction.all,
      ];
}

class VersionVarients {
  final int version;
  final int serviceVersion;

  const VersionVarients(this.version, this.serviceVersion);
}
