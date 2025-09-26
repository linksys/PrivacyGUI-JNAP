// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class ALGSettingsData extends Jsonable {
  final bool isSIPEnabled;
  const ALGSettingsData({
    required this.isSIPEnabled,
  });

  @override
  ALGSettingsData copyWith({
    bool? isSIPEnabled,
  }) {
    return ALGSettingsData(
      isSIPEnabled: isSIPEnabled ?? this.isSIPEnabled,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSIPEnabled': isSIPEnabled,
    };
  }

  factory ALGSettingsData.fromMap(Map<String, dynamic> map) {
    return ALGSettingsData(
      isSIPEnabled: map['isSIPEnabled'] as bool,
    );
  }

  factory ALGSettingsData.fromJson(String source) =>
      ALGSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [isSIPEnabled];
}