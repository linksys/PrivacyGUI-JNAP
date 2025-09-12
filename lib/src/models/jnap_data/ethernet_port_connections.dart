// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class RouterEthernetPortConnectionsData extends Jsonable {
  final String wanPortConnection;
  final List<String> lanPortConnections;
  const RouterEthernetPortConnectionsData({
    required this.wanPortConnection,
    required this.lanPortConnections,
  });

  @override
  RouterEthernetPortConnectionsData copyWith({
    String? wanPortConnection,
    List<String>? lanPortConnections,
  }) {
    return RouterEthernetPortConnectionsData(
      wanPortConnection: wanPortConnection ?? this.wanPortConnection,
      lanPortConnections: lanPortConnections ?? this.lanPortConnections,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wanPortConnection': wanPortConnection,
      'lanPortConnections': lanPortConnections,
    };
  }

  factory RouterEthernetPortConnectionsData.fromMap(Map<String, dynamic> map) {
    return RouterEthernetPortConnectionsData(
      wanPortConnection: map['wanPortConnection'] as String,
      lanPortConnections: List<String>.from(
        (map['lanPortConnections'] as List).map((x) => x as String),
      ),
    );
  }

  @override
  List<Object> get props => [wanPortConnection, lanPortConnections];

  factory RouterEthernetPortConnectionsData.fromJson(String source) =>
      RouterEthernetPortConnectionsData.fromMap(jsonDecode(source));
}