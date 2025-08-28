// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class ALGSettings extends Jsonable {
  final bool isSIPEnabled;
  const ALGSettings({
    required this.isSIPEnabled,
  });

  @override
  ALGSettings copyWith({
    bool? isSIPEnabled,
  }) {
    return ALGSettings(
      isSIPEnabled: isSIPEnabled ?? this.isSIPEnabled,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSIPEnabled': isSIPEnabled,
    };
  }

  factory ALGSettings.fromMap(Map<String, dynamic> map) {
    return ALGSettings(
      isSIPEnabled: map['isSIPEnabled'] as bool,
    );
  }

  factory ALGSettings.fromJson(String source) =>
      ALGSettings.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [isSIPEnabled];
}
