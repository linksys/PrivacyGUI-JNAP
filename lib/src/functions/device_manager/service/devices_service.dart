import 'package:collection/collection.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/logger.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:jnap/src/utilties/nodes/icon_device_category.dart';
import 'package:riverpod/riverpod.dart';

class DevicesService {
  final Ref _ref;

  DevicesService(this._ref);

  Future<JNAPSuccess> getDevices() async {
    return await _ref.read(jnapProvider).send(action: GetDevices.instance);
  }

  List<LinksysDevice> getDeviceListAndLocations(
    Map<String, dynamic>? data,
    Map<String, WirelessConnection> wirelessConnections,
  ) {
    var allDevices = <LinksysDevice>[];
    if (data != null) {
      allDevices = List.from(
        data['devices'],
      )
          .map((e) => LinksysDevice.fromMap(e))
          // .map((e) => e.copyWith(signalDecibels: getWirelessSignalOf(e, state)))
          .toList();
      // Sort the device list in order to correctly build the location map later
      allDevices.sort((device1, device2) {
        if (device1.isAuthority) {
          return -1;
        } else if (device1.nodeType == null) {
          return 1;
        } else if (device2.nodeType != null) {
          return (device1.nodeType == 'Master') ? -1 : 1;
        } else {
          return -1;
        }
      });
    }
    var nodes = allDevices.where((device) => device.nodeType != null).toList();
    var externalDevices =
        allDevices.where((device) => device.nodeType == null).toList();
    // final masterId =
    //     nodes.firstWhereOrNull((node) => node.isAuthority)?.deviceID;

    // Collect all the connected devices for nodes
    nodes = nodes.fold(<LinksysDevice>[], (list, node) {
      final connectedDevices = externalDevices.where((device) {
        // Make sure the external device is online
        if (device.isOnline()) {
          // There usually be only one item
          final parentDeviceId = device.connections.firstOrNull?.parentDeviceID;
          // Count it if this item's parentId is the target node,
          // or if its parentId is null and the target node is master
          // return ((parentDeviceId == node.deviceID) ||
          //     (parentDeviceId == null && node.deviceID == masterId));

          // For orphan nodes, don't caculate into any nodes
          return parentDeviceId == node.deviceID;
        }
        return false;
      }).toList();

      return list..add(node.copyWith(connectedDevices: connectedDevices));
    }).toList();

    // Determine connected Wi-Fi network for each external deivce
    externalDevices = externalDevices.map((device) {
      final wirelessData = wirelessConnections[device.getMacAddress()];
      final isGuestDevice = wirelessData?.isGuest ?? false;
      // Get the list of MLO capable radio IDs
      final mloList = device.knownInterfaces?.map((e) {
        final wirelessData = wirelessConnections[e.macAddress];
        if (wirelessData != null) {
          return wirelessData.isMLOCapable == true
              ? wirelessData.radioID ?? ''
              : '';
        }
        return '';
      }).toList()
        ?..removeWhere((e) => e.isEmpty);
      return device.copyWith(
        connectedWifiType:
            isGuestDevice ? WifiConnectionType.guest : WifiConnectionType.main,
        mloList: mloList,
      );
    }).toList();

    return [...nodes, ...externalDevices];
  }

  List<LinksysDevice> updateDeviceIpWithBackhaulInfo({
    required List<LinksysDevice> deviceList,
    required List<BackHaulInfoData> backhaulInfoList,
  }) {
    final _deviceList = deviceList.map((device) {
      final deviceId = device.deviceID;
      final backhaulInfo = backhaulInfoList
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
    }).toList();
    return _deviceList;
  }

  List<LinksysDevice> updateDeviceWirelessSignalWithWirelessConnections({
    required List<LinksysDevice> deviceList,
    required Map<String, WirelessConnection> wirelessConnections,
  }) {
    return deviceList
        .map((device) => device.copyWith(
              signalDecibels: getWirelessSignalOf(
                device: device,
                wirelessConnections: wirelessConnections,
              ),
            ))
        .toList();
  }

  int? getWirelessSignalOf({
    required RawDevice device,
    required Map<String, WirelessConnection> wirelessConnections,
  }) {
    final wirelessData = wirelessConnections[device.getMacAddress()];
    final signalDecibels = wirelessData?.signalDecibels;
    return signalDecibels;
  }

  List<LinksysDevice> updateDeviceUpstream({
    required List<LinksysDevice> deviceList,
    required LinksysDevice masterDevice,
    required List<BackHaulInfoData> backhaulInfoList,
  }) {
    return List<LinksysDevice>.from(deviceList)
        .map((e) => e.isAuthority
            ? e
            : e.copyWith(
                upstream: findParent(
                  deviceID: e.deviceID,
                  deviceList: deviceList,
                  masterDevice: masterDevice,
                  backhaulInfoList: backhaulInfoList,
                ),
              ))
        .toList();
  }

