import 'dart:convert';

import 'package:collection/collection.dart';
import '../jsonable.dart';

class RawDevice extends Jsonable {
  final List<RawDeviceConnection> connections;
  final List<RawDeviceProperty> properties;
  final RawDeviceUnit unit;
  final String deviceID;
  final int maxAllowedProperties;
  final RawDeviceModel model;
  final bool isAuthority;
  final int lastChangeRevision;
  final String? friendlyName;
  final List<RawDeviceKnownInterface>? knownInterfaces;
  final List<String>? knownMACAddresses;
  final String? nodeType;

  const RawDevice({
    required this.connections,
    required this.properties,
    required this.unit,
    required this.deviceID,
    required this.maxAllowedProperties,
    required this.model,
    required this.isAuthority,
    required this.lastChangeRevision,
    this.friendlyName,
    this.knownInterfaces,
    this.knownMACAddresses,
    this.nodeType,
  });

  @override
  List<Object?> get props {
    return [
      connections,
      properties,
      unit,
      deviceID,
      maxAllowedProperties,
      model,
      isAuthority,
      lastChangeRevision,
      friendlyName,
      knownInterfaces,
      knownMACAddresses,
      nodeType,
    ];
  }

  String? get operatingSystem =>
      unit.operatingSystem ??
      properties
          .firstWhereOrNull((property) => property.name == 'userDeviceOS')
          ?.value;

  String? get manufacturer =>
      model.manufacturer ??
      properties
          .firstWhereOrNull(
              (property) => property.name == 'userDeviceManufacturer')
          ?.value;

  String? get modelNumber =>
      model.modelNumber ??
      properties
          .firstWhereOrNull(
              (property) => property.name == 'userDeviceModelNumber')
          ?.value;
  @override
  RawDevice copyWith({
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
  }) {
    return RawDevice(
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
    );
  }

  bool hasSameInterface(String macAddress) {
    return knownInterfaces
            ?.any((interface) => interface.macAddress == macAddress) ??
        false;
  }

