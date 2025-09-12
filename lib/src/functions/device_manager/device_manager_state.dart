import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

class LinksysDevice extends RawDevice {
  final List<LinksysDevice> connectedDevices;
  final WifiConnectionType connectedWifiType;
  final int? signalDecibels;
  final LinksysDevice? upstream;
  final String connectionType;
  final WirelessConnectionInfo? wirelessConnectionInfo;
  final String speedMbps;
  final List<String> mloList;

  const LinksysDevice({
    required super.connections,
    required super.properties,
    required super.unit,
    required super.deviceID,
    required super.maxAllowedProperties,
    required super.model,
    required super.isAuthority,
    required super.lastChangeRevision,
    super.friendlyName,
    super.knownInterfaces,
    super.knownMACAddresses,
    super.nodeType,
    this.connectedDevices = const [],
    this.connectedWifiType = WifiConnectionType.main,
    this.signalDecibels,
    this.upstream,
    this.connectionType = 'wireless',
    this.wirelessConnectionInfo,
    this.speedMbps = '--',
    this.mloList = const [],
  });

  @override
  LinksysDevice copyWith({
    List<RawDeviceConnection>? connections,
    List<RawDeviceProperty>? properties,
    RawDeviceUnit? unit,
    String? deviceID,
    int? maxAllowedProperties,
    RawDeviceModel? model,
    bool? isAuthority,
    int? lastChangeRevision,
    String? friendlyName,
    List<RawDeviceKnownInterface>? knownInterfaces,
    List<String>? knownMACAddresses,
    String? nodeType,
    List<LinksysDevice>? connectedDevices,
    WifiConnectionType? connectedWifiType,
    int? signalDecibels,
    LinksysDevice? upstream,
    String? connectionType,
    WirelessConnectionInfo? wirelessConnectionInfo,
    String? speedMbps,
    List<String>? mloList,
  }) {
    return LinksysDevice(
      connections: connections ?? this.connections,
      properties: properties ?? this.properties,
      unit: unit ?? this.unit,
      deviceID: deviceID ?? this.deviceID,
      maxAllowedProperties: maxAllowedProperties ?? this.maxAllowedProperties,
      model: model ?? this.model,
      isAuthority: isAuthority ?? this.isAuthority,
      lastChangeRevision: lastChangeRevision ?? this.lastChangeRevision,
      friendlyName: friendlyName ?? this.friendlyName,
      knownInterfaces: knownInterfaces ?? this.knownInterfaces,
      knownMACAddresses: knownMACAddresses ?? this.knownMACAddresses,
      nodeType: nodeType ?? this.nodeType,
      connectedDevices: connectedDevices ?? this.connectedDevices,
      connectedWifiType: connectedWifiType ?? this.connectedWifiType,
      signalDecibels: signalDecibels ?? this.signalDecibels,
      upstream: upstream ?? this.upstream,
      connectionType: connectionType ?? this.connectionType,
      wirelessConnectionInfo:
          wirelessConnectionInfo ?? this.wirelessConnectionInfo,
      speedMbps: speedMbps ?? this.speedMbps,
      mloList: mloList ?? this.mloList,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'connectedDevices': connectedDevices.map((e) => e.toMap()).toList(),
      'connectedWifiType': connectedWifiType.value,
      'signalDecibels': signalDecibels,
      'upstream': upstream?.toMap(),
      'connectionType': connectionType,
      'wirelessConnectionInfo': wirelessConnectionInfo?.toMap(),
      'speedMbps': speedMbps,
      'mloList': mloList,
    }..removeWhere((key, value) => value == null);
  }

