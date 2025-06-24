import 'package:collection/collection.dart';

part 'jnap_action.dart';

part 'jnap_action_value.dart';

part 'jnap_service.dart';

///
/// This is deprecated and will be removed in the future.
///

// The better action map
var _betterActionMap = <LegacyJNAPAction, String>{};

// Update actions to better actions by the given service
void _updateBetterActions(LegacyJNAPService service) {
  switch (service) {
    case LegacyJNAPService.autoOnboarding:
      break;
    case LegacyJNAPService.autoOnboarding2:
      _betterActionMap[LegacyJNAPAction.getBluetoothAutoOnboardingStatus] =
          LegacyJNAPActionValue.getBluetoothAutoOnboardingStatus2.value;
    case LegacyJNAPService.autoOnboarding3:
      _betterActionMap[LegacyJNAPAction.startBlueboothAutoOnboarding] =
          LegacyJNAPActionValue.startBluetoothAutoOnboarding2.value;
    case LegacyJNAPService.bluetooth:
      break;
    case LegacyJNAPService.bluetooth2:
      break;
    case LegacyJNAPService.core:
      break;
    case LegacyJNAPService.core2:
      _betterActionMap[LegacyJNAPAction.checkAdminPassword] =
          LegacyJNAPActionValue.checkAdminPassword2.value;
      break;
    case LegacyJNAPService.core3:
      _betterActionMap[LegacyJNAPAction.coreSetAdminPassword] =
          LegacyJNAPActionValue.coreSetAdminPassword2.value;
      break;
    case LegacyJNAPService.core4:
      break;
    case LegacyJNAPService.core5:
      break;
    case LegacyJNAPService.core6:
      break;
    case LegacyJNAPService.core7:
      _betterActionMap[LegacyJNAPAction.checkAdminPassword] =
          LegacyJNAPActionValue.checkAdminPassword3.value;
      _betterActionMap[LegacyJNAPAction.coreSetAdminPassword] =
          LegacyJNAPActionValue.coreSetAdminPassword3.value;
      break;
    case LegacyJNAPService.core8:
      break;
    case LegacyJNAPService.core9:
      break;
    case LegacyJNAPService.ddns:
      break;
    case LegacyJNAPService.ddns2:
      break;
    case LegacyJNAPService.ddns3:
      _betterActionMap[LegacyJNAPAction.getDDNSStatus] =
          LegacyJNAPActionValue.getDDNSStatus2.value;
      break;
    case LegacyJNAPService.ddns4:
      break;
    case LegacyJNAPService.deviceList:
      break;
    case LegacyJNAPService.deviceList2:
      break;
    case LegacyJNAPService.deviceList4:
      _betterActionMap[LegacyJNAPAction.getDevices] =
          LegacyJNAPActionValue.getDevices3.value;
      break;
    case LegacyJNAPService.deviceList5:
      break;
    case LegacyJNAPService.deviceList6:
      break;
    case LegacyJNAPService.deviceList7:
      break;
    case LegacyJNAPService.firewall:
      break;
    case LegacyJNAPService.firewall2:
      break;
    case LegacyJNAPService.firmwareUpdate:
      break;
    case LegacyJNAPService.firmwareUpdate2:
      break;
    case LegacyJNAPService.gamingPrioritization:
      _betterActionMap[LegacyJNAPAction.getGamingPrioritizationSettings] =
          LegacyJNAPActionValue.getGamingPrioritizationSettings.value;
      _betterActionMap[LegacyJNAPAction.setGamingPrioritizationSettings] =
          LegacyJNAPActionValue.setGamingPrioritizationSettings.value;
      break;
    case LegacyJNAPService.guestNetwork:
      break;
    case LegacyJNAPService.guestNetwork2:
      _betterActionMap[LegacyJNAPAction.getGuestNetworkSettings] =
          LegacyJNAPActionValue.getGuestNetworkSettings2.value;
      _betterActionMap[LegacyJNAPAction.setGuestNetworkSettings] =
          LegacyJNAPActionValue.setGuestNetworkSettings3.value;
      break;
    case LegacyJNAPService.guestNetwork3:
      _betterActionMap[LegacyJNAPAction.getGuestNetworkSettings] =
          LegacyJNAPActionValue.getGuestRadioSettings.value;
      _betterActionMap[LegacyJNAPAction.setGuestNetworkSettings] =
          LegacyJNAPActionValue.setGuestRadioSettings.value;
      break;
    case LegacyJNAPService.guestNetwork4:
      _betterActionMap[LegacyJNAPAction.getGuestNetworkSettings] =
          LegacyJNAPActionValue.getGuestRadioSettings2.value;
      _betterActionMap[LegacyJNAPAction.setGuestNetworkSettings] =
          LegacyJNAPActionValue.setGuestRadioSettings2.value;
      _betterActionMap[LegacyJNAPAction.getGuestRadioSettings] =
          LegacyJNAPActionValue.getGuestRadioSettings2.value;
      _betterActionMap[LegacyJNAPAction.setGuestRadioSettings] =
          LegacyJNAPActionValue.setGuestRadioSettings2.value;
      break;
    case LegacyJNAPService.guestNetwork5:
      break;
    case LegacyJNAPService.healthCheckManager:
      break;
    case LegacyJNAPService.locale:
      break;
    case LegacyJNAPService.locale2:
      break;
    case LegacyJNAPService.locale3:
      break;
    case LegacyJNAPService.macFilter:
      break;
    case LegacyJNAPService.macFilter2:
      break;
    case LegacyJNAPService.motionSensing:
      break;
    case LegacyJNAPService.motionSensing2:
      break;
    case LegacyJNAPService.networkConnections:
      break;
    case LegacyJNAPService.networkConnections2:
      _betterActionMap[LegacyJNAPAction.getNetworkConnections] =
          LegacyJNAPActionValue.getNetworkConnections2.value;
      break;
    case LegacyJNAPService.networkConnections3:
      break;
    case LegacyJNAPService.networkSecurity:
      break;
    case LegacyJNAPService.networkSecurity2:
      break;
    case LegacyJNAPService.networkSecurity3:
      _betterActionMap[LegacyJNAPAction.getNetworkSecuritySettings] =
          LegacyJNAPActionValue.getNetworkSecuritySettings2.value;
      _betterActionMap[LegacyJNAPAction.setNetworkSecuritySettings] =
          LegacyJNAPActionValue.setNetworkSecuritySettings2.value;
      break;
    case LegacyJNAPService.nodesDiagnostics:
      break;
    case LegacyJNAPService.nodesDiagnostics2:
      break;
    case LegacyJNAPService.nodesDiagnostics3:
      break;
    case LegacyJNAPService.nodesDiagnostics5:
      break;
    case LegacyJNAPService.nodesDiagnostics6:
      _betterActionMap[LegacyJNAPAction.getBackhaulInfo] =
          LegacyJNAPActionValue.getBackhaulInfo2.value;
      break;
    case LegacyJNAPService.nodesNetworkConnections:
      _betterActionMap[LegacyJNAPAction.getNodesWirelessNetworkConnections] =
          LegacyJNAPActionValue.getNodesWirelessNetworkConnections.value;
      break;
    case LegacyJNAPService.nodesNetworkConnections2:
      _betterActionMap[LegacyJNAPAction.getNodesWirelessNetworkConnections] =
          LegacyJNAPActionValue.getNodesWirelessNetworkConnections2.value;
      break;
    case LegacyJNAPService.ownedNetwork:
      break;
    case LegacyJNAPService.ownedNetwork2:
      break;
    case LegacyJNAPService.ownedNetwork3:
      break;
    case LegacyJNAPService.parentalControl:
      break;
    case LegacyJNAPService.parentalControl2:
      break;
    case LegacyJNAPService.powerTable:
      break;
    case LegacyJNAPService.product:
      break;
    case LegacyJNAPService.qos:
      break;
    case LegacyJNAPService.qos2:
      _betterActionMap[LegacyJNAPAction.getQoSSettings] =
          LegacyJNAPActionValue.getQoSSettings2.value;
      break;
    case LegacyJNAPService.qos3:
      break;
    case LegacyJNAPService.router:
      break;
    case LegacyJNAPService.router3:
      _betterActionMap[LegacyJNAPAction.getWANSettings] =
          LegacyJNAPActionValue.getWANSettings2.value;
      _betterActionMap[LegacyJNAPAction.setWANSettings] =
          LegacyJNAPActionValue.setWANSettings2.value;
      _betterActionMap[LegacyJNAPAction.getWANStatus] =
          LegacyJNAPActionValue.getWANStatus2.value;
      break;
    case LegacyJNAPService.router4:
      break;
    case LegacyJNAPService.router5:
      _betterActionMap[LegacyJNAPAction.getIPv6Settings] =
          LegacyJNAPActionValue.getIPv6Settings2.value;
      _betterActionMap[LegacyJNAPAction.getWANStatus] =
          LegacyJNAPActionValue.getWANStatus3.value;
      _betterActionMap[LegacyJNAPAction.setIPv6Settings] =
          LegacyJNAPActionValue.setIPv6Settings2.value;
      break;
    case LegacyJNAPService.router6:
      _betterActionMap[LegacyJNAPAction.getExpressForwardingSettings] =
          LegacyJNAPActionValue.getExpressForwardingSettings.value;
      _betterActionMap[LegacyJNAPAction.setExpressForwardingSettings] =
          LegacyJNAPActionValue.setExpressForwardingSettings.value;

      break;
    case LegacyJNAPService.router7:
      _betterActionMap[LegacyJNAPAction.getWANSettings] =
          LegacyJNAPActionValue.getWANSettings3.value;
      _betterActionMap[LegacyJNAPAction.setWANSettings] =
          LegacyJNAPActionValue.setWANSettings3.value;
      break;
    case LegacyJNAPService.router8:
      _betterActionMap[LegacyJNAPAction.getWANSettings] =
          LegacyJNAPActionValue.getWANSettings4.value;
      _betterActionMap[LegacyJNAPAction.setWANSettings] =
          LegacyJNAPActionValue.setWANSettings4.value;
      break;
    case LegacyJNAPService.router9:
      break;
    case LegacyJNAPService.router10:
      _betterActionMap[LegacyJNAPAction.getWANSettings] =
          LegacyJNAPActionValue.getWANSettings5.value;
      break;
    case LegacyJNAPService.router11:
      break;
    case LegacyJNAPService.router12:
      break;
    case LegacyJNAPService.router13:
      _betterActionMap[LegacyJNAPAction.getWANExternal] =
          LegacyJNAPActionValue.getWANExternal.value;
      break;
    case LegacyJNAPService.router14:
      _betterActionMap[LegacyJNAPAction.setWANSettings] =
          LegacyJNAPActionValue.setWANSettings5.value;
      break;
    case LegacyJNAPService.routerManagement:
      break;
    case LegacyJNAPService.routerManagement2:
      _betterActionMap[LegacyJNAPAction.getManagementSettings] =
          LegacyJNAPActionValue.getManagementSettings2.value;
      _betterActionMap[LegacyJNAPAction.setManagementSettings] =
          LegacyJNAPActionValue.setManagementSettings2.value;
      break;
    case LegacyJNAPService.routerManagement3:
      break;
    case LegacyJNAPService.routerUPnP:
      break;
    case LegacyJNAPService.setup:
      break;
    case LegacyJNAPService.setup2:
      break;
    case LegacyJNAPService.setup3:
      break;
    case LegacyJNAPService.setup4:
      break;
    case LegacyJNAPService.setup5:
      break;
    case LegacyJNAPService.setup6:
      break;
    case LegacyJNAPService.setup7:
      break;
    case LegacyJNAPService.setup8:
      _betterActionMap[LegacyJNAPAction.setupSetAdminPassword] =
          LegacyJNAPActionValue.setupSetAdminPassword2.value;
      break;
    case LegacyJNAPService.setup9:
      break;
    case LegacyJNAPService.setup10:
      break;
    case LegacyJNAPService.setup11:
      break;
    case LegacyJNAPService.smartMode:
      break;
    case LegacyJNAPService.smartMode2:
      break;
    case LegacyJNAPService.selectableWAN:
      break;
    case LegacyJNAPService.storage:
      break;
    case LegacyJNAPService.storage2:
      break;
    case LegacyJNAPService.vlanTagging:
      break;
    case LegacyJNAPService.vlanTagging2:
      _betterActionMap[LegacyJNAPAction.getVLANTaggingSettings] =
          LegacyJNAPActionValue.getVLANTaggingSettings2.value;
      _betterActionMap[LegacyJNAPAction.setVLANTaggingSettings] =
          LegacyJNAPActionValue.setVLANTaggingSettings2.value;
      break;
    case LegacyJNAPService.wirelessAP:
      break;
    case LegacyJNAPService.wirelessAP2:
      break;
    case LegacyJNAPService.wirelessAP3:
      _betterActionMap[LegacyJNAPAction.getRadioInfo] =
          LegacyJNAPActionValue.getRadioInfo2.value;
      _betterActionMap[LegacyJNAPAction.setRadioSettings] =
          LegacyJNAPActionValue.setRadioSettings2.value;
      break;
    case LegacyJNAPService.wirelessAP4:
      _betterActionMap[LegacyJNAPAction.getRadioInfo] =
          LegacyJNAPActionValue.getRadioInfo3.value;
      _betterActionMap[LegacyJNAPAction.setRadioSettings] =
          LegacyJNAPActionValue.setRadioSettings3.value;
      break;
    case LegacyJNAPService.wirelessAP5:
      _betterActionMap[LegacyJNAPAction.clientDeauth] =
          LegacyJNAPActionValue.clientDeuth.value;
      break;
    case LegacyJNAPService.wirelessScheduler:
      break;
    case LegacyJNAPService.wirelessScheduler2:
      break;
    case LegacyJNAPService.routerLEDs:
      break;
    case LegacyJNAPService.routerLEDs2:
      break;
    case LegacyJNAPService.routerLEDs3:
      break;
    case LegacyJNAPService.routerLEDs4:
      _betterActionMap[LegacyJNAPAction.setLedNightModeSetting] =
          LegacyJNAPActionValue.setLedNightModeSetting2.value;
      break;
    case LegacyJNAPService.nodesFirmwareUpdate:
      break;
    case LegacyJNAPService.nodesTopologyOptimization:
      _betterActionMap[LegacyJNAPAction.getTopologyOptimizationSettings] =
          LegacyJNAPActionValue.getTopologyOptimizationSettings.value;
      _betterActionMap[LegacyJNAPAction.setTopologyOptimizationSettings] =
          LegacyJNAPActionValue.setTopologyOptimizationSettings.value;
      break;
    case LegacyJNAPService.nodesTopologyOptimization2:
      _betterActionMap[LegacyJNAPAction.getTopologyOptimizationSettings] =
          LegacyJNAPActionValue.getTopologyOptimizationSettings2.value;
      _betterActionMap[LegacyJNAPAction.setTopologyOptimizationSettings] =
          LegacyJNAPActionValue.setTopologyOptimizationSettings2.value;
      break;
    case LegacyJNAPService.iptv:
      break;
    case LegacyJNAPService.mlo:
      break;
    case LegacyJNAPService.dfs:
      break;
    case LegacyJNAPService.airtimeFairness:
      break;
    case LegacyJNAPService.diagnostics:
      break;
    case LegacyJNAPService.diagnostics2:
      break;
    case LegacyJNAPService.diagnostics3:
      break;
    case LegacyJNAPService.diagnostics7:
      break;
    case LegacyJNAPService.diagnostics8:
      break;
    case LegacyJNAPService.diagnostics9:
      break;
    case LegacyJNAPService.diagnostics10:
      _betterActionMap[LegacyJNAPAction.getSystemStats] =
          LegacyJNAPActionValue.getSystemStats2.value;
      break;
    case LegacyJNAPService.settings:
      break;
    case LegacyJNAPService.settings2:
      // _betterActionMap[JNAPAction.getCloudServerStatus] =
      //     _JNAPActionValue.getCloudServerStatus.value;
      break;
    case LegacyJNAPService.settings3:
      break;
    case LegacyJNAPService.vpn:
      break;
  }
}

