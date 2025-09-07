import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

class DeviceManagerService {
  Map<String, WirelessConnection> getWirelessConnections(
    List<Layer2Connection>? data,
  ) {
    var connectionsMap = <String, WirelessConnection>{};
    if (data != null) {
      final connections = data;
      for (final connectionData in connections) {
        final macAddress = connectionData.macAddress;
        final wirelessData = connectionData.wireless;
        if (wirelessData != null) {
          connectionsMap[macAddress] = wirelessData;
        }
      }
    }
    return connectionsMap;
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

  RouterWANStatus? getWANStatusModel(
    Map<String, dynamic>? data,
  ) {
    return data != null ? RouterWANStatus.fromMap(data) : null;
  }

}