  factory LinksysDevice.fromMap(Map<String, dynamic> map) {
    return LinksysDevice(
      connections: List<RawDeviceConnection>.from(
        map['connections'].map<RawDeviceConnection>(
          (x) => RawDeviceConnection.fromMap(x as Map<String, dynamic>),
        ),
      ),
      properties: List<RawDeviceProperty>.from(
        map['properties'].map<RawDeviceProperty>(
          (x) => RawDeviceProperty.fromMap(x as Map<String, dynamic>),
        ),
      ),
      unit: RawDeviceUnit.fromMap(map['unit'] as Map<String, dynamic>),
      deviceID: map['deviceID'] as String,
      maxAllowedProperties: map['maxAllowedProperties'] as int,
      model: RawDeviceModel.fromMap(map['model'] as Map<String, dynamic>),
      isAuthority: map['isAuthority'] as bool,
      lastChangeRevision: map['lastChangeRevision'] as int,
      friendlyName:
          map['friendlyName'] != null ? map['friendlyName'] as String : null,
      knownInterfaces: map['knownInterfaces'] != null
          ? List<RawDeviceKnownInterface>.from(
              map['knownInterfaces'].map<RawDeviceKnownInterface?>(
                (x) =>
                    RawDeviceKnownInterface.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      knownMACAddresses: map['knownMACAddresses'] != null
          ? List<String>.from((map['knownMACAddresses'] as List<String>))
          : null,
      nodeType: map['nodeType'] != null ? map['nodeType'] as String : null,
      connectedDevices: map['connectedDevices'] != null
          ? List.from(map['connectedDevices'])
              .map((e) => LinksysDevice.fromMap(e))
              .toList()
          : [],
      connectedWifiType: map['connectedWifiType'] != null
          ? WifiConnectionType.values.firstWhereOrNull(
                  (element) => element.value == map['connectedWifiType']) ??
              WifiConnectionType.main
          : WifiConnectionType.main,
      signalDecibels: map['signalDecibels'],
      upstream: map['upstream'] != null
          ? LinksysDevice.fromMap(map['upstream'])
          : null,
      connectionType: map['connectionType'] ?? 'wired',
      wirelessConnectionInfo: map['wirelessConnectionInfo'] != null
          ? WirelessConnectionInfo.fromMap(map['wirelessConnectionInfo'])
          : null,
      speedMbps: map['speedMbps'] ?? '--',
      mloList: map['mloList'] != null ? <String>[...map['mloList']] : [],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory LinksysDevice.fromJson(String source) =>
      LinksysDevice.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DeviceManagerState extends Equatable {
  // Collected data for a specific network with its own devices shared to overall screens
  final Map<String, WirelessConnectionData> wirelessConnections;
  final Map<String, RouterRadio> radioInfos;
  final GuestRadioSettingsData? guestRadioSettings;
  final List<LinksysDevice> deviceList;
  final RouterWANStatusData? wanStatus;
  final List<BackHaulInfoData> backhaulInfoData;
  final int lastUpdateTime;

  // Calculated properties
  List<LinksysDevice> get nodeDevices {
    return deviceList.where((device) => device.isNodeDevice).toList();
  }

  List<LinksysDevice> get externalDevices {
    return deviceList.where((device) => device.isExternalDevice).toList();
  }

  List<LinksysDevice> get mainWifiDevices {
    return deviceList.where((device) => device.isMainWifiDevice).toList();
  }

  List<LinksysDevice> get guestWifiDevices {
    return deviceList.where((device) => device.isGuestWifiDevice).toList();
  }

  LinksysDevice get masterDevice {
    return nodeDevices.firstWhere((device) => device.isMasterDevice);
  }

  List<LinksysDevice> get slaveDevices {
    return nodeDevices.where((device) => device.isSlaveDevice).toList();
  }

  const DeviceManagerState({
    this.wirelessConnections = const {},
    this.radioInfos = const {},
    this.guestRadioSettings,
    this.deviceList = const [],
    this.wanStatus,
    this.backhaulInfoData = const [],
    this.lastUpdateTime = 0,
  });

  DeviceManagerState copyWith({
    Map<String, WirelessConnectionData>? wirelessConnections,
    Map<String, RouterRadio>? radioInfos,
    List<LinksysDevice>? deviceList,
    GuestRadioSettingsData? guestRadioSettings,
    RouterWANStatusData? wanStatus,
    List<BackHaulInfoData>? backhaulInfoData,
    int? lastUpdateTime,
  }) {
    return DeviceManagerState(
      wirelessConnections: wirelessConnections ?? this.wirelessConnections,
      radioInfos: radioInfos ?? this.radioInfos,
      guestRadioSettings: guestRadioSettings ?? this.guestRadioSettings,
      deviceList: deviceList ?? this.deviceList,
      wanStatus: wanStatus ?? this.wanStatus,
      backhaulInfoData: backhaulInfoData ?? this.backhaulInfoData,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  Map<String, dynamic> toMap() {
    final wirelessConnectionMap = Map.fromEntries(wirelessConnections.entries
        .map((e) => MapEntry(e.key, e.value.toMap())));
    final radioInfoMap = Map.fromEntries(
        radioInfos.entries.map((e) => MapEntry(e.key, e.value.toMap())));
    return <String, dynamic>{
      'wirelessConnections': wirelessConnectionMap,
      'radioInfos': radioInfoMap,
      'guestRadioSettings': guestRadioSettings?.toMap(),
      'deviceList': deviceList.map((x) => x.toMap()).toList(),
      'wanStatus': wanStatus?.toMap(),
      'backhaulInfoData': backhaulInfoData.map((x) => x.toMap()).toList(),
      'lastUpdateTime': lastUpdateTime,
    }..removeWhere((key, value) => value == null);
  }

  factory DeviceManagerState.fromMap(Map<String, dynamic> map) {
    return DeviceManagerState(
      wirelessConnections: Map<String, WirelessConnectionData>.fromEntries(
        (map['wirelessConnections'] as Map).entries.map(
              (e) => MapEntry(
                e.key,
                WirelessConnectionData.fromMap(e.value),
              ),
            ),
      ),
      radioInfos: Map<String, RouterRadio>.fromEntries(
          (map['radioInfos'] as Map).entries.map(
                (e) => MapEntry(
                  e.key,
                  RouterRadio.fromMap(e.value),
                ),
              )),
      guestRadioSettings: map['guestRadioSettings'] != null
          ? GuestRadioSettingsData.fromMap(map['guestRadioSettings'])
          : null,
      deviceList: List<LinksysDevice>.from(
        map['deviceList'].map<LinksysDevice>(
          (x) => LinksysDevice.fromMap(x as Map<String, dynamic>),
        ),
      ),
      wanStatus: map['wanStatus'] != null
          ? RouterWANStatusData.fromMap(map['wanStatus'] as Map<String, dynamic>)
          : null,
      backhaulInfoData: List<BackHaulInfoData>.from(
        map['backhaulInfoData'].map<BackHaulInfoData>(
          (x) => BackHaulInfoData.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastUpdateTime: map['lastUpdateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceManagerState.fromJson(String source) =>
      DeviceManagerState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      wirelessConnections,
      radioInfos,
      deviceList,
      wanStatus,
      backhaulInfoData,
      lastUpdateTime,
    ];
  }
}

enum WifiConnectionType {
  main('main'),
  guest('guest');

  final String value;
  const WifiConnectionType(this.value);
}