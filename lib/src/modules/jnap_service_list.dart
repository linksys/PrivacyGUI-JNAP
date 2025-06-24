// list of all services
import 'package:collection/collection.dart';
import 'package:jnap/src/modules/modules.dart';
import 'package:meta/meta.dart';

class JNAPServiceList {
  static final _serviceList = [
    airtimeFairnessService,
    autoOnboardingService,
    bluetoothService,
    coreService,
    ddnsService,
    deviceListService,
    dfsService,
    diagnosticsService,
    firewallService,
    firmwareUpdateService,
    gamingPrioritizationService,
    guestNetworkService,
    healthCheckManagerService,
    iptvService,
    localeService,
    macFilterService,
    mloService,
    motionSensingService,
    networkConnectionsService,
    networkSecurityService,
    nodesDiagnosticsService,
    nodesFirmwareUpdateService,
    nodesNetworkConnectionsService,
    nodesTopologyOptimizationService,
    ownedNetworkService,
    parentalControlService,
    powerTableService,
    productService,
    qosService,
    routerService,
    routerLEDsService,
    routerManagementService,
    routerUPnPService,
    selectableWANService,
    settingsService,
    setupService,
    smartModeService,
    storageService,
    vlanTaggingService,
    vpnService,
    wirelessAPService,
    wirelessSchedulerService,
  ];
  final List<JNAPService> services;

  JNAPServiceList([List<JNAPService>? serviceList])
      : services = serviceList ?? _serviceList;

  @visibleForTesting
  static void reset() {
    _serviceList.forEach((element) {
      element.updateVersion(0);
    });
  }

  /// Updates the latest version of each JNAP service based on the provided service list.
  ///
  /// This function processes a list of service URLs, extracts their version numbers,
  /// and updates the corresponding service objects with the highest available version.
  ///
  /// [services] - List of service URLs in the format 'http://linksys.com/jnap/[service]/[ServiceName][Version]'
  ///
  /// Example:
  ///   - Input: ['http://linksys.com/jnap/wirelessap/WirelessAP2', 'http://linksys.com/jnap/device/DeviceList3']
  ///   - Updates the versions for WirelessAP and DeviceList services accordingly
  void betterActions(List<String> services) {
    if (services.isEmpty) {
      return;
    }
    final serviceMap = _groupAndSortJNAPServices(services);
    final sortedServiceList =
        serviceMap.values.reduce((all, value) => all..addAll(value));
    for (final service in sortedServiceList) {
      // get version from service string
      final last = service.split('/').last;
      // check the version, if it has no number, then it is version 1
      final match = RegExp(r'(\d+)').firstMatch(last);
      int versionInt = 1;
      if (match != null) {
        versionInt = int.parse(match.group(1) ?? '1');
      }
      // Find via full service path
      final target = this
          .services
          .firstWhereOrNull((e) => service.contains(e.fullServiceName));
      // Update the latest version if the version is higher and the target is not null
      if (target != null && target.latestVersion < versionInt) {
        target.updateVersion(versionInt);
      }
    }
  }

  Map<String, List<String>> _groupAndSortJNAPServices(List<String> services) {
    final groupedServices = groupBy<String, String>(services, (service) {
      final name = Uri.parse(service).pathSegments.last;
      final match = RegExp(r'(\d+)').firstMatch(name);
      if (match != null) {
        return name.substring(0, name.indexOf(match.group(0)!));
      }
      return name;
    });

    final sortedGroupedServices = <String, List<String>>{};

    groupedServices.forEach((key, value) {
      sortedGroupedServices[key] = value.sorted((a, b) {
        final aMatch = RegExp(r'(\d+)').firstMatch(a);
        final bMatch = RegExp(r'(\d+)').firstMatch(b);

        if (aMatch != null && bMatch != null) {
          return int.parse(aMatch.group(1)!)
              .compareTo(int.parse(bMatch.group(1)!));
        } else if (aMatch != null) {
          return 1;
        } else if (bMatch != null) {
          return -1;
        } else {
          return a.compareTo(b);
        }
      }).toList();
    });

    return sortedGroupedServices;
  }
}
