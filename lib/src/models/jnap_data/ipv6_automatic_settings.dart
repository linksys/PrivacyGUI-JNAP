import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class IPv6AutomaticSettings extends Jsonable {
  final bool isIPv6AutomaticEnabled;
  final String? ipv6rdTunnelMode;
  final IPv6rdTunnelSettings? ipv6rdTunnelSettings;

  @override
  List<Object?> get props => [
        isIPv6AutomaticEnabled,
        ipv6rdTunnelMode,
        ipv6rdTunnelSettings,
      ];

  const IPv6AutomaticSettings({
    required this.isIPv6AutomaticEnabled,
    this.ipv6rdTunnelMode,
    this.ipv6rdTunnelSettings,
  });

  IPv6AutomaticSettings copyWith({
    bool? isIPv6AutomaticEnabled,
    String? ipv6rdTunnelMode,
    IPv6rdTunnelSettings? ipv6rdTunnelSettings,
  }) {
    return IPv6AutomaticSettings(
      isIPv6AutomaticEnabled:
          isIPv6AutomaticEnabled ?? this.isIPv6AutomaticEnabled,
      ipv6rdTunnelMode: ipv6rdTunnelMode ?? this.ipv6rdTunnelMode,
      ipv6rdTunnelSettings: ipv6rdTunnelSettings ?? this.ipv6rdTunnelSettings,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isIPv6AutomaticEnabled': isIPv6AutomaticEnabled,
      'ipv6rdTunnelMode': ipv6rdTunnelMode,
      'ipv6rdTunnelSettings': ipv6rdTunnelSettings?.toMap(),
    }..removeWhere((key, value) => value == null);
  }

  factory IPv6AutomaticSettings.fromMap(Map<String, dynamic> map) {
    return IPv6AutomaticSettings(
      isIPv6AutomaticEnabled: map['isIPv6AutomaticEnabled'] as bool,
      ipv6rdTunnelMode: map['ipv6rdTunnelMode'] as String?,
      ipv6rdTunnelSettings: map['ipv6rdTunnelSettings'] == null
          ? null
          : IPv6rdTunnelSettings.fromMap(
              map['ipv6rdTunnelSettings'] as Map<String, dynamic>,
            ),
    );
  }

  factory IPv6AutomaticSettings.fromJson(String json) =>
      IPv6AutomaticSettings.fromMap(jsonDecode(json) as Map<String, dynamic>);
}

class IPv6rdTunnelSettings extends Jsonable {
  final String prefix;
  final int prefixLength;
  final String borderRelay;
  final int borderRelayPrefixLength;

  @override
  List<Object?> get props => [
        prefix,
        prefixLength,
        borderRelay,
        borderRelayPrefixLength,
      ];

  const IPv6rdTunnelSettings({
    required this.prefix,
    required this.prefixLength,
    required this.borderRelay,
    required this.borderRelayPrefixLength,
  });

  @override
  IPv6rdTunnelSettings copyWith({
    String? prefix,
    int? prefixLength,
    String? borderRelay,
    int? borderRelayPrefixLength,
  }) {
    return IPv6rdTunnelSettings(
      prefix: prefix ?? this.prefix,
      prefixLength: prefixLength ?? this.prefixLength,
      borderRelay: borderRelay ?? this.borderRelay,
      borderRelayPrefixLength:
          borderRelayPrefixLength ?? this.borderRelayPrefixLength,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'prefix': prefix,
      'prefixLength': prefixLength,
      'borderRelay': borderRelay,
      'borderRelayPrefixLength': borderRelayPrefixLength,
    }..removeWhere((key, value) => value == null);
  }

  factory IPv6rdTunnelSettings.fromMap(Map<String, dynamic> map) {
    return IPv6rdTunnelSettings(
      prefix: map['prefix'],
      prefixLength: map['prefixLength'],
      borderRelay: map['borderRelay'],
      borderRelayPrefixLength: map['borderRelayPrefixLength'],
    );
  }

  factory IPv6rdTunnelSettings.fromJson(String json) =>
      IPv6rdTunnelSettings.fromMap(jsonDecode(json) as Map<String, dynamic>);
}
