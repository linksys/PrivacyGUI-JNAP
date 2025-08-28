// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

class Layer2Connection extends Jsonable {
  final String macAddress;
  final int negotiatedMbps;
  final WirelessConnection? wireless;

  const Layer2Connection({
    required this.macAddress,
    required this.negotiatedMbps,
    required this.wireless,
  });

  @override
  Layer2Connection copyWith({
    String? macAddress,
    int? negotiatedMbps,
    WirelessConnection? wireless,
  }) {
    return Layer2Connection(
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

  factory Layer2Connection.fromMap(Map<String, dynamic> map) {
    return Layer2Connection(
      macAddress: map['macAddress'] as String,
      negotiatedMbps: map['negotiatedMbps'],
      wireless: map['wireless'] != null
          ? WirelessConnection.fromMap(map['wireless'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Layer2Connection.fromJson(String source) =>
      Layer2Connection.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [macAddress, negotiatedMbps, wireless];
}

class NodeWirelessLayer2Connections extends Layer2Connection {
  final String timestamp;

  const NodeWirelessLayer2Connections({
    required super.macAddress,
    required super.negotiatedMbps,
    required this.timestamp,
    required super.wireless,
  });

  @override
  NodeWirelessLayer2Connections copyWith({
    String? macAddress,
    int? negotiatedMbps,
    String? timestamp,
    WirelessConnection? wireless,
  }) {
    return NodeWirelessLayer2Connections(
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

  factory NodeWirelessLayer2Connections.fromMap(Map<String, dynamic> map) {
    return NodeWirelessLayer2Connections(
      macAddress: map['macAddress'] as String,
      negotiatedMbps: map['negotiatedMbps'],
      timestamp: map['timestamp'] as String,
      wireless:
          WirelessConnection.fromMap(map['wireless'] as Map<String, dynamic>),
    );
  }

  factory NodeWirelessLayer2Connections.fromJson(String source) =>
      NodeWirelessLayer2Connections.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [macAddress, negotiatedMbps, timestamp, wireless];
}
