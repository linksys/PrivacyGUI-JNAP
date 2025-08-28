// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class GetPortConnectionStatus extends Jsonable {
  final List<PortConnectionStatus> portConnectionStatus;

  const GetPortConnectionStatus({
    required this.portConnectionStatus,
  });

  @override
  GetPortConnectionStatus copyWith({
    List<PortConnectionStatus>? portConnectionStatus,
  }) {
    return GetPortConnectionStatus(
      portConnectionStatus: portConnectionStatus ?? this.portConnectionStatus,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'portConnectionStatus':
          portConnectionStatus.map((x) => x.toMap()).toList(),
    }..removeWhere((key, value) => value == null);
  }

  factory GetPortConnectionStatus.fromMap(Map<String, dynamic> map) {
    return GetPortConnectionStatus(
      portConnectionStatus: List<PortConnectionStatus>.from(
        map['portConnectionStatus'].map<PortConnectionStatus>(
          (x) => PortConnectionStatus.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [portConnectionStatus];

  factory GetPortConnectionStatus.fromJson(String source) =>
      GetPortConnectionStatus.fromMap(jsonDecode(source));
}

class PortConnectionStatus extends Jsonable {
  final int portId;
  final String connectionState;

  const PortConnectionStatus({
    required this.portId,
    required this.connectionState,
  });

  @override
  PortConnectionStatus copyWith({
    int? portId,
    String? connectionState,
  }) {
    return PortConnectionStatus(
      portId: portId ?? this.portId,
      connectionState: connectionState ?? this.connectionState,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'portId': portId,
      'connectionState': connectionState,
    }..removeWhere((key, value) => value == null);
  }

  factory PortConnectionStatus.fromMap(Map<String, dynamic> map) {
    return PortConnectionStatus(
      portId: map['portId'] as int,
      connectionState: map['connectionState'] as String,
    );
  }

  @override
  List<Object?> get props => [portId, connectionState];

  factory PortConnectionStatus.fromJson(String source) =>
      PortConnectionStatus.fromMap(jsonDecode(source));
}