// Set an initial value (lowest version) to each JNAP action
void initBetterActions() {
  _betterActionMap[LegacyJNAPAction.transaction] =
      LegacyJNAPActionValue.transaction.value;
  _betterActionMap[LegacyJNAPAction.checkAdminPassword] =
      LegacyJNAPActionValue.checkAdminPassword.value;
  _betterActionMap[LegacyJNAPAction.pnpCheckAdminPassword] =
      LegacyJNAPActionValue.checkAdminPassword2.value;
  _betterActionMap[LegacyJNAPAction.pnpSetAdminPassword] =
      LegacyJNAPActionValue.coreSetAdminPassword2.value;
  _betterActionMap[LegacyJNAPAction.coreSetAdminPassword] =
      LegacyJNAPActionValue.coreSetAdminPassword.value;
  _betterActionMap[LegacyJNAPAction.getAdminPasswordAuthStatus] =
      LegacyJNAPActionValue.getAdminPasswordAuthStatus.value;
  _betterActionMap[LegacyJNAPAction.getAdminPasswordHint] =
      LegacyJNAPActionValue.getAdminPasswordHint.value;
  _betterActionMap[LegacyJNAPAction.getDataUploadUserConsent] =
      LegacyJNAPActionValue.getDataUploadUserConsent.value;
  _betterActionMap[LegacyJNAPAction.getDeviceInfo] =
      LegacyJNAPActionValue.getDeviceInfo.value;
  _betterActionMap[LegacyJNAPAction.getUnsecuredWiFiWarning] =
      LegacyJNAPActionValue.getUnsecuredWiFiWarning.value;
  _betterActionMap[LegacyJNAPAction.setUnsecuredWiFiWarning] =
      LegacyJNAPActionValue.setUnsecuredWiFiWarning.value;
  _betterActionMap[LegacyJNAPAction.isAdminPasswordDefault] =
      LegacyJNAPActionValue.isAdminPasswordDefault.value;
  _betterActionMap[LegacyJNAPAction.isServiceSupported] =
      LegacyJNAPActionValue.isServiceSupported.value;
  _betterActionMap[LegacyJNAPAction.reboot] =
      LegacyJNAPActionValue.reboot.value;
  _betterActionMap[LegacyJNAPAction.reboot2] =
      LegacyJNAPActionValue.reboot2.value;
  _betterActionMap[LegacyJNAPAction.factoryReset] =
      LegacyJNAPActionValue.factoryReset.value;
  _betterActionMap[LegacyJNAPAction.factoryReset2] =
      LegacyJNAPActionValue.factoryReset2.value;
  _betterActionMap[LegacyJNAPAction.getDDNSSettings] =
      LegacyJNAPActionValue.getDDNSSettings.value;
  _betterActionMap[LegacyJNAPAction.getDDNSStatus] =
      LegacyJNAPActionValue.getDDNSStatus.value;
  _betterActionMap[LegacyJNAPAction.getSupportedDDNSProviders] =
      LegacyJNAPActionValue.getSupportedDDNSProviders.value;
  _betterActionMap[LegacyJNAPAction.setDDNSSetting] =
      LegacyJNAPActionValue.setDDNSSetting.value;
  _betterActionMap[LegacyJNAPAction.getDevices] =
      LegacyJNAPActionValue.getDevices.value;
  _betterActionMap[LegacyJNAPAction.getLocalDevice] =
      LegacyJNAPActionValue.getLocalDevice.value;
  _betterActionMap[LegacyJNAPAction.setDeviceProperties] =
      LegacyJNAPActionValue.setDeviceProperties.value;
  _betterActionMap[LegacyJNAPAction.deleteDevice] =
      LegacyJNAPActionValue.deleteDevice.value;
  _betterActionMap[LegacyJNAPAction.execSysCommand] =
      LegacyJNAPActionValue.execSysCommand.value;
  _betterActionMap[LegacyJNAPAction.getPingStatus] =
      LegacyJNAPActionValue.getPingStatus.value;
  _betterActionMap[LegacyJNAPAction.getSysInfoData] =
      LegacyJNAPActionValue.getSysInfoData.value;
  _betterActionMap[LegacyJNAPAction.getSystemStats] =
      LegacyJNAPActionValue.getSystemStats.value;
  _betterActionMap[LegacyJNAPAction.getTracerouteStatus] =
      LegacyJNAPActionValue.getTracerouteStatus.value;
  _betterActionMap[LegacyJNAPAction.restorePreviousFirmware] =
      LegacyJNAPActionValue.restorePreviousFirmware.value;
  _betterActionMap[LegacyJNAPAction.sendSysinfoEmail] =
      LegacyJNAPActionValue.sendSysinfoEmail.value;
  _betterActionMap[LegacyJNAPAction.startPing] =
      LegacyJNAPActionValue.startPing.value;
  _betterActionMap[LegacyJNAPAction.startTracroute] =
      LegacyJNAPActionValue.startTracroute.value;
  _betterActionMap[LegacyJNAPAction.stopPing] =
      LegacyJNAPActionValue.stopPing.value;
  _betterActionMap[LegacyJNAPAction.stopTracroute] =
      LegacyJNAPActionValue.stopTracroute.value;
  _betterActionMap[LegacyJNAPAction.getPortRangeForwardingRules] =
      LegacyJNAPActionValue.getPortRangeForwardingRules.value;
  _betterActionMap[LegacyJNAPAction.getPortRangeTriggeringRules] =
      LegacyJNAPActionValue.getPortRangeTriggeringRules.value;
  _betterActionMap[LegacyJNAPAction.getSinglePortForwardingRules] =
      LegacyJNAPActionValue.getSinglePortForwardingRules.value;
  _betterActionMap[LegacyJNAPAction.setPortRangeForwardingRules] =
      LegacyJNAPActionValue.setPortRangeForwardingRules.value;
  _betterActionMap[LegacyJNAPAction.setPortRangeTriggeringRules] =
      LegacyJNAPActionValue.setPortRangeTriggeringRules.value;
  _betterActionMap[LegacyJNAPAction.setSinglePortForwardingRules] =
      LegacyJNAPActionValue.setSinglePortForwardingRules.value;
  _betterActionMap[LegacyJNAPAction.getIPv6FirewallRules] =
      LegacyJNAPActionValue.getIPv6FirewallRules.value;
  _betterActionMap[LegacyJNAPAction.setIPv6FirewallRules] =
      LegacyJNAPActionValue.setIPv6FirewallRules.value;
  _betterActionMap[LegacyJNAPAction.getFirewallSettings] =
      LegacyJNAPActionValue.getFirewallSettings.value;
  _betterActionMap[LegacyJNAPAction.setFirewallSettings] =
      LegacyJNAPActionValue.setFirewallSettings.value;
  _betterActionMap[LegacyJNAPAction.getDMZSettings] =
      LegacyJNAPActionValue.getDMZSettings.value;
  _betterActionMap[LegacyJNAPAction.setDMZSettings] =
      LegacyJNAPActionValue.setDMZSettings.value;
  _betterActionMap[LegacyJNAPAction.getALGSettings] =
      LegacyJNAPActionValue.getALGSettings.value;
  _betterActionMap[LegacyJNAPAction.setALGSettings] =
      LegacyJNAPActionValue.setALGSettings.value;
  _betterActionMap[LegacyJNAPAction.getFirmwareUpdateStatus] =
      LegacyJNAPActionValue.getFirmwareUpdateStatus.value;
  _betterActionMap[LegacyJNAPAction.getNodesFirmwareUpdateStatus] =
      LegacyJNAPActionValue.getNodesFirmwareUpdateStatus.value;
  _betterActionMap[LegacyJNAPAction.getFirmwareUpdateSettings] =
      LegacyJNAPActionValue.getFirmwareUpdateSettings.value;
  _betterActionMap[LegacyJNAPAction.setFirmwareUpdateSettings] =
      LegacyJNAPActionValue.setFirmwareUpdateSettings.value;
  _betterActionMap[LegacyJNAPAction.updateFirmwareNow] =
      LegacyJNAPActionValue.updateFirmwareNow.value;
  _betterActionMap[LegacyJNAPAction.nodesUpdateFirmwareNow] =
      LegacyJNAPActionValue.nodesUpdateFirmwareNow.value;
  _betterActionMap[LegacyJNAPAction.getGuestNetworkClients] =
      LegacyJNAPActionValue.getGuestNetworkClients.value;
  _betterActionMap[LegacyJNAPAction.getGuestNetworkSettings] =
      LegacyJNAPActionValue.getGuestNetworkSettings.value;
  _betterActionMap[LegacyJNAPAction.getGuestRadioSettings] =
      LegacyJNAPActionValue.getGuestRadioSettings.value;
  _betterActionMap[LegacyJNAPAction.setGuestNetworkSettings] =
      LegacyJNAPActionValue.setGuestNetworkSettings.value;
  _betterActionMap[LegacyJNAPAction.setGuestRadioSettings] =
      LegacyJNAPActionValue.setGuestRadioSettings.value;
  _betterActionMap[LegacyJNAPAction.clearHealthCheckHistory] =
      LegacyJNAPActionValue.clearHealthCheckHistory.value;
  _betterActionMap[LegacyJNAPAction.getHealthCheckResults] =
      LegacyJNAPActionValue.getHealthCheckResults.value;
  _betterActionMap[LegacyJNAPAction.getHealthCheckStatus] =
      LegacyJNAPActionValue.getHealthCheckStatus.value;
  _betterActionMap[LegacyJNAPAction.getSupportedHealthCheckModules] =
      LegacyJNAPActionValue.getSupportedHealthCheckModules.value;
  _betterActionMap[LegacyJNAPAction.runHealthCheck] =
      LegacyJNAPActionValue.runHealthCheck.value;
  _betterActionMap[LegacyJNAPAction.stopHealthCheck] =
      LegacyJNAPActionValue.stopHealthCheck.value;
  _betterActionMap[LegacyJNAPAction.getLocalTime] =
      LegacyJNAPActionValue.getLocalTime.value;
  _betterActionMap[LegacyJNAPAction.getTimeSettings] =
      LegacyJNAPActionValue.getTimeSettings.value;
  _betterActionMap[LegacyJNAPAction.getLocale] =
      LegacyJNAPActionValue.getLocale.value;
  _betterActionMap[LegacyJNAPAction.setLocale] =
      LegacyJNAPActionValue.setLocale.value;
  _betterActionMap[LegacyJNAPAction.setTimeSettings] =
      LegacyJNAPActionValue.setTimeSettings.value;
  _betterActionMap[LegacyJNAPAction.getMACFilterSettings] =
      LegacyJNAPActionValue.getMACFilterSettings.value;
  _betterActionMap[LegacyJNAPAction.setMACFilterSettings] =
      LegacyJNAPActionValue.setMACFilterSettings.value;
  _betterActionMap[LegacyJNAPAction.getSTABSSIDs] =
      LegacyJNAPActionValue.getSTABSSIDs.value;
  _betterActionMap[LegacyJNAPAction.getActiveMotionSensingBots] =
      LegacyJNAPActionValue.getActiveMotionSensingBots.value;
  _betterActionMap[LegacyJNAPAction.getMotionSensingSettings] =
      LegacyJNAPActionValue.getMotionSensingSettings.value;
  _betterActionMap[LegacyJNAPAction.getNetworkConnections] =
      LegacyJNAPActionValue.getNetworkConnections.value;
  _betterActionMap[LegacyJNAPAction.getNetworkSecuritySettings] =
      LegacyJNAPActionValue.getNetworkSecuritySettings.value;
  _betterActionMap[LegacyJNAPAction.setNetworkSecuritySettings] =
      LegacyJNAPActionValue.setNetworkSecuritySettings.value;
  _betterActionMap[LegacyJNAPAction.getBackhaulInfo] =
      LegacyJNAPActionValue.getBackhaulInfo.value;
  _betterActionMap[LegacyJNAPAction.getNodeNeighborInfo] =
      LegacyJNAPActionValue.getNodeNeighborInfo.value;
  _betterActionMap[LegacyJNAPAction.getSlaveBackhaulStatus] =
      LegacyJNAPActionValue.getSlaveBackhaulStatus.value;
  _betterActionMap[LegacyJNAPAction.refreshSlaveBackhaulData] =
      LegacyJNAPActionValue.refreshSlaveBackhaulData.value;
  _betterActionMap[LegacyJNAPAction.getNodesWirelessNetworkConnections] =
      LegacyJNAPActionValue.getNodesWirelessNetworkConnections.value;
  _betterActionMap[LegacyJNAPAction.getOwnedNetworkID] =
      LegacyJNAPActionValue.getOwnedNetworkID.value;
  _betterActionMap[LegacyJNAPAction.isOwnedNetwork] =
      LegacyJNAPActionValue.isOwnedNetwork.value;
  _betterActionMap[LegacyJNAPAction.setNetworkOwner] =
      LegacyJNAPActionValue.setNetworkOwner.value;
  _betterActionMap[LegacyJNAPAction.getParentalControlSettings] =
      LegacyJNAPActionValue.getParentalControlSettings.value;
  _betterActionMap[LegacyJNAPAction.getPowerTableSettings] =
      LegacyJNAPActionValue.getPowerTableSettings.value;
  _betterActionMap[LegacyJNAPAction.setPowerTableSettings] =
      LegacyJNAPActionValue.setPowerTableSettings.value;
  _betterActionMap[LegacyJNAPAction.getSoftSKUSettings] =
      LegacyJNAPActionValue.getSoftSKUSettings.value;
  _betterActionMap[LegacyJNAPAction.getQoSSettings] =
      LegacyJNAPActionValue.getQoSSettings.value;
  _betterActionMap[LegacyJNAPAction.getDHCPClientLeases] =
      LegacyJNAPActionValue.getDHCPClientLeases.value;
  _betterActionMap[LegacyJNAPAction.getIPv6Settings] =
      LegacyJNAPActionValue.getIPv6Settings.value;
  _betterActionMap[LegacyJNAPAction.getLANSettings] =
      LegacyJNAPActionValue.getLANSettings.value;
  _betterActionMap[LegacyJNAPAction.getRoutingSettings] =
      LegacyJNAPActionValue.getRoutingSettings.value;
  _betterActionMap[LegacyJNAPAction.getMACAddressCloneSettings] =
      LegacyJNAPActionValue.getMACAddressCloneSettings.value;
  _betterActionMap[LegacyJNAPAction.getWANSettings] =
      LegacyJNAPActionValue.getWANSettings.value;
  _betterActionMap[LegacyJNAPAction.getWANStatus] =
      LegacyJNAPActionValue.getWANStatus.value;
  _betterActionMap[LegacyJNAPAction.setIPv6Settings] =
      LegacyJNAPActionValue.setIPv6Settings.value;
  _betterActionMap[LegacyJNAPAction.setMACAddressCloneSettings] =
      LegacyJNAPActionValue.setMACAddressCloneSettings.value;
  _betterActionMap[LegacyJNAPAction.setWANSettings] =
      LegacyJNAPActionValue.setWANSettings.value;
  _betterActionMap[LegacyJNAPAction.setLANSettings] =
      LegacyJNAPActionValue.setLANSettings.value;
  _betterActionMap[LegacyJNAPAction.setRoutingSettings] =
      LegacyJNAPActionValue.setRoutingSettings.value;
  _betterActionMap[LegacyJNAPAction.getManagementSettings] =
      LegacyJNAPActionValue.getManagementSettings.value;
  _betterActionMap[LegacyJNAPAction.setManagementSettings] =
      LegacyJNAPActionValue.setManagementSettings.value;
  _betterActionMap[LegacyJNAPAction.isAdminPasswordSetByUser] =
      LegacyJNAPActionValue.isAdminPasswordSetByUser.value;
  _betterActionMap[LegacyJNAPAction.setupSetAdminPassword] =
      LegacyJNAPActionValue.setupSetAdminPassword.value;
  _betterActionMap[LegacyJNAPAction.verifyRouterResetCode] =
      LegacyJNAPActionValue.verifyRouterResetCode.value;
  _betterActionMap[LegacyJNAPAction.getVersionInfo] =
      LegacyJNAPActionValue.getVersionInfo.value;
  _betterActionMap[LegacyJNAPAction.getDeviceMode] =
      LegacyJNAPActionValue.getDeviceMode.value;
  _betterActionMap[LegacyJNAPAction.getSupportedDeviceMode] =
      LegacyJNAPActionValue.getSupportedDeviceModes.value;
  _betterActionMap[LegacyJNAPAction.setDeviceMode] =
      LegacyJNAPActionValue.setDeviceMode.value;
  _betterActionMap[LegacyJNAPAction.getRadioInfo] =
      LegacyJNAPActionValue.getRadioInfo.value;
  _betterActionMap[LegacyJNAPAction.getWPSServerSessionStatus] =
      LegacyJNAPActionValue.getWPSServerSessionStatus.value;
  _betterActionMap[LegacyJNAPAction.setRadioSettings] =
      LegacyJNAPActionValue.setRadioSettings.value;
  _betterActionMap[LegacyJNAPAction.getWirelessSchedulerSettings] =
      LegacyJNAPActionValue.getWirelessSchedulerSettings.value;
  _betterActionMap[LegacyJNAPAction.getWANDetectionStatus] =
      LegacyJNAPActionValue.getWANDetectionStatus.value;
  _betterActionMap[LegacyJNAPAction.getPortConnectionStatus] =
      LegacyJNAPActionValue.getPortConnectionStatus.value;
  _betterActionMap[LegacyJNAPAction.getWANPort] =
      LegacyJNAPActionValue.getWANPort.value;
  _betterActionMap[LegacyJNAPAction.setWANPort] =
      LegacyJNAPActionValue.setWANPort.value;
  _betterActionMap[LegacyJNAPAction.getInternetConnectionStatus] =
      LegacyJNAPActionValue.getInternetConnectionStatus.value;
  _betterActionMap[LegacyJNAPAction.getSimpleWiFiSettings] =
      LegacyJNAPActionValue.getSimpleWiFiSettings.value;
  _betterActionMap[LegacyJNAPAction.setSimpleWiFiSettings] =
      LegacyJNAPActionValue.setSimpleWiFiSettings.value;
  _betterActionMap[LegacyJNAPAction.getMACAddress] =
      LegacyJNAPActionValue.getMACAddress.value;
  _betterActionMap[LegacyJNAPAction.releaseDHCPWANLease] =
      LegacyJNAPActionValue.releaseDHCPWANLease.value;
  _betterActionMap[LegacyJNAPAction.releaseDHCPIPv6WANLease] =
      LegacyJNAPActionValue.releaseDHCPIPv6WANLease.value;
  _betterActionMap[LegacyJNAPAction.renewDHCPWANLease] =
      LegacyJNAPActionValue.renewDHCPWANLease.value;
  _betterActionMap[LegacyJNAPAction.renewDHCPIPv6WANLease] =
      LegacyJNAPActionValue.renewDHCPIPv6WANLease.value;
  _betterActionMap[LegacyJNAPAction.getEthernetPortConnections] =
      LegacyJNAPActionValue.getEthernetPortConnections.value;
  _betterActionMap[LegacyJNAPAction.btGetScanUnconfiguredResult] =
      LegacyJNAPActionValue.btGetScanUnconfiguredResult2.value;
  _betterActionMap[LegacyJNAPAction.btRequestScanUnconfigured] =
      LegacyJNAPActionValue.btRequestScanUnconfigured2.value;
  _betterActionMap[LegacyJNAPAction.getBluetoothAutoOnboardingSettings] =
      LegacyJNAPActionValue.getBluetoothAutoOnboardingSettings.value;
  _betterActionMap[LegacyJNAPAction.setBluetoothAutoOnboardingSettings] =
      LegacyJNAPActionValue.setBluetoothAutoOnboardingSettings.value;
  _betterActionMap[LegacyJNAPAction.getBluetoothAutoOnboardingStatus] =
      LegacyJNAPActionValue.getBluetoothAutoOnboardingStatus.value;
  _betterActionMap[LegacyJNAPAction.startBlueboothAutoOnboarding] =
      LegacyJNAPActionValue.startBluetoothAutoOnboarding.value;
  _betterActionMap[LegacyJNAPAction.getVLANTaggingSettings] =
      LegacyJNAPActionValue.getVLANTaggingSettings.value;
  _betterActionMap[LegacyJNAPAction.setVLANTaggingSettings] =
      LegacyJNAPActionValue.setVLANTaggingSettings.value;
  _betterActionMap[LegacyJNAPAction.startBlinkNodeLed] =
      LegacyJNAPActionValue.startBlinkingNodeLed.value;
  _betterActionMap[LegacyJNAPAction.stopBlinkNodeLed] =
      LegacyJNAPActionValue.stopBlinkingNodeLed.value;
  _betterActionMap[LegacyJNAPAction.getLedNightModeSetting] =
      LegacyJNAPActionValue.getLedNightModeSetting.value;
  _betterActionMap[LegacyJNAPAction.setLedNightModeSetting] =
      LegacyJNAPActionValue.setLedNightModeSetting.value;
  _betterActionMap[LegacyJNAPAction.startBlinkingNodeLed] =
      LegacyJNAPActionValue.startBlinkingNodeLed.value;
  _betterActionMap[LegacyJNAPAction.stopBlinkingNodeLed] =
      LegacyJNAPActionValue.stopBlinkingNodeLed.value;
  _betterActionMap[LegacyJNAPAction.getTopologyOptimizationSettings] =
      LegacyJNAPActionValue.getTopologyOptimizationSettings.value;
  _betterActionMap[LegacyJNAPAction.setTopologyOptimizationSettings] =
      LegacyJNAPActionValue.setTopologyOptimizationSettings.value;
  _betterActionMap[LegacyJNAPAction.getIptvSettings] =
      LegacyJNAPActionValue.getIptvSettings.value;
  _betterActionMap[LegacyJNAPAction.setIptvSettings] =
      LegacyJNAPActionValue.setIptvSettings.value;
  _betterActionMap[LegacyJNAPAction.getMLOSettings] =
      LegacyJNAPActionValue.getMLOSettings.value;
  _betterActionMap[LegacyJNAPAction.setMLOSettings] =
      LegacyJNAPActionValue.setMLOSettings.value;
  _betterActionMap[LegacyJNAPAction.getDFSSettings] =
      LegacyJNAPActionValue.getDFSSettings.value;
  _betterActionMap[LegacyJNAPAction.setDFSSettings] =
      LegacyJNAPActionValue.setDFSSettings.value;
  _betterActionMap[LegacyJNAPAction.getAirtimeFairnessSettings] =
      LegacyJNAPActionValue.getAirtimeFairnessSettings.value;
  _betterActionMap[LegacyJNAPAction.setAirtimeFairnessSettings] =
      LegacyJNAPActionValue.setAirtimeFairnessSettings.value;
  _betterActionMap[LegacyJNAPAction.getSelectedChannels] =
      LegacyJNAPActionValue.getSelectedChannels.value;
  _betterActionMap[LegacyJNAPAction.startAutoChannelSelection] =
      LegacyJNAPActionValue.startAutoChannelSelection.value;
  _betterActionMap[LegacyJNAPAction.getRemoteSetting] =
      LegacyJNAPActionValue.getRemoteSetting.value;
  _betterActionMap[LegacyJNAPAction.setRemoteSetting] =
      LegacyJNAPActionValue.setRemoteSetting.value;
  _betterActionMap[LegacyJNAPAction.getGamingPrioritizationSettings] =
      LegacyJNAPActionValue.getGamingPrioritizationSettings.value;
  _betterActionMap[LegacyJNAPAction.setGamingPrioritizationSettings] =
      LegacyJNAPActionValue.setGamingPrioritizationSettings.value;
  _betterActionMap[LegacyJNAPAction.getAutoConfigurationSettings] =
      LegacyJNAPActionValue.getAutoConfigurationSettings.value;
  _betterActionMap[LegacyJNAPAction.setUserAcknowledgedAutoConfiguration] =
      LegacyJNAPActionValue.setUserAcknowledgedAutoConfiguration.value;
  _betterActionMap[LegacyJNAPAction.getUPnPSettings] =
      LegacyJNAPActionValue.getUPnPSettings.value;
  _betterActionMap[LegacyJNAPAction.setUPnPSettings] =
      LegacyJNAPActionValue.setUPnPSettings.value;
  // vpn
  _betterActionMap[LegacyJNAPAction.getVPNUser] =
      LegacyJNAPActionValue.getVPNUser.value;
  _betterActionMap[LegacyJNAPAction.setVPNUser] =
      LegacyJNAPActionValue.setVPNUser.value;
  _betterActionMap[LegacyJNAPAction.getVPNGateway] =
      LegacyJNAPActionValue.getVPNGateway.value;
  _betterActionMap[LegacyJNAPAction.setVPNGateway] =
      LegacyJNAPActionValue.setVPNGateway.value;
  _betterActionMap[LegacyJNAPAction.getVPNService] =
      LegacyJNAPActionValue.getVPNService.value;
  _betterActionMap[LegacyJNAPAction.setVPNService] =
      LegacyJNAPActionValue.setVPNService.value;
  _betterActionMap[LegacyJNAPAction.testVPNConnection] =
      LegacyJNAPActionValue.testVPNConnection.value;
  _betterActionMap[LegacyJNAPAction.getTunneledUser] =
      LegacyJNAPActionValue.getTunneledUser.value;
  _betterActionMap[LegacyJNAPAction.setTunneledUser] =
      LegacyJNAPActionValue.setTunneledUser.value;
  _betterActionMap[LegacyJNAPAction.setVPNApply] =
      LegacyJNAPActionValue.setVPNApply.value;
}

