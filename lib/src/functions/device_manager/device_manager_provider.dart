import 'package:collection/collection.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/device_manager_service.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/functions/polling/polling_provider.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/node_wireless_connection.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
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
    Map<String, dynamic>? getNetworkConnectionsData;
    Map<String, dynamic>? getNodesWirelessNetworkConnectionsData;
    Map<String, dynamic>? getRadioInfo;
    Map<String, dynamic>? guestRadioSettings;
    Map<String, dynamic>? getDevicesData;
    Map<String, dynamic>? getWANStatusData;
    Map<String, dynamic>? getBackHaulInfoData;

    final result = pollingResult?.data;
    if (result != null) {
      getNetworkConnectionsData =
          (result[GetNetworkConnections.instance] as JNAPSuccess?)?.output;
      getNodesWirelessNetworkConnectionsData =
          (result[GetNodesWirelessNetworkConnections.instance] as JNAPSuccess?)
              ?.output;
      getRadioInfo = (result[GetRadioInfo.instance] as JNAPSuccess?)?.output;
      getDevicesData = (result[GetDevices.instance] as JNAPSuccess?)?.output;
      getWANStatusData =
          (result[GetWANStatus.instance] as JNAPSuccess?)?.output;
      getBackHaulInfoData =
          (result[GetBackhaulInfo.instance] as JNAPSuccess?)?.output;
      guestRadioSettings =
          (result[GetGuestRadioSettings.instance] as JNAPSuccess?)?.output;
    }
    final List<Layer2Connection> connectionData;
    if (getNodesWirelessNetworkConnectionsData != null) {
      final nodeWirelessConnections = List.from(
          getNodesWirelessNetworkConnectionsData['nodeWirelessConnections'] ??
              []);
      connectionData = nodeWirelessConnections.fold<List<Layer2Connection>>([],
          (previousValue, element) {
        final nodeWirelessConnection = NodeWirelessConnections.fromMap(element);

        previousValue.addAll(nodeWirelessConnection.connections);
        return previousValue;
      });
    } else {
      connectionData =
          List.from(getNetworkConnectionsData?['connections'] ?? [])
              .map((e) => Layer2Connection.fromMap(e))
              .toList();
    }

    // Radio settings
    final radioList = List.from(getRadioInfo?['radios'] ?? [])
        .map((e) => RouterRadio.fromMap(e))
        .toList();
    final radioMap =
        Map.fromEntries(radioList.map((e) => MapEntry(e.radioID, e)));

    final deviceManagerService = DeviceManagerService();
    var newState = const DeviceManagerState();
    Map<String, WirelessConnection> wirelessConnections =
        deviceManagerService.getWirelessConnections(connectionData);
    // The data process of NetworkConnections MUST be done before building device list
    List<LinksysDevice> deviceList = deviceManagerService.getDeviceListAndLocations(
        getDevicesData, wirelessConnections);
    RouterWANStatus? wanStatus = deviceManagerService.getWANStatusModel(getWANStatusData);
    newState = _getBackhaukInfoData(newState, getBackHaulInfoData);
    newState = newState.copyWith(radioInfos: radioMap);
    newState = newState.copyWith(
        guestRadioSettings: guestRadioSettings == null
            ? null
            : GuestRadioSettings.fromMap(guestRadioSettings));
    newState = _checkUpstream(newState);

    newState = newState.copyWith(
      wirelessConnections: wirelessConnections,
      deviceList: deviceList,
      wanStatus: wanStatus,
      lastUpdateTime: pollingResult?.lastUpdate,
    );

    return newState;
  }

  DeviceManagerState _getBackhaukInfoData(
    DeviceManagerState state,
    Map<String, dynamic>? data,
  ) {
    var newState = state.copyWith(
      backhaulInfoData: List.from(
        data?['backhaulDevices'] ?? [],
      ).map((e) => BackHaulInfoData.fromMap(e)).toList(),
    );
    // Update IP address
    newState = newState.copyWith(
      deviceList: newState.deviceList.map((device) {
        final deviceId = device.deviceID;
        final backhaulInfo = newState.backhaulInfoData
            .firstWhereOrNull((backhaul) => backhaul.deviceUUID == deviceId);
        if (backhaulInfo != null && device.isOnline()) {
          // Replace the IP in Devices with the one from BackhaulInfo
          final updatedConnections = device.connections
              .map(
                (connection) => connection.copyWith(
                  ipAddress: backhaulInfo.ipAddress,
                ),
              )
              .toList();
          final newDevice = device.copyWith(
            connections: updatedConnections,
            wirelessConnectionInfo: backhaulInfo.wirelessConnectionInfo,
            speedMbps: backhaulInfo.speedMbps,
            connectionType: backhaulInfo.connectionType,
          );
          return newDevice;
        }
        return device;
      }).toList(),
    );
    final wireleeConnectionInfo = newState.wirelessConnections;
    newState.backhaulInfoData
        .where((element) =>
            element.connectionType == 'Wireless' &&
            element.wirelessConnectionInfo != null)
        .forEach((element) {
      final mac = element.wirelessConnectionInfo?.stationBSSID;
      final rssi = element.wirelessConnectionInfo?.stationRSSI;
      final band = element.wirelessConnectionInfo?.radioID;
      final bssid = element.wirelessConnectionInfo?.apBSSID;
      if (mac != null && rssi != null) {
        wireleeConnectionInfo[mac] = WirelessConnection(
          bssid: bssid ?? '',
          isGuest: false,
          radioID: 'RADIO_${band}z',
          band: '${band}z',
          signalDecibels: rssi,
        );
      }
    });
    newState = newState.copyWith(wirelessConnections: wireleeConnectionInfo);

    // update wireless signal for each device
    final devices = newState.deviceList
        .map((e) => e.copyWith(
              signalDecibels: e.wirelessConnectionInfo?.stationRSSI ??
                  _getWirelessSignalOf(e, state),
              connectedDevices: e.connectedDevices
                  .map((e) => e.copyWith(
                      signalDecibels: _getWirelessSignalOf(e, state)))
                  .toList(),
            ))
        .toList();
    newState = newState.copyWith(deviceList: devices);
    return newState;
  }

  DeviceManagerState _checkUpstream(
    DeviceManagerState state,
  ) {
    return state.copyWith(
        deviceList: List<LinksysDevice>.from(state.deviceList)
            .map((e) => e.isAuthority
                ? e
                : e.copyWith(upstream: findParent(e.deviceID, state)))
            .toList());
  }

  // Used in cases where the watched DeviceManager is still empty at very beginning stage
  bool isEmptyState() => state.deviceList.isEmpty;

  String? getSsidConnectedBy(LinksysDevice device) {
    // Get the SSID to the RadioID connected by the given device
    final wirelessConnections = state.wirelessConnections;
    final wirelessData = wirelessConnections[device.getMacAddress()];
    final radioID = wirelessData?.radioID;

    /// if connection type is guest just ruturn any one of ssid, because it is all the same
    return device.connectedWifiType == WifiConnectionType.guest
        ? state.guestRadioSettings?.radios.firstOrNull?.guestSSID
        : state.radioInfos[radioID]?.settings.ssid;
  }

  int? _getWirelessSignalOf(RawDevice device,
      [DeviceManagerState? currentState]) {
    final wirelessConnections = (currentState ?? state).wirelessConnections;
    final wirelessData = wirelessConnections[device.getMacAddress()];
    final signalDecibels = wirelessData?.signalDecibels;
    return signalDecibels;
  }

  String getBandConnectedBy(LinksysDevice device) {
    final wirelessConnections = state.wirelessConnections;
    final wirelessData = wirelessConnections[device.getMacAddress()];
    // If the band data is absent in (NodesWireless)NetworkConnection,
    // check the knownInterface in GetDevices
    final band = wirelessData?.band ?? _getBandFromKnownInterfacesOf(device);
    return band ??
        (device.getConnectionType() == DeviceConnectionType.wired
            ? 'Ethernet'
            : '');
  }

  String? _getBandFromKnownInterfacesOf(RawDevice device) {
    return device.knownInterfaces
        ?.firstWhereOrNull(
            (knownInterface) => knownInterface.interfaceType == 'Wireless')
        ?.band;
  }

  LinksysDevice? findParent(String deviceID, [DeviceManagerState? current]) {
    final currentState = current ?? state;
    final master = currentState.masterDevice;
    final device = currentState.deviceList
        .firstWhereOrNull((element) => element.deviceID == deviceID);
    if (device == null) {
      return null;
    }
    if (!device.isOnline()) {
      return null;
    }
    String? parentIpAddr;

    // Check connections from backhaul info data.
    for (var element in device.connections) {
      for (var backhaul in currentState.backhaulInfoData) {
        if (backhaul.ipAddress == element.ipAddress) {
          parentIpAddr = backhaul.parentIPAddress;
          break;
        }
      }
    }
    //
    if (parentIpAddr != null) {
      return currentState.deviceList.firstWhereOrNull((element) =>
              element.connections.firstWhereOrNull(
                  (element) => element.ipAddress == parentIpAddr) !=
              null) ??
          master;
    }
    //
    // There usually be only one item
    final parentDeviceId = device.connections.firstOrNull?.parentDeviceID;
    // Count it if this item's parentId is the target node,
    // or if its parentId is null and the target node is master
    return currentState.deviceList.firstWhereOrNull(
            (element) => parentDeviceId == element.deviceID) ??
        (device.nodeType != null ? master : null);
  }

  // Update the name(location) of nodes and external devices
  Future<void> updateDeviceNameAndIcon({
    required String targetId,
    required String newName,
    required bool isLocation,
    IconDeviceCategory? icon,
  }) async {
    List<RawDeviceProperty> properties = [
      RawDeviceProperty(name: 'userDeviceName', value: newName),
      if (isLocation)
        RawDeviceProperty(name: 'userDeviceLocation', value: newName),
      if (icon != null)
        RawDeviceProperty(name: 'userDeviceType', value: icon.name),
    ];
    final result = await Jnap.instance.send(
      action: SetDeviceProperties.instance,
      data: {
        'deviceID': targetId,
        'propertiesToModify': properties.map((e) => e.toMap()).toList(),
      },
    );
    await Jnap.instance.send(
      action: GetDevices.instance,
      overrides: JNAPConfigOverrides(
        forceRemote: true,
      ),
    );
    if (result.result == 'OK') {
      final newList = state.deviceList.fold(<LinksysDevice>[], (list, element) {
        if (element.deviceID == targetId) {
          list.add(element.copyWith(properties: properties));
        } else {
          list.add(element);
        }
        return list;
      });
      state = state.copyWith(deviceList: newList);
    }
  }

  Future<void> deleteDevices({required List<String> deviceIds}) {
    return routerRepository.deleteDevices(deviceIds).then((dataResults) {
      final idResults = Map.fromIterables(deviceIds, dataResults)
          .entries
          .map((entry) => MapEntry(entry.key, entry.value.value));
      final idResultsMap = Map.fromEntries(idResults);
      idResultsMap.removeWhere((key, value) => value.result != 'OK');
      final completedIds = idResultsMap.keys.toList();
      final newDeviceList = List<LinksysDevice>.from(state.deviceList);
      newDeviceList.removeWhere(
        (device) => completedIds.contains(device.deviceID),
      );
      state = state.copyWith(
        deviceList: newDeviceList,
      );
    }).then((value) => ref.read(pollingProvider.notifier).forcePolling());
  }

  Future<void> deauthClient({required String macAddress}) async {
    await Jnap.instance
        .send(
          action: ClientDeauth.instance,
          data: {
            'macAddress': macAddress,
          }..removeWhere((key, value) => value == null),
          overrides: JNAPConfigOverrides(forceRemote: true, cached: false),
        )
        .then((value) => ref.read(pollingProvider.notifier).forcePolling());
  }
}
