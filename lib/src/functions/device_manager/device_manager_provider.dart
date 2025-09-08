import 'package:jnap/logger.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/service/backhaul_info_service.dart';
import 'package:jnap/src/functions/device_manager/service/devices_service.dart';
import 'package:jnap/src/functions/device_manager/service/network_connections_service.dart';
import 'package:jnap/src/functions/device_manager/service/radio_info_service.dart';
import 'package:jnap/src/functions/device_manager/service/wan_status_service.dart';
import 'package:jnap/src/functions/polling/polling_provider.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:jnap/src/utilties/nodes/icon_device_category.dart';
import 'package:riverpod/riverpod.dart';

final deviceManagerProvider =
    NotifierProvider<DeviceManagerNotifier, DeviceManagerState>(
  () => DeviceManagerNotifier(),
);

class DeviceManagerNotifier extends Notifier<DeviceManagerState> {
  @override
  DeviceManagerState build() {
    final coreTransactionData = ref.watch(pollingProvider).value;
    return createState(pollingResult: coreTransactionData);
  }

  void init() {
    state = DeviceManagerState();
  }

  DeviceManagerState createState({CoreTransactionData? pollingResult}) {
    // Init services
    final networkConnectionsService = NetworkConnectionsService(ref);
    final devicesService = DevicesService(ref);
    final wanStatusService = WANStatusService(ref);
    final backhaulInfoService = BackhaulInfoService(ref);
    final radioInfoService = RadioInfoService(ref);

    // Fetch cache data
    final lastUpdate = ref.read(pollingProvider).value?.lastUpdate;
    final getDevicesData = devicesService.getDevicesFromCache();
    final getWANStatusData = wanStatusService.getWANStatusFromCache();
    final List<Layer2Connection> connectionData =
        networkConnectionsService.getNetworkConnectionsFromCache();
    final radioInfoMap = radioInfoService.getRadioInfoMapFromCache();
    final guestRadioSettings =
        radioInfoService.getGuestRadioSettingsFromCache();

    // Start building state
    var newState = const DeviceManagerState();
    // Backhaul Info
    List<BackHaulInfoData> backhaulInfoList =
        backhaulInfoService.getBackhaulInfoList();
    // WAN Status
    RouterWANStatus? wanStatus =
        wanStatusService.getWANStatusModel(getWANStatusData);
    // Wireless Connections
    Map<String, WirelessConnection> wirelessConnections =
        networkConnectionsService.getWirelessConnections(connectionData);
    wirelessConnections =
        networkConnectionsService.updateWirelessConnectionsWithBackhaulInfo(
            wirelessConnections: wirelessConnections,
            backhaulInfoList: backhaulInfoList);
    // The data process of NetworkConnections MUST be done before building device list
    // Device List
    List<LinksysDevice> deviceList = devicesService.getDeviceListAndLocations(
        getDevicesData, wirelessConnections);
    deviceList = devicesService.updateDeviceIpWithBackhaulInfo(
        deviceList: deviceList, backhaulInfoList: backhaulInfoList);
    deviceList =
        devicesService.updateDeviceWirelessSignalWithWirelessConnections(
            deviceList: deviceList, wirelessConnections: wirelessConnections);
    // For getting the master device, update the state
    newState = newState.copyWith(
      wirelessConnections: wirelessConnections,
      deviceList: deviceList,
      wanStatus: wanStatus,
      radioInfos: radioInfoMap,
      guestRadioSettings: guestRadioSettings,
      backhaulInfoData: backhaulInfoList,
      lastUpdateTime: lastUpdate,
    );
    // Update device upstream
    deviceList = devicesService.updateDeviceUpstream(
        deviceList: deviceList,
        masterDevice: newState.masterDevice,
        backhaulInfoList: backhaulInfoList);

    // Update the state with latest device list
    newState = newState.copyWith(
      deviceList: deviceList,
    );
    return newState;
  }

  // Used in cases where the watched DeviceManager is still empty at very beginning stage
  bool isEmptyState() => state.deviceList.isEmpty;

  String? getSsidConnectedBy(LinksysDevice device) {
    return DevicesService(ref).getSsidConnectedBy(
      device: device,
      wirelessConnections: state.wirelessConnections,
      radioInfoMap: state.radioInfos,
      guestRadioSettings: state.guestRadioSettings,
    );
  }

  String getBandConnectedBy(LinksysDevice device) {
    return DevicesService(ref).getBandConnectedBy(
      device: device,
      wirelessConnections: state.wirelessConnections,
    );
  }

  // Update the name(location) of nodes and external devices
  Future<void> updateDeviceNameAndIcon({
    required String targetId,
    required String newName,
    required bool isLocation,
    IconDeviceCategory? icon,
  }) async {
    final newDeviceList = await DevicesService(ref)
        .updateDeviceNameAndIcon(
      deviceList: state.deviceList,
      targetId: targetId,
      newName: newName,
      isLocation: isLocation,
      icon: icon,
    )
        .onError((error, stackTrace) {
      logger.e(
        '[Device Manager]: Update device name and icon failed, Error: $error, \n$stackTrace',
      );
      return state.deviceList;
    });
    state = state.copyWith(deviceList: newDeviceList);
  }

  Future<void> deleteDevices({required List<String> deviceIds}) async {
    await DevicesService(ref)
        .deleteDevices(deviceIds: deviceIds, deviceList: state.deviceList)
        .then((newDeviceList) {
      state = state.copyWith(
        deviceList: newDeviceList,
      );
      ref.read(pollingProvider.notifier).forcePolling();
    }).onError((error, stackTrace) {
      logger.e(
          '[Device Manager]: Delete devices failed, Error: $error, \n$stackTrace');
    });
  }

  Future<void> deauthClient({required String macAddress}) async {
    await DevicesService(ref)
        .deauthClient(macAddress: macAddress)
        .then((value) => ref.read(pollingProvider.notifier).forcePolling());
  }
}
