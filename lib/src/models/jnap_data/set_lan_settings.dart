// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/lan_settings.dart';

class SetRouterLANSettingsData extends Jsonable {
  final String ipAddress;
  final int networkPrefixLength;
  final String hostName;
  final bool isDHCPEnabled;
  final DHCPSettings? dhcpSettings;

  const SetRouterLANSettingsData({
    required this.ipAddress,
    required this.networkPrefixLength,
    required this.hostName,
    required this.isDHCPEnabled,
    this.dhcpSettings,
  });

  @override
  List<Object?> get props {
    return [
      ipAddress,
      networkPrefixLength,
      hostName,
      isDHCPEnabled,
      dhcpSettings,
    ];
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ipAddress': ipAddress,
      'networkPrefixLength': networkPrefixLength,
      'hostName': hostName,
      'isDHCPEnabled': isDHCPEnabled,
      'dhcpSettings': dhcpSettings?.toMap(),
    }..removeWhere((key, value) => value == null);
  }

  factory SetRouterLANSettingsData.fromMap(Map<String, dynamic> map) {
    return SetRouterLANSettingsData(
      ipAddress: map['ipAddress'] as String,
      networkPrefixLength: map['networkPrefixLength'] as int,
      hostName: map['hostName'] as String,
      isDHCPEnabled: map['isDHCPEnabled'] as bool,
      dhcpSettings: map['dhcpSettings'] != null
          ? DHCPSettings.fromMap(map['dhcpSettings'] as Map<String, dynamic>)
          : null,
    );
  }

  factory SetRouterLANSettingsData.fromJson(String source) =>
      SetRouterLANSettingsData.fromMap(jsonDecode(source));

  @override
  SetRouterLANSettingsData copyWith({
    String? ipAddress,
    int? networkPrefixLength,
    String? hostName,
    bool? isDHCPEnabled,
    DHCPSettings? dhcpSettings,
  }) {
    return SetRouterLANSettingsData(
      ipAddress: ipAddress ?? this.ipAddress,
      networkPrefixLength: networkPrefixLength ?? this.networkPrefixLength,
      hostName: hostName ?? this.hostName,
      isDHCPEnabled: isDHCPEnabled ?? this.isDHCPEnabled,
      dhcpSettings: dhcpSettings ?? this.dhcpSettings,
    );
  }
}