  bool hasConnection(String macAddress) {
    return connections.any((connection) => connection.macAddress == macAddress);
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'connections': connections.map((x) => x.toMap()).toList(),
      'properties': properties.map((x) => x.toMap()).toList(),
      'unit': unit.toMap(),
      'deviceID': deviceID,
      'maxAllowedProperties': maxAllowedProperties,
      'model': model.toMap(),
      'isAuthority': isAuthority,
      'lastChangeRevision': lastChangeRevision,
      'friendlyName': friendlyName,
      'knownInterfaces': knownInterfaces?.map((x) => x.toMap()).toList(),
      'knownMACAddresses': knownMACAddresses,
      'nodeType': nodeType,
    };
  }

  factory RawDevice.fromMap(Map<String, dynamic> map) {
    return RawDevice(
      connections: List<RawDeviceConnection>.from(
        map['connections'].map<RawDeviceConnection>(
          (x) => RawDeviceConnection.fromMap(x),
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
          ? List<String>.from(
              (map['knownMACAddresses'] as List).map((x) => x as String))
          : null,
      nodeType: map['nodeType'] != null ? map['nodeType'] as String : null,
    );
  }

  factory RawDevice.fromJson(String source) => RawDevice.fromMap(jsonDecode(source));
}

class RawDeviceConnection extends Jsonable {
  final String macAddress;
  final String? ipAddress;
  final String? ipv6Address;
  final String? parentDeviceID;
  final bool? isGuest;

  const RawDeviceConnection({
    required this.macAddress,
    this.ipAddress,
    this.ipv6Address,
    this.parentDeviceID,
    this.isGuest,
  });

  @override
  RawDeviceConnection copyWith({
    String? macAddress,
    String? ipAddress,
    String? ipv6Address,
    String? parentDeviceID,
    bool? isGuest,
  }) {
    return RawDeviceConnection(
      macAddress: macAddress ?? this.macAddress,
      ipAddress: ipAddress ?? this.ipAddress,
      ipv6Address: ipv6Address ?? this.ipv6Address,
      parentDeviceID: parentDeviceID ?? this.parentDeviceID,
      isGuest: isGuest ?? this.isGuest,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macAddress': macAddress,
      'ipAddress': ipAddress,
      'ipv6Address': ipv6Address,
      'parentDeviceID': parentDeviceID,
      'isGuest': isGuest,
    };
  }

  factory RawDeviceConnection.fromMap(Map<String, dynamic> map) {
    return RawDeviceConnection(
      macAddress: map['macAddress'] as String,
      ipAddress: map['ipAddress'] != null ? map['ipAddress'] as String : null,
      ipv6Address:
          map['ipv6Address'] != null ? map['ipv6Address'] as String : null,
      parentDeviceID: map['parentDeviceID'] != null
          ? map['parentDeviceID'] as String
          : null,
      isGuest: map['isGuest'] != null ? map['isGuest'] as bool : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      macAddress,
      ipAddress,
      ipv6Address,
      parentDeviceID,
      isGuest,
    ];
  }

  factory RawDeviceConnection.fromJson(String source) =>
      RawDeviceConnection.fromMap(jsonDecode(source));
}

class RawDeviceProperty extends Jsonable {
  final String name;
  final String value;

  const RawDeviceProperty({
    required this.name,
    required this.value,
  });

  @override
  RawDeviceProperty copyWith({
    String? name,
    String? value,
  }) {
    return RawDeviceProperty(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory RawDeviceProperty.fromJson(String source) =>
      RawDeviceProperty.fromMap(jsonDecode(source));

  factory RawDeviceProperty.fromMap(Map<String, dynamic> map) {
    return RawDeviceProperty(
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  @override
  List<Object> get props => [name, value];
}

class RawDeviceUnit extends Jsonable {
  final String? serialNumber;
  final String? firmwareVersion;
  final String? firmwareDate;
  final String? operatingSystem;

  const RawDeviceUnit({
    this.serialNumber,
    this.firmwareVersion,
    this.firmwareDate,
    this.operatingSystem,
  });

  @override
  RawDeviceUnit copyWith({
    String? serialNumber,
    String? firmwareVersion,
    String? firmwareDate,
    String? operatingSystem,
  }) {
    return RawDeviceUnit(
      serialNumber: serialNumber ?? this.serialNumber,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      firmwareDate: firmwareDate ?? this.firmwareDate,
      operatingSystem: operatingSystem ?? this.operatingSystem,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serialNumber': serialNumber,
      'firmwareVersion': firmwareVersion,
      'firmwareDate': firmwareDate,
      'operatingSystem': operatingSystem,
    };
  }

  factory RawDeviceUnit.fromMap(Map<String, dynamic> map) {
    return RawDeviceUnit(
      serialNumber:
          map['serialNumber'] != null ? map['serialNumber'] as String : null,
      firmwareVersion: map['firmwareVersion'] != null
          ? map['firmwareVersion'] as String
          : null,
      firmwareDate:
          map['firmwareDate'] != null ? map['firmwareDate'] as String : null,
      operatingSystem: map['operatingSystem'] != null
          ? map['operatingSystem'] as String
          : null,
    );
  }

  factory RawDeviceUnit.fromJson(String source) =>
      RawDeviceUnit.fromMap(jsonDecode(source));

  @override
  List<Object?> get props =>
      [serialNumber, firmwareVersion, firmwareDate, operatingSystem];
}

class RawDeviceModel extends Jsonable {
  final String deviceType;
  final String? manufacturer;
  final String? modelNumber;
  final String? hardwareVersion;
  final String? modelDescription;

  const RawDeviceModel({
    required this.deviceType,
    this.manufacturer,
    this.modelNumber,
    this.hardwareVersion,
    this.modelDescription,
  });

  @override
  RawDeviceModel copyWith({
    String? deviceType,
    String? manufacturer,
    String? modelNumber,
    String? hardwareVersion,
    String? modelDescription,
  }) {
    return RawDeviceModel(
      deviceType: deviceType ?? this.deviceType,
      manufacturer: manufacturer ?? this.manufacturer,
      modelNumber: modelNumber ?? this.modelNumber,
      hardwareVersion: hardwareVersion ?? this.hardwareVersion,
      modelDescription: modelDescription ?? this.modelDescription,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceType': deviceType,
      'manufacturer': manufacturer,
      'modelNumber': modelNumber,
      'hardwareVersion': hardwareVersion,
      'modelDescription': modelDescription,
    };
  }

  factory RawDeviceModel.fromMap(Map<String, dynamic> map) {
    return RawDeviceModel(
      deviceType: map['deviceType'] as String,
      manufacturer:
          map['manufacturer'] != null ? map['manufacturer'] as String : null,
      modelNumber:
          map['modelNumber'] != null ? map['modelNumber'] as String : null,
      hardwareVersion: map['hardwareVersion'] != null
          ? map['hardwareVersion'] as String
          : null,
      modelDescription: map['modelDescription'] != null
          ? map['modelDescription'] as String
          : null,
    );
  }

  factory RawDeviceModel.fromJson(String source) =>
      RawDeviceModel.fromMap(jsonDecode(source));

  @override
  List<Object?> get props {
    return [
      deviceType,
      manufacturer,
      modelNumber,
      hardwareVersion,
      modelDescription,
    ];
  }
}

class RawDeviceKnownInterface extends Jsonable {
  final String macAddress;
  final String interfaceType;
  final String? band;

  const RawDeviceKnownInterface({
    required this.macAddress,
    required this.interfaceType,
    this.band,
  });

  @override
  RawDeviceKnownInterface copyWith({
    String? macAddress,
    String? interfaceType,
    String? band,
  }) {
    return RawDeviceKnownInterface(
      macAddress: macAddress ?? this.macAddress,
      interfaceType: interfaceType ?? this.interfaceType,
      band: band ?? this.band,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macAddress': macAddress,
      'interfaceType': interfaceType,
      'band': band,
    };
  }

  factory RawDeviceKnownInterface.fromMap(Map<String, dynamic> map) {
    return RawDeviceKnownInterface(
      macAddress: map['macAddress'] as String,
      interfaceType: map['interfaceType'] as String,
      band: map['band'] != null ? map['band'] as String : null,
    );
  }

  @override
  List<Object?> get props => [macAddress, interfaceType, band];

  factory RawDeviceKnownInterface.fromJson(String source) =>
      RawDeviceKnownInterface.fromMap(jsonDecode(source));
}
