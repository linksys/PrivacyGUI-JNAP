// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class DhcpLease extends Jsonable {
  final String macAddress;
  final String ipAddress;
  final String expiration;
  final String? hostName;
  final String clientID;
  const DhcpLease({
    required this.macAddress,
    required this.ipAddress,
    required this.expiration,
    this.hostName,
    required this.clientID,
  });

  @override
  DhcpLease copyWith({
    String? macAddress,
    String? ipAddress,
    String? expiration,
    String? hostName,
    String? clientID,
  }) {
    return DhcpLease(
      macAddress: macAddress ?? this.macAddress,
      ipAddress: ipAddress ?? this.ipAddress,
      expiration: expiration ?? this.expiration,
      hostName: hostName ?? this.hostName,
      clientID: clientID ?? this.clientID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'macAddress': macAddress,
      'ipAddress': ipAddress,
      'expiration': expiration,
      'hostName': hostName,
      'clientID': clientID,
    };
  }

  factory DhcpLease.fromMap(Map<String, dynamic> map) {
    return DhcpLease(
      macAddress: map['macAddress'] as String,
      ipAddress: map['ipAddress'] as String,
      expiration: map['expiration'] as String,
      hostName: map['hostName'] != null ? map['hostName'] as String : null,
      clientID: map['clientID'] as String,
    );
  }

  @override
  List<Object?> get props {
    return [
      macAddress,
      ipAddress,
      expiration,
      hostName,
      clientID,
    ];
  }

  factory DhcpLease.fromJson(String source) => DhcpLease.fromMap(jsonDecode(source));
}
