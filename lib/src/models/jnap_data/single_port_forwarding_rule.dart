import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class SinglePortForwardingRuleData extends Jsonable {
  const SinglePortForwardingRuleData({
    required this.isEnabled,
    required this.externalPort,
    required this.protocol,
    required this.internalServerIPAddress,
    required this.internalPort,
    required this.description,
  });

  final bool isEnabled;
  final int externalPort;
  final String protocol;
  final String internalServerIPAddress;
  final int internalPort;
  final String description;

  @override
  List<Object> get props => [
        isEnabled,
        externalPort,
        protocol,
        internalServerIPAddress,
        internalPort,
        description,
      ];

  @override
  SinglePortForwardingRuleData copyWith({
    bool? isEnabled,
    int? externalPort,
    String? protocol,
    String? internalServerIPAddress,
    int? internalPort,
    String? description,
  }) {
    return SinglePortForwardingRuleData(
      isEnabled: isEnabled ?? this.isEnabled,
      externalPort: externalPort ?? this.externalPort,
      protocol: protocol ?? this.protocol,
      internalServerIPAddress:
          internalServerIPAddress ?? this.internalServerIPAddress,
      internalPort: internalPort ?? this.internalPort,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'externalPort': externalPort,
      'protocol': protocol,
      'internalServerIPAddress': internalServerIPAddress,
      'internalPort': internalPort,
      'description': description,
    };
  }

  @override
  factory SinglePortForwardingRuleData.fromMap(Map<String, dynamic> json) {
    return SinglePortForwardingRuleData(
      isEnabled: json['isEnabled'],
      externalPort: json['externalPort'],
      protocol: json['protocol'],
      internalServerIPAddress: json['internalServerIPAddress'],
      internalPort: json['internalPort'],
      description: json['description'],
    );
  }

  factory SinglePortForwardingRuleData.fromJson(String source) =>
      SinglePortForwardingRuleData.fromMap(jsonDecode(source));
}