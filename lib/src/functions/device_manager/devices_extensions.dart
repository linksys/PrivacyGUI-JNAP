import 'package:collection/collection.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/service/devices_service.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

extension DeviceUtil on RawDevice {
  String getDeviceLocation() {
    for (final property in properties) {
      if (property.name == 'userDeviceLocation' && property.value.isNotEmpty) {
        return property.value;
      }
    }
    return getDeviceName();
  }

  String getDeviceName() {
    for (final property in properties) {
      if (property.name == 'userDeviceName' && property.value.isNotEmpty) {
        return property.value;
      }
    }

    bool isAndroidDevice = false;
    if (friendlyName != null) {
      final regExp =
          RegExp(r'^Android$|^android-[a-fA-F0-9]{16}.*|^Android-[0-9]+');
      isAndroidDevice = regExp.hasMatch(friendlyName!);
    }

    String? androidDeviceName;
    if (isAndroidDevice &&
        ['Mobile', 'Phone', 'Tablet'].contains(model.deviceType)) {
      final manufacturer = this.manufacturer;
      final modelNumber = this.modelNumber;
      if (manufacturer != null && modelNumber != null) {
        // e.g. 'Samsung Galaxy S8'
        androidDeviceName = '$manufacturer $modelNumber';
      } else if (operatingSystem != null) {
        // e.g. 'Android Oreo Mobile'
        androidDeviceName = '${operatingSystem!} ${model.deviceType}';
        if (manufacturer != null) {
          // e.g. 'Samsung Android Oreo Mobile'
          androidDeviceName = manufacturer + androidDeviceName;
        }
      }
    }

    if (androidDeviceName != null) {
      return androidDeviceName;
    } else if (friendlyName != null) {
      return friendlyName!;
    } else if (model.modelNumber != null) {
      return model.modelNumber!;
    } else {
      // Check if it's connecting to the guest network
      // NOTE: This value can also be derived from 'NetworkConnections', but they should be identical
      final isGuest = connections.firstOrNull?.isGuest ?? false;
      return isGuest ? 'Guest Network Device' : 'Network Device';
    }
  }

  String getMacAddress() {
    var macAddress = '';
    if (knownInterfaces != null) {
      final knownInterface = knownInterfaces!.firstWhereOrNull((element) =>
          element.band != null || element.interfaceType != 'Unknown');
      macAddress = (knownInterface ?? knownInterfaces!.first).macAddress;
    } else if (knownMACAddresses != null) {
      // This case is only for a part of old routers that does not support 'GetDevices3' action
      macAddress = knownMACAddresses!.firstOrNull ?? '';
    }
    return macAddress;
  }

  bool containsMacAddress(String mac) {
    if (knownInterfaces != null) {
      return knownInterfaces!.any((element) => element.macAddress == mac);
    } else if (knownMACAddresses != null) {
      return knownMACAddresses!.contains(mac);
    } else {
      return false;
    }
  }

  bool containsIpAddress(String ip) {
    return connections.any((element) => element.ipAddress == ip);
  }

  bool containsIpv6Address(String ip) {
    return connections.any((element) => element.ipv6Address == ip);
  }
}

extension LinksysDeviceExt on LinksysDevice {
  DeviceConnectionType getConnectionType() {
    bool ret = isOnline();
    if (!ret) {
      return DeviceConnectionType.none;
    }
    if (nodeType == 'Slave') {
      return connectionType == 'Wireless' && wirelessConnectionInfo != null
          ? DeviceConnectionType.wireless
          : DeviceConnectionType.wired;
    }
    final interfaces = knownInterfaces;
    return interfaces?.any((element) => element.interfaceType == 'Wireless') ==
            true
        ? DeviceConnectionType.wireless
        : DeviceConnectionType.wired;
  }

  bool isOnline() {
    // return nodeType == 'Master'
    //     ? connections.isNotEmpty
    //     : connections.isNotEmpty &&
    //         knownInterfaces?.any((element) =>
    //                 element.interfaceType == 'Wired' ||
    //                 element.interfaceType == 'Wireless') ==
    //             true;
    return connections.isNotEmpty;
  }

  // Note: NodeType is null but isAuthority is true in factory settings
  // To avoid errors caused by empty node device list while entering
  // the dashboard on an unconfigured router, isAuthority is also checked
  bool get isNodeDevice => nodeType != null || isAuthority == true;

  bool get isExternalDevice => nodeType == null;

  bool get isMasterDevice => isAuthority == true || nodeType == 'Master';

  bool get isSlaveDevice => isAuthority == false && nodeType == 'Slave';

  bool get isMainWifiDevice => connectedWifiType == WifiConnectionType.main;

  bool get isGuestWifiDevice => connectedWifiType == WifiConnectionType.guest;
}

extension DeviceListPipeline on List<LinksysDevice> {
  List<LinksysDevice> updateIpWithBackhaulInfo(
      DevicesService service, List<BackHaulInfoData> backhaulInfoList) {
    return service.updateDeviceIpWithBackhaulInfo(
        deviceList: this, backhaulInfoList: backhaulInfoList);
  }

  List<LinksysDevice> updateWirelessSignal(DevicesService service,
      Map<String, WirelessConnection> wirelessConnections) {
    return service.updateDeviceWirelessSignalWithWirelessConnections(
        deviceList: this, wirelessConnections: wirelessConnections);
  }

  List<LinksysDevice> updateUpstream(DevicesService service,
      LinksysDevice masterDevice, List<BackHaulInfoData> backhaulInfoList) {
    return service.updateDeviceUpstream(
        deviceList: this,
        masterDevice: masterDevice,
        backhaulInfoList: backhaulInfoList);
  }
}

enum DeviceConnectionType {
  wired,
  wireless,
  none;
}
