// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';

class NodeWirelessConnections extends Jsonable {
  final String deviceID;
  final List<NodeWirelessLayer2Connections> connections;
  const NodeWirelessConnections({
    required this.deviceID,
    required this.connections,
  });

  @override
  NodeWirelessConnections copyWith({
    String? deviceID,
    List<NodeWirelessLayer2Connections>? connections,
  }) {
    return NodeWirelessConnections(
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

  factory NodeWirelessConnections.fromMap(Map<String, dynamic> map) {
    return NodeWirelessConnections(
      deviceID: map['deviceID'] as String,
      connections: List.from(
        (map['connections']).map(
          (x) => NodeWirelessLayer2Connections.fromMap(x),
        ),
      ),
    );
  }

  factory NodeWirelessConnections.fromJson(String source) =>
      NodeWirelessConnections.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [deviceID, connections];
}
