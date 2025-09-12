// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/types.dart';

class FirmwareUpdateStatusData extends Jsonable {
  final String lastSuccessfulCheckTime;
  final FirmwareUpdateData? availableUpdate;
  final FirmwareUpdateOperationStatus? pendingOperation;
  final String? lastOperationFailure;
  const FirmwareUpdateStatusData({
    required this.lastSuccessfulCheckTime,
    this.availableUpdate,
    this.pendingOperation,
    this.lastOperationFailure,
  });

  @override
  FirmwareUpdateStatusData copyWith({
    String? lastSuccessfulCheckTime,
    ValueGetter<FirmwareUpdateData?>? availableUpdate,
    ValueGetter<FirmwareUpdateOperationStatus?>? pendingOperation,
    ValueGetter<String?>? lastOperationFailure,
  }) {
    return FirmwareUpdateStatusData(
      lastSuccessfulCheckTime:
          lastSuccessfulCheckTime ?? this.lastSuccessfulCheckTime,
      availableUpdate:
          availableUpdate != null ? availableUpdate() : this.availableUpdate,
      pendingOperation:
          pendingOperation != null ? pendingOperation() : this.pendingOperation,
      lastOperationFailure: lastOperationFailure != null
          ? lastOperationFailure()
          : this.lastOperationFailure,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastSuccessfulCheckTime': lastSuccessfulCheckTime,
      'availableUpdate': availableUpdate?.toMap(),
      'pendingOperation': pendingOperation?.toMap(),
      'lastOperationFailure': lastOperationFailure,
    };
  }

  factory FirmwareUpdateStatusData.fromMap(Map<String, dynamic> map) {
    return FirmwareUpdateStatusData(
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

  factory FirmwareUpdateStatusData.fromJson(String source) =>
      FirmwareUpdateStatusData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [
        lastSuccessfulCheckTime,
        availableUpdate,
        pendingOperation,
        lastOperationFailure
      ];
}

class FirmwareUpdateData extends Jsonable {
  final String firmwareVersion;
  final String firmwareDate;
  final String? description;
  const FirmwareUpdateData({
    required this.firmwareVersion,
    required this.firmwareDate,
    this.description,
  });

  @override
  FirmwareUpdateData copyWith({
    String? firmwareVersion,
    String? firmwareDate,
    String? description,
  }) {
    return FirmwareUpdateData(
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      firmwareDate: firmwareDate ?? this.firmwareDate,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firmwareVersion': firmwareVersion,
      'firmwareDate': firmwareDate,
      'description': description,
    };
  }

  factory FirmwareUpdateData.fromMap(Map<String, dynamic> map) {
    return FirmwareUpdateData(
      firmwareVersion: map['firmwareVersion'] as String,
      firmwareDate: map['firmwareDate'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  factory FirmwareUpdateData.fromJson(String source) =>
      FirmwareUpdateData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [firmwareVersion, firmwareDate, description];
}

class FirmwareUpdateOperationStatus extends Jsonable {
  final String operation;
  final int progressPercent;
  const FirmwareUpdateOperationStatus({
    required this.operation,
    required this.progressPercent,
  });

  @override
  FirmwareUpdateOperationStatus copyWith({
    String? operation,
    int? progressPercent,
  }) {
    return FirmwareUpdateOperationStatus(
      operation: operation ?? this.operation,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'operation': operation,
      'progressPercent': progressPercent,
    };
  }

  factory FirmwareUpdateOperationStatus.fromMap(Map<String, dynamic> map) {
    return FirmwareUpdateOperationStatus(
      operation: map['operation'] as String,
      progressPercent: map['progressPercent'] as int,
    );
  }

  factory FirmwareUpdateOperationStatus.fromJson(String source) =>
      FirmwareUpdateOperationStatus.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [operation, progressPercent];
}