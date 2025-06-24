import 'package:jnap/src/legacy/better_action.dart';


class ServiceHelper {
  bool isSupportVPN([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.vpn, services);

  bool isSupportSetup([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.setup, services);

  bool isSupportGuestNetwork([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.guestNetwork, services);

  bool isSupportLedMode([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.routerLEDs4, services);

  bool isSupportNodeFirmwareUpdate([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.nodesFirmwareUpdate, services);

  bool isSupportHealthCheck([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.healthCheckManager, services);

  bool isSupportProduct([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.product, services);

  bool isSupportLedBlinking([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.setup9, services);

  bool isSupportAutoOnboarding([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.autoOnboarding, services);

  bool isSupportPnP([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.setup11, services);

  bool isSupportTopologyOptimization([List<String>? services]) =>
      checkServiceSupport(
          LegacyJNAPService.nodesTopologyOptimization2, services);

  bool isSupportMLO([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.mlo, services);

  bool isSupportIPTv([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.iptv, services);

  bool isSupportDFS([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.dfs, services);

  bool isSupportAirtimeFairness([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.airtimeFairness, services);

  bool isSupportAdminPasswordAuthStatus([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.core7, services);

  bool isSupportChildReboot([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.core8, services);

  bool isSupportChildFactoryReset([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.core9, services);

  bool isSupportWANExternal([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.router13, services);

  bool isSupportClientDeauth([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.wirelessAP5, services);

  bool isSupportGetSTABSSID([List<String>? services]) =>
      checkServiceSupport(LegacyJNAPService.macFilter2, services);

  bool checkServiceSupport(LegacyJNAPService service, List<String>? services) {
    return services?.contains(service.value) ?? false;
  }
}
