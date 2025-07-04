part of 'better_action.dart';

///
/// This is deprecated and will be removed in the future.
///
// List all useful JNAP services in the app
@deprecated
enum LegacyJNAPService {
  autoOnboarding(
      value: 'http://linksys.com/jnap/nodes/autoonboarding/AutoOnboarding'),
  autoOnboarding2(
      value: 'http://linksys.com/jnap/nodes/autoonboarding/AutoOnboarding2'),
  autoOnboarding3(
      value: 'http://linksys.com/jnap/nodes/autoonboarding/AutoOnboarding3'),
  bluetooth(value: 'http://linksys.com/jnap/nodes/bluetooth/Bluetooth'),
  bluetooth2(value: 'http://linksys.com/jnap/nodes/bluetooth/Bluetooth2'),
  core(value: 'http://linksys.com/jnap/core/Core'),
  core2(value: 'http://linksys.com/jnap/core/Core2'),
  core3(value: 'http://linksys.com/jnap/core/Core3'),
  core4(value: 'http://linksys.com/jnap/core/Core4'),
  core5(value: 'http://linksys.com/jnap/core/Core5'),
  core6(value: 'http://linksys.com/jnap/core/Core6'),
  core7(value: 'http://linksys.com/jnap/core/Core7'),
  core8(value: 'http://linksys.com/jnap/core/Core8'),
  core9(value: 'http://linksys.com/jnap/core/Core9'),
  ddns(value: 'http://linksys.com/jnap/ddns/DDNS'),
  ddns2(value: 'http://linksys.com/jnap/ddns/DDNS2'),
  ddns3(value: 'http://linksys.com/jnap/ddns/DDNS3'),
  ddns4(value: 'http://linksys.com/jnap/ddns/DDNS4'),
  deviceList(value: 'http://linksys.com/jnap/devicelist/DeviceList'),
  deviceList2(value: 'http://linksys.com/jnap/devicelist/DeviceList2'),
  deviceList4(value: 'http://linksys.com/jnap/devicelist/DeviceList4'),
  deviceList5(value: 'http://linksys.com/jnap/devicelist/DeviceList5'),
  deviceList6(value: 'http://linksys.com/jnap/devicelist/DeviceList6'),
  deviceList7(value: 'http://linksys.com/jnap/devicelist/DeviceList7'),
  diagnostics(value: 'http://linksys.com/jnap/diagnostics/Diagnostics'),
  diagnostics2(value: 'http://linksys.com/jnap/diagnostics/Diagnostics2'),
  diagnostics3(value: 'http://linksys.com/jnap/diagnostics/Diagnostics3'),
  diagnostics7(value: 'http://linksys.com/jnap/diagnostics/Diagnostics7'),
  diagnostics8(value: 'http://linksys.com/jnap/diagnostics/Diagnostics8'),
  diagnostics9(value: 'http://linksys.com/jnap/diagnostics/Diagnostics9'),
  diagnostics10(value: 'http://linksys.com/jnap/diagnostics/Diagnostics10'),
  firewall(value: 'http://linksys.com/jnap/firewall/Firewall'),
  firewall2(value: 'http://linksys.com/jnap/firewall/Firewall2'),
  firmwareUpdate(
      value: 'http://linksys.com/jnap/firmwareupdate/FirmwareUpdate'),
  firmwareUpdate2(
      value: 'http://linksys.com/jnap/firmwareupdate/FirmwareUpdate2'),
  // Application Prioritization
  // https://linksys.atlassian.net/wiki/spaces/LSW/pages/43516238/Application+Prioritization+-+Dev+Spec
  gamingPrioritization(
      value:
          'http://linksys.com/jnap/gamingprioritization/GamingPrioritization'),
  guestNetwork(value: 'http://linksys.com/jnap/guestnetwork/GuestNetwork'),
  guestNetwork2(value: 'http://linksys.com/jnap/guestnetwork/GuestNetwork2'),
  guestNetwork3(value: 'http://linksys.com/jnap/guestnetwork/GuestNetwork3'),
  guestNetwork4(value: 'http://linksys.com/jnap/guestnetwork/GuestNetwork4'),
  guestNetwork5(value: 'http://linksys.com/jnap/guestnetwork/GuestNetwork5'),
  healthCheckManager(
      value: 'http://linksys.com/jnap/healthcheck/HealthCheckManager'),
  locale(value: 'http://linksys.com/jnap/locale/Locale'),
  locale2(value: 'http://linksys.com/jnap/locale/Locale2'),
  locale3(value: 'http://linksys.com/jnap/locale/Locale3'),
  macFilter(value: 'http://linksys.com/jnap/macfilter/MACFilter'),
  macFilter2(value: 'http://linksys.com/jnap/macfilter/MACFilter2'),
  motionSensing(value: 'http://linksys.com/jnap/motionsensing/MotionSensing'),
  motionSensing2(value: 'http://linksys.com/jnap/motionsensing/MotionSensing2'),
  networkConnections(
      value: 'http://linksys.com/jnap/networkconnections/NetworkConnections'),
  networkConnections2(
      value: 'http://linksys.com/jnap/networkconnections/NetworkConnections2'),
  networkConnections3(
      value: 'http://linksys.com/jnap/networkconnections/NetworkConnections3'),
  networkSecurity(
      value: 'http://linksys.com/jnap/networksecurity/NetworkSecurity'),
  networkSecurity2(
      value: 'http://linksys.com/jnap/networksecurity/NetworkSecurity2'),
  networkSecurity3(
      value: 'http://linksys.com/jnap/networksecurity/NetworkSecurity3'),
  nodesDiagnostics(
      value: 'http://linksys.com/jnap/nodes/diagnostics/Diagnostics'),
  nodesDiagnostics2(
      value: 'http://linksys.com/jnap/nodes/diagnostics/Diagnostics2'),
  nodesDiagnostics3(
      value: 'http://linksys.com/jnap/nodes/diagnostics/Diagnostics3'),
  nodesDiagnostics5(
      value: 'http://linksys.com/jnap/nodes/diagnostics/Diagnostics5'),
  nodesDiagnostics6(
      value: 'http://linksys.com/jnap/nodes/diagnostics/Diagnostics6'),
  nodesNetworkConnections(
      value:
          'http://linksys.com/jnap/nodes/networkconnections/NodesNetworkConnections'),
  nodesNetworkConnections2(
      value:
          'http://linksys.com/jnap/nodes/networkconnections/NodesNetworkConnections2'),
  nodesFirmwareUpdate(
      value: 'http://linksys.com/jnap/nodes/firmwareupdate/FirmwareUpdate'),
  nodesTopologyOptimization(
      value:
          'http://linksys.com/jnap/nodes/topologyoptimization/TopologyOptimization'),
  nodesTopologyOptimization2(
      value:
          'http://linksys.com/jnap/nodes/topologyoptimization/TopologyOptimization2'),

