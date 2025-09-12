// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class UPnPSettingsData extends Jsonable {
  final bool isUPnPEnabled;
  final bool canUsersConfigure;
  final bool canUsersDisableWANAccess;
  const UPnPSettingsData({
    required this.isUPnPEnabled,
    required this.canUsersConfigure,
    required this.canUsersDisableWANAccess,
  });

  @override
  UPnPSettingsData copyWith({
    bool? isUPnPEnabled,
    bool? canUsersConfigure,
    bool? canUsersDisableWANAccess,
  }) {
    return UPnPSettingsData(
      isUPnPEnabled: isUPnPEnabled ?? this.isUPnPEnabled,
      canUsersConfigure: canUsersConfigure ?? this.canUsersConfigure,
      canUsersDisableWANAccess:
          canUsersDisableWANAccess ?? this.canUsersDisableWANAccess,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isUPnPEnabled': isUPnPEnabled,
      'canUsersConfigure': canUsersConfigure,
      'canUsersDisableWANAccess': canUsersDisableWANAccess,
    };
  }

  factory UPnPSettingsData.fromMap(Map<String, dynamic> map) {
    return UPnPSettingsData(
      isUPnPEnabled: map['isUPnPEnabled'] as bool,
      canUsersConfigure: map['canUsersConfigure'] as bool,
      canUsersDisableWANAccess: map['canUsersDisableWANAccess'] as bool,
    );
  }

  @override
  List<Object> get props =>
      [isUPnPEnabled, canUsersConfigure, canUsersDisableWANAccess];

  factory UPnPSettingsData.fromJson(String source) =>
      UPnPSettingsData.fromMap(jsonDecode(source));
}