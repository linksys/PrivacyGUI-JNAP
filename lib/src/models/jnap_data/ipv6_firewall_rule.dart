// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class PortRange extends Jsonable {
  final String protocol;
  final int firstPort;
  final int lastPort;
  const PortRange({
    required this.protocol,
    required this.firstPort,
    required this.lastPort,
  });

  @override
  PortRange copyWith({
    String? protocol,
    int? firstPort,
    int? lastPort,
  }) {
    return PortRange(
      protocol: protocol ?? this.protocol,
      firstPort: firstPort ?? this.firstPort,
      lastPort: lastPort ?? this.lastPort,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'protocol': protocol,
      'firstPort': firstPort,
      'lastPort': lastPort,
    };
  }

  factory PortRange.fromMap(Map<String, dynamic> map) {
    return PortRange(
      protocol: map['protocol'] as String,
      firstPort: map['firstPort'] as int,
      lastPort: map['lastPort'] as int,
    );
  }

  @override
  List<Object> get props => [protocol, firstPort, lastPort];

  factory PortRange.fromJson(String source) =>
      PortRange.fromMap(jsonDecode(source));
}

class IPv6FirewallRule extends Jsonable {
  final String description;
  final String ipv6Address;
  final bool isEnabled;
  final List<PortRange> portRanges;
  const IPv6FirewallRule({
    required this.description,
    required this.ipv6Address,
    required this.isEnabled,
    required this.portRanges,
  });

  @override
  IPv6FirewallRule copyWith({
    String? description,
    String? ipv6Address,
    bool? isEnabled,
    List<PortRange>? portRanges,
  }) {
    return IPv6FirewallRule(
      description: description ?? this.description,
      ipv6Address: ipv6Address ?? this.ipv6Address,
      isEnabled: isEnabled ?? this.isEnabled,
      portRanges: portRanges ?? this.portRanges,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'ipv6Address': ipv6Address,
      'isEnabled': isEnabled,
      'portRanges': portRanges.map((x) => x.toMap()).toList(),
    };
  }

  factory IPv6FirewallRule.fromMap(Map<String, dynamic> map) {
    return IPv6FirewallRule(
      description: map['description'] as String,
      ipv6Address: map['ipv6Address'] as String,
      isEnabled: map['isEnabled'] as bool,
      portRanges: List<PortRange>.from(
        map['portRanges'].map<PortRange>(
          (x) => PortRange.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  List<Object> get props => [description, ipv6Address, isEnabled, portRanges];

  factory IPv6FirewallRule.fromJson(String source) =>
      IPv6FirewallRule.fromMap(jsonDecode(source));
}
