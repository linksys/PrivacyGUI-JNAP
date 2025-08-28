// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class RemoteSetting extends Jsonable {
  final bool isEnabled;
  const RemoteSetting({
    required this.isEnabled,
  });

  @override
  RemoteSetting copyWith({
    bool? isEnabled,
  }) {
    return RemoteSetting(
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
  factory RemoteSetting.fromMap(Map<String, dynamic> map) {
    return RemoteSetting(
      isEnabled: map['isEnabled'] as bool,
    );
  }

  factory RemoteSetting.fromJson(String source) =>
      RemoteSetting.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [isEnabled];
}
