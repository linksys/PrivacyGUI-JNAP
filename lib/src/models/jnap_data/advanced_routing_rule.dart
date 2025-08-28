import 'dart:convert';

import '../jsonable.dart';

/// isEnabled : true
/// externalPort : 3074
/// protocol : "TCP"
/// internalServerIPAddress : "192.168.1.150"
/// internalPort : 3074
/// description : "XBox Live (TM)"

class AdvancedRoutingRule extends Jsonable {
  const AdvancedRoutingRule({
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
  AdvancedRoutingRule copyWith({
    bool? isEnabled,
    int? externalPort,
    String? protocol,
    String? internalServerIPAddress,
    int? internalPort,
    String? description,
  }) {
    return AdvancedRoutingRule(
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

  factory AdvancedRoutingRule.fromMap(Map<String, dynamic> map) {
    return AdvancedRoutingRule(
      isEnabled: map['isEnabled'],
      externalPort: map['externalPort'],
      protocol: map['protocol'],
      internalServerIPAddress: map['internalServerIPAddress'],
      internalPort: map['internalPort'],
      description: map['description'],
    );
  }
  factory AdvancedRoutingRule.fromJson(String source) =>
      AdvancedRoutingRule.fromMap(jsonDecode(source));
}
