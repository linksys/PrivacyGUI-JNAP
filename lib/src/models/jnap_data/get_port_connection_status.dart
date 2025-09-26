// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class GetPortConnectionStatusData extends Jsonable {
  final List<PortConnectionStatus> portConnectionStatus;

  const GetPortConnectionStatusData({
    required this.portConnectionStatus,
  });

  @override
  GetPortConnectionStatusData copyWith({
    List<PortConnectionStatus>? portConnectionStatus,
  }) {
    return GetPortConnectionStatusData(
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

  factory GetPortConnectionStatusData.fromMap(Map<String, dynamic> map) {
    return GetPortConnectionStatusData(
      portConnectionStatus: List<PortConnectionStatus>.from(
        map['portConnectionStatus'].map<PortConnectionStatus>(
          (x) => PortConnectionStatus.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [portConnectionStatus];

  factory GetPortConnectionStatusData.fromJson(String source) =>
      GetPortConnectionStatusData.fromMap(jsonDecode(source));
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