// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jnap_data/firmware_update_status.dart';
import 'package:jnap/src/models/types.dart';

class NodesFirmwareUpdateStatusData extends FirmwareUpdateStatusData {
  final String deviceUUID;

  const NodesFirmwareUpdateStatusData({
    required this.deviceUUID,
    required super.lastSuccessfulCheckTime,
    super.availableUpdate,
    super.pendingOperation,
    super.lastOperationFailure,
  });

  @override
  NodesFirmwareUpdateStatusData copyWith({
    String? deviceUUID,
    String? lastSuccessfulCheckTime,
    ValueGetter<FirmwareUpdateData?>? availableUpdate,
    ValueGetter<FirmwareUpdateOperationStatus?>? pendingOperation,
    ValueGetter<String?>? lastOperationFailure,
  }) {
    return NodesFirmwareUpdateStatusData(
      deviceUUID: deviceUUID ?? this.deviceUUID,
      lastSuccessfulCheckTime:
          lastSuccessfulCheckTime ?? super.lastSuccessfulCheckTime,
      availableUpdate:
          availableUpdate != null ? availableUpdate() : super.availableUpdate,
      pendingOperation: pendingOperation != null
          ? pendingOperation()
          : super.pendingOperation,
      lastOperationFailure: lastOperationFailure != null
          ? lastOperationFailure()
          : super.lastOperationFailure,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'deviceUUID': deviceUUID,...super.toMap()};
  }

  factory NodesFirmwareUpdateStatusData.fromMap(Map<String, dynamic> map) {
    return NodesFirmwareUpdateStatusData(
      deviceUUID: map['deviceUUID'] as String,
      lastSuccessfulCheckTime: map['lastSuccessfulCheckTime'] as String,
      availableUpdate: map['availableUpdate'] != null
          ? FirmwareUpdateData.fromMap(
              map['availableUpdate'] as Map<String, dynamic>)
          : null,
      pendingOperation: map['pendingOperation'] != null
          ? FirmwareUpdateOperationStatus.fromMap(
              map['pendingOperation'] as Map<String, dynamic>)
          : null,
      lastOperationFailure: map['lastOperationFailure'] != null
          ? map['lastOperationFailure'] as String
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      deviceUUID,
      ...super.props,
    ];
  }
  factory NodesFirmwareUpdateStatusData.fromJson(String source) =>
      NodesFirmwareUpdateStatusData.fromMap(jsonDecode(source));
}