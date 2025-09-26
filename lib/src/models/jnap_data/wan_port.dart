// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class WANPortData extends Jsonable {
  final int portId;
  const WANPortData({
    required this.portId,
  });

  @override
  WANPortData copyWith({
    int? portId,
  }) {
    return WANPortData(
      portId: portId ?? this.portId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'portId': portId,
    }..removeWhere((key, value) => value == null);
  }

  factory WANPortData.fromMap(Map<String, dynamic> map) {
    return WANPortData(
      portId: map['portId'] as int,
    );
  }

  factory WANPortData.fromJson(String source) => WANPortData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [portId];
}