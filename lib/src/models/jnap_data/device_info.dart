import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class NodeDeviceInfo extends Jsonable {
  const NodeDeviceInfo({
    required this.modelNumber,
    required this.firmwareVersion,
    required this.description,
    required this.firmwareDate,
    required this.manufacturer,
    required this.serialNumber,
    required this.hardwareVersion,
    required this.services,
  });

  factory NodeDeviceInfo.fromMap(Map<String, dynamic> map) {
    return NodeDeviceInfo(
      modelNumber: map['modelNumber'],
      firmwareVersion: map['firmwareVersion'],
      description: map['description'],
      firmwareDate: map['firmwareDate'],
      manufacturer: map['manufacturer'],
      serialNumber: map['serialNumber'],
      hardwareVersion: map['hardwareVersion'],
      services: List.from(map['services']),
    );
  }

  factory NodeDeviceInfo.fromJson(String source) =>
      NodeDeviceInfo.fromMap(jsonDecode(source));

  final String modelNumber;
  final String firmwareVersion;
  final String description;
  final String firmwareDate;
  final String manufacturer;
  final String serialNumber;
  final String hardwareVersion;
  final List<String> services;

  @override
  Map<String, dynamic> toMap() {
    return {
      'modelNumber': modelNumber,
      'firmwareVersion': firmwareVersion,
      'description': description,
      'firmwareDate': firmwareDate,
      'manufacturer': manufacturer,
      'serialNumber': serialNumber,
      'hardwareVersion': hardwareVersion,
      'services': services,
    }..removeWhere((key, value) => value == null);
  }

  @override
  NodeDeviceInfo copyWith({
    String? modelNumber,
    String? firmwareVersion,
    String? description,
    String? firmwareDate,
    String? manufacturer,
    String? serialNumber,
    String? hardwareVersion,
    List<String>? services,
  }) {
    return NodeDeviceInfo(
      modelNumber: modelNumber ?? this.modelNumber,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      description: description ?? this.description,
      firmwareDate: firmwareDate ?? this.firmwareDate,
      manufacturer: manufacturer ?? this.manufacturer,
      serialNumber: serialNumber ?? this.serialNumber,
      hardwareVersion: hardwareVersion ?? this.hardwareVersion,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [
        modelNumber,
        firmwareVersion,
        description,
        firmwareDate,
        manufacturer,
        serialNumber,
        hardwareVersion,
      ];
}
