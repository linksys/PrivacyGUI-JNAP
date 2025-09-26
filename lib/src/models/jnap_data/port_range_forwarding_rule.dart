import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class PortRangeForwardingRuleData extends Jsonable {
  const PortRangeForwardingRuleData({
    required this.isEnabled,
    required this.firstExternalPort,
    required this.protocol,
    required this.internalServerIPAddress,
    required this.lastExternalPort,
    required this.description,
  });

  final bool isEnabled;
  final int firstExternalPort;
  final String protocol;
  final String internalServerIPAddress;
  final int lastExternalPort;
  final String description;

  @override
  List<Object> get props => [
        isEnabled,
        firstExternalPort,
        protocol,
        internalServerIPAddress,
        lastExternalPort,
        description,
      ];

  @override
  PortRangeForwardingRuleData copyWith({
    bool? isEnabled,
    int? firstExternalPort,
    String? protocol,
    String? internalServerIPAddress,
    int? lastExternalPort,
    String? description,
  }) {
    return PortRangeForwardingRuleData(
      isEnabled: isEnabled ?? this.isEnabled,
      firstExternalPort: firstExternalPort ?? this.firstExternalPort,
      protocol: protocol ?? this.protocol,
      internalServerIPAddress:
          internalServerIPAddress ?? this.internalServerIPAddress,
      lastExternalPort: lastExternalPort ?? this.lastExternalPort,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'firstExternalPort': firstExternalPort,
      'protocol': protocol,
      'internalServerIPAddress': internalServerIPAddress,
      'lastExternalPort': lastExternalPort,
      'description': description,
    };
  }

  @override
  factory PortRangeForwardingRuleData.fromMap(Map<String, dynamic> json) {
    return PortRangeForwardingRuleData(
      isEnabled: json['isEnabled'],
      firstExternalPort: json['firstExternalPort'],
      protocol: json['protocol'],
      internalServerIPAddress: json['internalServerIPAddress'],
      lastExternalPort: json['lastExternalPort'],
      description: json['description'],
    );
  }

  factory PortRangeForwardingRuleData.fromJson(String source) =>
      PortRangeForwardingRuleData.fromMap(jsonDecode(source));
}