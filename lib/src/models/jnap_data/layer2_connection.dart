// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

class Layer2ConnectionData extends Jsonable {
  final String macAddress;
  final int negotiatedMbps;
  final WirelessConnectionData? wireless;

  const Layer2ConnectionData({
    required this.macAddress,
    required this.negotiatedMbps,
    required this.wireless,
  });

  @override
  Layer2ConnectionData copyWith({
    String? macAddress,
    int? negotiatedMbps,
    WirelessConnectionData? wireless,
  }) {
    return Layer2ConnectionData(
      macAddress: macAddress ?? this.macAddress,
      negotiatedMbps: negotiatedMbps ?? this.negotiatedMbps,
      wireless: wireless ?? this.wireless,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macAddress': macAddress,
      'negotiatedMbps': negotiatedMbps,
      'wireless': wireless?.toMap(),
    }..removeWhere((key, value) => value == null);
  }

  factory Layer2ConnectionData.fromMap(Map<String, dynamic> map) {
    return Layer2ConnectionData(
      macAddress: map['macAddress'] as String,
      negotiatedMbps: map['negotiatedMbps'],
      wireless: map['wireless'] != null
          ? WirelessConnectionData.fromMap(map['wireless'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Layer2ConnectionData.fromJson(String source) =>
      Layer2ConnectionData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [macAddress, negotiatedMbps, wireless];
}

class NodeWirelessLayer2ConnectionsData extends Layer2ConnectionData {
  final String timestamp;

  const NodeWirelessLayer2ConnectionsData({
    required super.macAddress,
    required super.negotiatedMbps,
    required this.timestamp,
    required super.wireless,
  });

  @override
  NodeWirelessLayer2ConnectionsData copyWith({
    String? macAddress,
    int? negotiatedMbps,
    String? timestamp,
    WirelessConnectionData? wireless,
  }) {
    return NodeWirelessLayer2ConnectionsData(
      macAddress: macAddress ?? this.macAddress,
      negotiatedMbps: negotiatedMbps ?? this.negotiatedMbps,
      timestamp: timestamp ?? this.timestamp,
      wireless: wireless ?? this.wireless,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macAddress': macAddress,
      'negotiatedMbps': negotiatedMbps,
      'timestamp': timestamp,
      'wireless': wireless?.toMap(),
    }..removeWhere((key, value) => value == null);
  }

  factory NodeWirelessLayer2ConnectionsData.fromMap(Map<String, dynamic> map) {
    return NodeWirelessLayer2ConnectionsData(
      macAddress: map['macAddress'] as String,
      negotiatedMbps: map['negotiatedMbps'],
      timestamp: map['timestamp'] as String,
      wireless:
          WirelessConnectionData.fromMap(map['wireless'] as Map<String, dynamic>),
    );
  }

  factory NodeWirelessLayer2ConnectionsData.fromJson(String source) =>
      NodeWirelessLayer2ConnectionsData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [macAddress, negotiatedMbps, timestamp, wireless];
}