  LinksysDevice? findParent({
    required String deviceID,
    required List<LinksysDevice> deviceList,
    required LinksysDevice masterDevice,
    required List<BackHaulInfoData> backhaulInfoList,
  }) {
    final device =
        deviceList.firstWhereOrNull((element) => element.deviceID == deviceID);
    if (device == null) {
      return null;
    }
    if (!device.isOnline()) {
      return null;
    }
    String? parentIpAddr;

    // Check connections from backhaul info data.
    for (var element in device.connections) {
      for (var backhaul in backhaulInfoList) {
        if (backhaul.ipAddress == element.ipAddress) {
          parentIpAddr = backhaul.parentIPAddress;
          break;
        }
      }
    }
    //
    if (parentIpAddr != null) {
      return deviceList.firstWhereOrNull((element) =>
              element.connections.firstWhereOrNull(
                  (element) => element.ipAddress == parentIpAddr) !=
              null) ??
          masterDevice;
    }
    //
    // There usually be only one item
    final parentDeviceId = device.connections.firstOrNull?.parentDeviceID;
    // Count it if this item's parentId is the target node,
    // or if its parentId is null and the target node is master
    return deviceList.firstWhereOrNull(
            (element) => parentDeviceId == element.deviceID) ??
        (device.nodeType != null ? masterDevice : null);
  }

  String? getSsidConnectedBy({
    required LinksysDevice device,
    required Map<String, WirelessConnection> wirelessConnections,
    Map<String, RouterRadio>? radioInfoMap,
    GuestRadioSettings? guestRadioSettings,
  }) {
    // Get the SSID to the RadioID connected by the given device
    final wirelessData = wirelessConnections[device.getMacAddress()];
    final radioID = wirelessData?.radioID;

    /// if connection type is guest just return any one of ssid, because it is all the same
    return device.connectedWifiType == WifiConnectionType.guest
        ? guestRadioSettings?.radios.firstOrNull?.guestSSID
        : radioInfoMap?[radioID]?.settings.ssid;
  }

  String getBandConnectedBy({
    required LinksysDevice device,
    required Map<String, WirelessConnection> wirelessConnections,
  }) {
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

  // Update the name(location) of nodes and external devices
  Future<List<LinksysDevice>> updateDeviceNameAndIcon({
    required List<LinksysDevice> deviceList,
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
    List<LinksysDevice> _deviceList = deviceList;
    final jnap = _ref.read(jnapProvider);
    await jnap.send(
      action: SetDeviceProperties.instance,
      data: {
        'deviceID': targetId,
        'propertiesToModify': properties.map((e) => e.toMap()).toList(),
      },
    ).then((_) async {
      await jnap.send(
        action: GetDevices.instance,
        overrides: JNAPConfigOverrides(
          forceRemote: true,
        ),
      );

      _deviceList = deviceList.fold(<LinksysDevice>[], (list, element) {
        if (element.deviceID == targetId) {
          list.add(element.copyWith(properties: properties));
        } else {
          list.add(element);
        }
        return list;
      });
    }).onError((error, stackTrace) {
      logger.e(
          '[Device Service]: Update device name and icon failed, Error: $error, \n$stackTrace');
      throw error ?? '';
    });
    return _deviceList;
  }

  Future<List<LinksysDevice>> deleteDevices({
    required List<String> deviceIds,
    required List<LinksysDevice> deviceList,
  }) async {
    List<LinksysDevice> _deviceList = List<LinksysDevice>.from(deviceList);
    await _ref
        .read(jnapProvider)
        .transaction(
          transactionBuilder: JNAPTransactionBuilder(
              commands: deviceIds
                  .map((e) => MapEntry(DeleteDevice.instance, {'deviceID': e}))
                  .toList()),
          overrides: JNAPConfigOverrides(forceRemote: true, cached: false),
        )
        .then(
          (successWrap) => successWrap.data,
        )
        .then((dataResults) {
      final idResults = Map.fromIterables(deviceIds, dataResults)
          .entries
          .map((entry) => MapEntry(entry.key, entry.value.value));
      final idResultsMap = Map.fromEntries(idResults);
      idResultsMap.removeWhere((key, value) => value.result != 'OK');
      final completedIds = idResultsMap.keys.toList();
      _deviceList.removeWhere(
        (device) => completedIds.contains(device.deviceID),
      );
    });
    return _deviceList;
  }

  Future<void> deauthClient({required String macAddress}) async {
    await _ref.read(jnapProvider).send(
          action: ClientDeauth.instance,
          data: {
            'macAddress': macAddress,
          }..removeWhere((key, value) => value == null),
          overrides: JNAPConfigOverrides(forceRemote: true, cached: false),
        );
  }
}
