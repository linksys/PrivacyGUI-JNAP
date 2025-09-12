import 'dart:convert';

import '../jsonable.dart';

class BTDiscoveryDataData extends Jsonable {
  final String name;
  final String macAddress;
  final int rssi;
  final String? modeLimit;

  @override
  List<Object?> get props => [name, macAddress, rssi, modeLimit];

  const BTDiscoveryDataData({
    required this.name,
    required this.macAddress,
    required this.rssi,
    this.modeLimit,
  });

  @override
  BTDiscoveryDataData copyWith({
    String? name,
    String? macAddress,
    int? rssi,
    String? modeLimit,
  }) {
    return BTDiscoveryDataData(
      name: name ?? this.name,
      macAddress: macAddress ?? this.macAddress,
      rssi: rssi ?? this.rssi,
      modeLimit: modeLimit ?? this.modeLimit,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'macAddress': macAddress,
      'rssi': rssi,
      'modeLimit': modeLimit,
    }..removeWhere((key, value) => value == null);
  }

  factory BTDiscoveryDataData.fromMap(Map<String, dynamic> map) {
    return BTDiscoveryDataData(
      name: map['name'],
      macAddress: map['macAddress'],
      rssi: map['rssi'],
      modeLimit: map['modeLimit'],
    );
  }
  factory BTDiscoveryDataData.fromJson(String source) =>
      BTDiscoveryDataData.fromMap(jsonDecode(source));
}