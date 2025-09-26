// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class ExpressForwardingSettingsData extends Jsonable {
  final bool isExpressForwardingSupported;
  final bool? isExpressForwardingEnabled;
  const ExpressForwardingSettingsData({
    required this.isExpressForwardingSupported,
    this.isExpressForwardingEnabled,
  });

  @override
  ExpressForwardingSettingsData copyWith({
    bool? isExpressForwardingSupported,
    bool? isExpressForwardingEnabled,
  }) {
    return ExpressForwardingSettingsData(
      isExpressForwardingSupported:
          isExpressForwardingSupported ?? this.isExpressForwardingSupported,
      isExpressForwardingEnabled:
          isExpressForwardingEnabled ?? this.isExpressForwardingEnabled,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isExpressForwardingSupported': isExpressForwardingSupported,
      'isExpressForwardingEnabled': isExpressForwardingEnabled,
    };
  }

  factory ExpressForwardingSettingsData.fromMap(Map<String, dynamic> map) {
    return ExpressForwardingSettingsData(
      isExpressForwardingSupported: map['isExpressForwardingSupported'] as bool,
      isExpressForwardingEnabled: map['isExpressForwardingEnabled'] != null
          ? map['isExpressForwardingEnabled'] as bool
          : null,
    );
  }

  factory ExpressForwardingSettingsData.fromJson(String source) =>
      ExpressForwardingSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props =>
      [isExpressForwardingSupported, isExpressForwardingEnabled];

  Map<String, dynamic> toSetSettingsMap() {
    return <String, dynamic>{
      'isExpressForwardingEnabled': isExpressForwardingEnabled ?? false,
    };
  }
}