// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';

class NodeWirelessConnectionsData extends Jsonable {
  final String deviceID;
  final List<NodeWirelessLayer2ConnectionsData> connections;
  const NodeWirelessConnectionsData({
    required this.deviceID,
    required this.connections,
  });

  @override
  NodeWirelessConnectionsData copyWith({
    String? deviceID,
    List<NodeWirelessLayer2ConnectionsData>? connections,
  }) {
    return NodeWirelessConnectionsData(
      deviceID: deviceID ?? this.deviceID,
      connections: connections ?? this.connections,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceID': deviceID,
      'connections': connections.map((x) => x.toMap()).toList(),
    };
  }

  factory NodeWirelessConnectionsData.fromMap(Map<String, dynamic> map) {
    return NodeWirelessConnectionsData(
      deviceID: map['deviceID'] as String,
      connections: List.from(
        (map['connections']).map(
          (x) => NodeWirelessLayer2ConnectionsData.fromMap(x),
        ),
      ),
    );
  }

  factory NodeWirelessConnectionsData.fromJson(String source) =>
      NodeWirelessConnectionsData.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [deviceID, connections];
}