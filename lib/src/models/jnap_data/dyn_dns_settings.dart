// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/types.dart';

class DynDNSMailExchangeSettingsData extends Jsonable {
  final String hostName;
  final bool isBackup;
  const DynDNSMailExchangeSettingsData({
    required this.hostName,
    required this.isBackup,
  });

  @override
  DynDNSMailExchangeSettingsData copyWith({
    String? hostName,
    bool? isBackup,
  }) {
    return DynDNSMailExchangeSettingsData(
      hostName: hostName ?? this.hostName,
      isBackup: isBackup ?? this.isBackup,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hostName': hostName,
      'isBackup': isBackup,
    }..removeWhere((key, value) => value == null);
  }

  factory DynDNSMailExchangeSettingsData.fromMap(Map<String, dynamic> map) {
    return DynDNSMailExchangeSettingsData(
      hostName: map['hostName'] as String,
      isBackup: map['isBackup'] as bool,
    );
  }

  factory DynDNSMailExchangeSettingsData.fromJson(String source) =>
      DynDNSMailExchangeSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [hostName, isBackup];
}

class DynDNSSettingsData extends Jsonable {
  final String username;
  final String password;
  final String hostName;
  final bool isWildcardEnabled;
  final String mode;
  final bool isMailExchangeEnabled;
  final DynDNSMailExchangeSettingsData? mailExchangeSettings;
  const DynDNSSettingsData({
    required this.username,
    required this.password,
    required this.hostName,
    required this.isWildcardEnabled,
    required this.mode,
    required this.isMailExchangeEnabled,
    this.mailExchangeSettings,
  });

  @override
  DynDNSSettingsData copyWith({
    String? username,
    String? password,
    String? hostName,
    bool? isWildcardEnabled,
    String? mode,
    bool? isMailExchangeEnabled,
    ValueGetter<DynDNSMailExchangeSettingsData?>? mailExchangeSettings,
  }) {
    return DynDNSSettingsData(
      username: username ?? this.username,
      password: password ?? this.password,
      hostName: hostName ?? this.hostName,
      isWildcardEnabled: isWildcardEnabled ?? this.isWildcardEnabled,
      mode: mode ?? this.mode,
      isMailExchangeEnabled:
          isMailExchangeEnabled ?? this.isMailExchangeEnabled,
      mailExchangeSettings: mailExchangeSettings == null
          ? this.mailExchangeSettings
          : mailExchangeSettings.call(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'hostName': hostName,
      'isWildcardEnabled': isWildcardEnabled,
      'mode': mode,
      'isMailExchangeEnabled': isMailExchangeEnabled,
      'mailExchangeSettings':
          isMailExchangeEnabled ? mailExchangeSettings?.toMap() : null,
    }..removeWhere((key, value) => value == null);
  }

  factory DynDNSSettingsData.fromMap(Map<String, dynamic> map) {
    return DynDNSSettingsData(
      username: map['username'] as String,
      password: map['password'] as String,
      hostName: map['hostName'] as String,
      isWildcardEnabled: map['isWildcardEnabled'] as bool,
      mode: map['mode'] as String,
      isMailExchangeEnabled: map['isMailExchangeEnabled'] as bool,
      mailExchangeSettings: map['mailExchangeSettings'] != null
          ? DynDNSMailExchangeSettingsData.fromMap(
              map['mailExchangeSettings'] as Map<String, dynamic>)
          : null,
    );
  }

  factory DynDNSSettingsData.fromJson(String source) =>
      DynDNSSettingsData.fromMap(jsonDecode(source)); 

  @override
  List<Object?> get props {
    return [
      username,
      password,
      hostName,
      isWildcardEnabled,
      mode,
      isMailExchangeEnabled,
      mailExchangeSettings,
    ];
  }
}