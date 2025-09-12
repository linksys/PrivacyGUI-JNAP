// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class ManagementSettingsData extends Jsonable {
  final bool canManageUsingHTTP;
  final bool canManageUsingHTTPS;
  final bool isManageWirelesslySupported;
  final bool? canManageWirelessly;
  final bool canManageRemotely;
  const ManagementSettingsData({
    required this.canManageUsingHTTP,
    required this.canManageUsingHTTPS,
    required this.isManageWirelesslySupported,
    this.canManageWirelessly,
    required this.canManageRemotely,
  });

  @override
  ManagementSettingsData copyWith({
    bool? canManageUsingHTTP,
    bool? canManageUsingHTTPS,
    bool? isManageWirelesslySupported,
    bool? canManageWirelessly,
    bool? canManageRemotely,
  }) {
    return ManagementSettingsData(
      canManageUsingHTTP: canManageUsingHTTP ?? this.canManageUsingHTTP,
      canManageUsingHTTPS: canManageUsingHTTPS ?? this.canManageUsingHTTPS,
      isManageWirelesslySupported:
          isManageWirelesslySupported ?? this.isManageWirelesslySupported,
      canManageWirelessly: canManageWirelessly ?? this.canManageWirelessly,
      canManageRemotely: canManageRemotely ?? this.canManageRemotely,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'canManageUsingHTTP': canManageUsingHTTP,
      'canManageUsingHTTPS': canManageUsingHTTPS,
      'isManageWirelesslySupported': isManageWirelesslySupported,
      'canManageWirelessly': canManageWirelessly,
      'canManageRemotely': canManageRemotely,
    };
  }

  factory ManagementSettingsData.fromMap(Map<String, dynamic> map) {
    return ManagementSettingsData(
      canManageUsingHTTP: map['canManageUsingHTTP'] as bool,
      canManageUsingHTTPS: map['canManageUsingHTTPS'] as bool,
      isManageWirelesslySupported: map['isManageWirelesslySupported'] as bool,
      canManageWirelessly: map['canManageWirelessly'] != null
          ? map['canManageWirelessly'] as bool
          : null,
      canManageRemotely: map['canManageRemotely'] as bool,
    );
  }

  @override
  List<Object?> get props {
    return [
      canManageUsingHTTP,
      canManageUsingHTTPS,
      isManageWirelesslySupported,
      canManageWirelessly,
      canManageRemotely,
    ];
  }

  Map<String, dynamic> toSetSettingsMap() {
    return <String, dynamic>{
      'canManageUsingHTTP': canManageUsingHTTP,
      'canManageUsingHTTPS': canManageUsingHTTPS,
      'canManageWirelessly': canManageWirelessly ?? false,
      'canManageRemotely': canManageRemotely,
    };
  }

  factory ManagementSettingsData.fromJson(String source) =>
      ManagementSettingsData.fromMap(jsonDecode(source));
}