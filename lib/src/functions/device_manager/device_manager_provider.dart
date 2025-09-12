import 'package:jnap/logger.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/functions/device_manager/service/backhaul_info_service.dart';
import 'package:jnap/src/functions/device_manager/service/devices_service.dart';
import 'package:jnap/src/functions/device_manager/service/network_connections_service.dart';
import 'package:jnap/src/functions/device_manager/service/radio_info_service.dart';
import 'package:jnap/src/functions/device_manager/service/wan_status_service.dart';
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
  DeviceManagerState build() => DeviceManagerState();

  void init() {
    state = DeviceManagerState();
  }

  Future<void> fetch() async {
    // Init services
    final radioInfoService = RadioInfoService(ref);
    final backhaulInfoService = BackhaulInfoService(ref);
    final wanStatusService = WANStatusService(ref);
    final networkConnectionsService = NetworkConnectionsService(ref);
    final devicesService = DevicesService(ref);

    // Polling last update time
    final lastUpdate = ref.read(pollingProvider).value?.lastUpdate;
    // Radio info
    final radioInfoMap = await radioInfoService.getRadioInfoMap();
    final guestRadioSettings =
        await radioInfoService.getGuestRadioSettingsData();
    // Backhaul Info
    List<BackHaulInfoData> backhaulInfoList =
        await backhaulInfoService.getBackhaulInfoList();
    // WAN Status
    RouterWANStatus wanStatus = await wanStatusService.getWANStatusData();
    // Wireless Connections
    final List<Layer2Connection> connectionsList =
        await networkConnectionsService.getNetworkConnectionsList();
    Map<String, WirelessConnection> wirelessConnections =
        networkConnectionsService.getWirelessConnectionsMap(
            connectionsList: connectionsList);
    wirelessConnections =
        networkConnectionsService.updateWirelessConnectionsWithBackhaulInfo(
      wirelessConnections: wirelessConnections,
      backhaulInfoList: backhaulInfoList,
    );
    // The data process of NetworkConnections MUST be done before building device list
    // Device List
    final getDevicesData = (await devicesService.getDevices()).output;
    List<LinksysDevice> deviceList = devicesService.getDeviceListAndLocations(
        getDevicesData, wirelessConnections);
    deviceList
        .updateIpWithBackhaulInfo(devicesService, backhaulInfoList)
        .updateWirelessSignal(devicesService, wirelessConnections)
        .updateUpstream(
            devicesService,
            deviceList.firstWhere((device) => device.isMasterDevice),
            backhaulInfoList);

    // Update state
    state = state.copyWith(
      wirelessConnections: wirelessConnections,
      deviceList: deviceList,
      wanStatus: wanStatus,
      radioInfos: radioInfoMap,
      guestRadioSettings: guestRadioSettings,
      backhaulInfoData: backhaulInfoList,
      lastUpdateTime: lastUpdate,
    );
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