@deprecated
void buildBetterActions(List<String> routerServices) {
  initBetterActions();
  final List<LegacyJNAPService> supportedServices = routerServices
      .where((routerService) => LegacyJNAPService.appSupportedServices
          .any((supportedService) => routerService == supportedService.value))
      .map((service) => LegacyJNAPService.appSupportedServices
          .firstWhere((supportedService) => supportedService.value == service))
      .toList();
  final serviceMap = _groupAndSortJNAPServices(supportedServices);
  final sortedServiceList =
      serviceMap.values.reduce((all, value) => all..addAll(value));
  for (final service in sortedServiceList) {
    _updateBetterActions(service);
  }
}

Map<String, List<LegacyJNAPService>> _groupAndSortJNAPServices(
    List<LegacyJNAPService> services) {
  final groupedServices =
      groupBy<LegacyJNAPService, String>(services, (service) {
    final name = service.name;
    final match = RegExp(r'(\d+)').firstMatch(name);
    if (match != null) {
      return name.substring(0, name.indexOf(match.group(0)!));
    }
    return name;
  });

  final sortedGroupedServices = <String, List<LegacyJNAPService>>{};

  groupedServices.forEach((key, value) {
    sortedGroupedServices[key] = value.sorted((a, b) {
      final aMatch = RegExp(r'(\d+)').firstMatch(a.name);
      final bMatch = RegExp(r'(\d+)').firstMatch(b.name);

      if (aMatch != null && bMatch != null) {
        return int.parse(aMatch.group(1)!)
            .compareTo(int.parse(bMatch.group(1)!));
      } else if (aMatch != null) {
        return 1;
      } else if (bMatch != null) {
        return -1;
      } else {
        return a.name.compareTo(b.name);
      }
    }).toList();
  });

  return sortedGroupedServices;
}
