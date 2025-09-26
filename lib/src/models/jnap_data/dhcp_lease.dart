// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class DhcpLeaseData extends Jsonable {
  final String macAddress;
  final String ipAddress;
  final String expiration;
  final String? hostName;
  final String clientID;
  const DhcpLeaseData({
    required this.macAddress,
    required this.ipAddress,
    required this.expiration,
    this.hostName,
    required this.clientID,
  });

  @override
  DhcpLeaseData copyWith({
    String? macAddress,
    String? ipAddress,
    String? expiration,
    String? hostName,
    String? clientID,
  }) {
    return DhcpLeaseData(
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

  factory DhcpLeaseData.fromMap(Map<String, dynamic> map) {
    return DhcpLeaseData(
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

  factory DhcpLeaseData.fromJson(String source) => DhcpLeaseData.fromMap(jsonDecode(source));
}