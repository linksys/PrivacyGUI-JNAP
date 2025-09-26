// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class RemoteSettingData extends Jsonable {
  final bool isEnabled;
  const RemoteSettingData({
    required this.isEnabled,
  });

  @override
  RemoteSettingData copyWith({
    bool? isEnabled,
  }) {
    return RemoteSettingData(
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isEnabled': isEnabled,
    }..removeWhere((key, value) => value == null);
  }

  @override
  factory RemoteSettingData.fromMap(Map<String, dynamic> map) {
    return RemoteSettingData(
      isEnabled: map['isEnabled'] as bool,
    );
  }

  factory RemoteSettingData.fromJson(String source) =>
      RemoteSettingData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [isEnabled];
}