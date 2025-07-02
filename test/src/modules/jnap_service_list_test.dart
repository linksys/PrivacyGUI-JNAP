import 'package:collection/collection.dart';
import 'package:jnap/src/modules/jnap_service_list.dart';
import 'package:jnap/src/modules/jnap_service.dart';
import 'package:test/test.dart';
import 'package:jnap/src/modules/modules.dart';

import '../../data/service_list.dart';

void main() {
  group('Test JNAPService.isSupportService', () {
    setUp(() {
      // Reset and set up test services
      JNAPServiceList.reset();
    });

    tearDown(() {});

    test('test with non existing service definition', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);
      expect(
          serviceList.services.any((s) => s.isSupportService('TestService1')),
          isFalse);
      expect(
          serviceList.services.any((s) => s.isSupportService('TestService2')),
          isFalse);
    });

    test('test with existing service definition after betterActions', () {
      final serviceList = JNAPServiceList();
      // expect service is not supported before betterActions since all latest version is 0
      expect(
          serviceList.services
              .any((s) => s.isSupportService('MultiLinkOperation')),
          isFalse);
      expect(
          serviceList.services
              .any((s) => s.isSupportService('DynamicFrequencySelection')),
          isFalse);
      serviceList.betterActions(testServiceList);
      // expect service is supported after betterActions since all latest version is updated
      expect(
          serviceList.services
              .any((s) => s.isSupportService('MultiLinkOperation')),
          isTrue);
      expect(
          serviceList.services
              .any((s) => s.isSupportService('DynamicFrequencySelection')),
          isTrue);
      expect(
          serviceList.services.any((s) => s.isSupportService('GuestNetwork')),
          isTrue);
    });
    test('test with existing services still not supported after betterActions',
        () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);
      // except some services still not supported since testServiceList does not contain them
      expect(
          serviceList.services.any((s) => s.isSupportService('VPN')), isFalse);
      expect(serviceList.services.any((s) => s.isSupportService('Storage')),
          isFalse);
    });

    /// supported: AdminPasswordAuthStatus, version: 7 on Service: Core
    /// supported: ChildReboot, version: 8 on Service: Core
    /// supported: ChildFactoryReset, version: 9 on Service: Core
    /// supported: GetSTABSSID, version: 2 on Service: MACFilter
    /// supported: TopologyOptimization, version: 2 on Service: TopologyOptimization
    /// supported: WANExternal, version: 13 on Service: Router
    /// supported: LedMode, version: 4 on Service: RouterLEDs
    /// supported: LedBlinking, version: 9 on Service: Setup
    /// supported: PnP, version: 11 on Service: Setup
    /// supported: ClientDeauth, version: 5 on Service: WirelessAP
    
    test('test with existing services supported keys and supported version greater than 1 after betterActions', () {
      final serviceList = JNAPServiceList();
      // collect all supported services by using fold with service name
      final list = serviceList.services.fold(<(String, JNAPServiceSupported)>[],
          (previousValue, element) {
        return previousValue
          ..addAll(element.supportedServices.map((s) => (element.name, s)));
      });
      // In testServiceList, all supported services have supported version greater than 1
      serviceList.betterActions(testServiceList);
      // verify all supported services are in the list
      list.where((e) => e.$2.supportedVersion > 1).forEach((supported) {
        // verify the service is supported if false then fail
        final isSupported = serviceList.services.any((s) => s.isSupportService(supported.$2.name));
        if (!isSupported) {
          fail('Service ${supported.$2.name} is not supported on ${supported.$1}');
        }
      });
    });
  });

  group('Test betterActions', () {
    setUp(() {});
    test('test AirtimeFairness service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect service version should be expected version
      final serviceName = 'AirtimeFairness';
      final expectVersion = 1;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });
    test('test AutoOnboarding service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect auto onboarding service version should be expected version
      final serviceName = 'AutoOnboarding';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Bluetooth service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect bluetooth service version should be expected version
      final serviceName = 'Bluetooth';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Core service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect core service version should be expected version
      final serviceName = 'Core';
      final expectVersion = 9;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test DDNS service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect ddns service version should be expected version
      final serviceName = 'DDNS';
      final expectVersion = 4;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test DeviceList service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect device list service version should be expected version
      final serviceName = 'DeviceList';
      final expectVersion = 7;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test DFS service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect dfs service version should be expected version
      final serviceName = 'DynamicFrequencySelection';
      final expectVersion = 1;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Diagnostics service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect diagnostics service version should be expected version
      final serviceName = 'Diagnostics';
      final expectVersion = 10;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Firewall service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect firewall service version should be expected version
      final serviceName = 'Firewall';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test FirmwareUpdate service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect firmware update service version should be   expected version
      final serviceName = 'FirmwareUpdate';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test GamingPrioritization service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect gaming prioritization service version should be expected version
      final serviceName = 'GamingPrioritization';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test GuestNetwork service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect guest network service version should be expected version
      final serviceName = 'GuestNetwork';
      final expectVersion = 5;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test HealthCheckManager service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect health check manager service version should be expected version
      final serviceName = 'HealthCheckManager';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test IPTV service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect iptv service version should be expected version
      final serviceName = 'IPTV';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Locale service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect locale service version should be expected version
      final serviceName = 'Locale';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test MACFilter service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect mac filter service version should be expected version
      final serviceName = 'MACFilter';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test MLO service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect mlo service version should be expected version
      final serviceName = 'MultiLinkOperation';
      final expectVersion = 1;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test MotionSensing service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect motion sensing service version should be expected version
      final serviceName = 'MotionSensing';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test NodesNetworkConnections service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect network connections service version should be expected version
      final serviceName = 'NodesNetworkConnections';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test NetworkSecurity service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect network security service version should be expected version
      final serviceName = 'NetworkSecurity';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test NodesDiagnostics service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect nodes diagnostics service version should be expected version
      final serviceName = 'Diagnostics';
      final expectVersion = 6;
      final service = serviceList.services.firstWhereOrNull(
          (e) => '${e.path}${e.name}' == 'nodes/diagnostics/${serviceName}');
      _checkServiceVersion(service, expectVersion);
    });

    test('test NodesFirmwareUpdate service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect nodes firmware update service version should be expected version
      final serviceName = 'FirmwareUpdate';
      final expectVersion = 1;
      final service = serviceList.services.firstWhereOrNull(
          (e) => '${e.path}${e.name}' == 'nodes/firmwareupdate/${serviceName}');
      _checkServiceVersion(service, expectVersion);
    });

    test('test NodesNetworkConnections service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect nodes network connections service version should be expected version
      final serviceName = 'NodesNetworkConnections';
      final expectVersion = 2;
      final service = serviceList.services.firstWhereOrNull((e) =>
          '${e.path}${e.name}' == 'nodes/networkconnections/${serviceName}');
      _checkServiceVersion(service, expectVersion);
    });

    test('test NodesTopologyOptimization service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect nodes topology optimization service version should be expected version
      final serviceName = 'TopologyOptimization';
      final expectVersion = 2;
      final service = serviceList.services.firstWhereOrNull((e) =>
          '${e.path}${e.name}' == 'nodes/topologyoptimization/${serviceName}');
      _checkServiceVersion(service, expectVersion);
    });

    test('test OwnedNetwork service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect owned network service version should be expected version
      final serviceName = 'OwnedNetwork';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test ParentalControl service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect parental control service version should be expected version
      final serviceName = 'ParentalControl';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test PowerTable service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect power table service version should be   expected version
      final serviceName = 'PowerTable';
      final expectVersion = 1;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Product service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect product service version should be expected version
      final serviceName = 'Product';
      final expectVersion = 1;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test QoS service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect qos service version should be expected version
      final serviceName = 'QoS';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Router service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect router service version should be expected version
      final serviceName = 'Router';
      final expectVersion = 13;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test RouterLEDs service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect router leds service version should be expected version
      final serviceName = 'RouterLEDs';
      final expectVersion = 4;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test RouterManagement service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect router management service version should be expected version
      final serviceName = 'RouterManagement';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test RouterUPnP service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect router upnp service version should be expected version
      final serviceName = 'RouterUPnP';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test SelectableWAN service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect selectable wan service version should be expected version
      final serviceName = 'SelectableWAN';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Settings service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect settings service version should be expected version
      final serviceName = 'Settings';
      final expectVersion = 3;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Setup service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect setup service version should be   expected version
      final serviceName = 'Setup';
      final expectVersion = 11;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test SmartMode service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect smart mode service version should be expected version
      final serviceName = 'SmartMode';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test Storage service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect storage service version should be expected version
      final serviceName = 'Storage';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test VlanTagging service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect vlan tagging service version should be expected version
      final serviceName = 'VLANTagging';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test VPN service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect vpn service version should be expected version
      final serviceName = 'VPN';
      final expectVersion = 0;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test WirelessAP service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect wireless ap service version should be expected version
      final serviceName = 'WirelessAP';
      final expectVersion = 5;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });

    test('test WirelessScheduler service', () {
      final serviceList = JNAPServiceList();
      serviceList.betterActions(testServiceList);

      // expect wireless scheduler service version should be expected version
      final serviceName = 'WirelessScheduler';
      final expectVersion = 2;
      final service =
          serviceList.services.firstWhereOrNull((e) => e.name == serviceName);
      _checkServiceVersion(service, expectVersion);
    });
  });
}

void _checkServiceVersion(JNAPService? service, int expectVersion) {
  if (service == null) {
    fail('Service not found');
  }
  if (service.latestVersion != expectVersion) {
    fail('${service.name} service version is ${service.latestVersion}');
  }
}