  ownedNetwork(value: 'http://linksys.com/jnap/ownednetwork/OwnedNetwork'),
  ownedNetwork2(value: 'http://linksys.com/jnap/ownednetwork/OwnedNetwork2'),
  ownedNetwork3(value: 'http://linksys.com/jnap/ownednetwork/OwnedNetwork3'),
  parentalControl(
      value: 'http://linksys.com/jnap/parentalcontrol/ParentalControl'),
  parentalControl2(
      value: 'http://linksys.com/jnap/parentalcontrol/ParentalControl2'),
  powerTable(value: 'http://linksys.com/jnap/powertable/PowerTable'),
  product(value: 'http://linksys.com/jnap/product/Product'),
  qos(value: 'http://linksys.com/jnap/qos/QoS'),
  qos2(value: 'http://linksys.com/jnap/qos/QoS2'),
  qos3(value: 'http://linksys.com/jnap/qos/QoS3'),
  router(value: 'http://linksys.com/jnap/router/Router'),
  router3(value: 'http://linksys.com/jnap/router/Router3'),
  router4(value: 'http://linksys.com/jnap/router/Router4'),
  router5(value: 'http://linksys.com/jnap/router/Router5'),
  router6(value: 'http://linksys.com/jnap/router/Router6'),
  router7(value: 'http://linksys.com/jnap/router/Router7'),
  router8(value: 'http://linksys.com/jnap/router/Router8'),
  router9(value: 'http://linksys.com/jnap/router/Router9'),
  router10(value: 'http://linksys.com/jnap/router/Router10'),
  router11(value: 'http://linksys.com/jnap/router/Router11'),
  router12(value: 'http://linksys.com/jnap/router/Router12'),
  router13(value: 'http://linksys.com/jnap/router/Router13'),
  router14(value: 'http://linksys.com/jnap/router/Router14'),

