// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class RouterEthernetPortConnections extends Jsonable {
  final String wanPortConnection;
  final List<String> lanPortConnections;
  const RouterEthernetPortConnections({
    required this.wanPortConnection,
    required this.lanPortConnections,
  });

  @override
  RouterEthernetPortConnections copyWith({
    String? wanPortConnection,
    List<String>? lanPortConnections,
  }) {
    return RouterEthernetPortConnections(
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

  factory RouterEthernetPortConnections.fromMap(Map<String, dynamic> map) {
    return RouterEthernetPortConnections(
      wanPortConnection: map['wanPortConnection'] as String,
      lanPortConnections: List<String>.from(
        (map['lanPortConnections'] as List).map((x) => x as String),
      ),
    );
  }

  @override
  List<Object> get props => [wanPortConnection, lanPortConnections];

  factory RouterEthernetPortConnections.fromJson(String source) =>
      RouterEthernetPortConnections.fromMap(jsonDecode(source));
}