  routerManagement(
      value: 'http://linksys.com/jnap/routermanagement/RouterManagement'),
  routerManagement2(
      value: 'http://linksys.com/jnap/routermanagement/RouterManagement2'),
  routerManagement3(
      value: 'http://linksys.com/jnap/routermanagement/RouterManagement3'),
  routerUPnP(value: 'http://linksys.com/jnap/routerupnp/RouterUPnP'),
  setup(value: 'http://linksys.com/jnap/nodes/setup/Setup'),
  setup2(value: 'http://linksys.com/jnap/nodes/setup/Setup2'),
  setup3(value: 'http://linksys.com/jnap/nodes/setup/Setup3'),
  setup4(value: 'http://linksys.com/jnap/nodes/setup/Setup4'),
  setup5(value: 'http://linksys.com/jnap/nodes/setup/Setup5'),
  setup6(value: 'http://linksys.com/jnap/nodes/setup/Setup6'),
  setup7(value: 'http://linksys.com/jnap/nodes/setup/Setup7'),
  setup8(value: 'http://linksys.com/jnap/nodes/setup/Setup8'),
  setup9(value: 'http://linksys.com/jnap/nodes/setup/Setup9'),
  setup10(value: 'http://linksys.com/jnap/nodes/setup/Setup10'),
  setup11(value: 'http://linksys.com/jnap/nodes/setup/Setup11'),
  smartMode(value: 'http://linksys.com/jnap/nodes/smartmode/SmartMode'),
  smartMode2(value: 'http://linksys.com/jnap/nodes/smartmode/SmartMode2'),
  selectableWAN(value: 'http://linksys.com/jnap/nodes/setup/SelectableWAN'),
  // TODO - Checking for the reference
  storage(value: 'http://linksys.com/jnap/storage/Storage'),
  // TODO - Checking for the reference
  storage2(value: 'http://linksys.com/jnap/storage/Storage2'),
  // TODO - Checking for the reference
  vlanTagging(value: 'http://linksys.com/jnap/vlantagging/VLANTagging'),
  // TODO - Checking for the reference
  vlanTagging2(value: 'http://linksys.com/jnap/vlantagging/VLANTagging2'),
  vpn(value: 'http://linksys.com/jnap/vpn/VPN'),
  wirelessAP(value: 'http://linksys.com/jnap/wirelessap/WirelessAP'),
  wirelessAP2(value: 'http://linksys.com/jnap/wirelessap/WirelessAP2'),
  // 2016-04-19	Consolidated WirelessAP2 and WirelessAP3 into WirelessAP4.
  wirelessAP3(value: 'http://linksys.com/jnap/wirelessap/WirelessAP3'),
  wirelessAP4(value: 'http://linksys.com/jnap/wirelessap/WirelessAP4'),
  wirelessAP5(value: 'http://linksys.com/jnap/wirelessap/WirelessAP5'),
  wirelessScheduler(
      value: 'http://linksys.com/jnap/wirelessscheduler/WirelessScheduler'),
  wirelessScheduler2(
      value: 'http://linksys.com/jnap/wirelessscheduler/WirelessScheduler2'),
  routerLEDs(value: 'http://linksys.com/jnap/routerleds/RouterLEDs'),
  routerLEDs2(value: 'http://linksys.com/jnap/routerleds/RouterLEDs2'),
  routerLEDs3(value: 'http://linksys.com/jnap/routerleds/RouterLEDs3'),
  routerLEDs4(value: 'http://linksys.com/jnap/routerleds/RouterLEDs4'),
  // iptv
  iptv(value: 'http://linksys.com/jnap/iptv/IPTV'),
  // mlo
  mlo(value: 'http://linksys.com/jnap/wirelessap/MultiLinkOperation'),
  // dfs
  dfs(value: 'http://linksys.com/jnap/wirelessap/DynamicFrequencySelection'),
  // airtime fairness
  airtimeFairness(value: 'http://linksys.com/jnap/wirelessap/AirtimeFairness'),
  //ui
  settings(value: 'http://linksys.com/jnap/ui/Settings'),
  settings2(value: 'http://linksys.com/jnap/ui/Settings2'),
  settings3(value: 'http://linksys.com/jnap/ui/Settings3'),
  ;

  const LegacyJNAPService({required this.value});

  final String value;

  static List<LegacyJNAPService> get appSupportedServices =>
      LegacyJNAPService.values;
}
