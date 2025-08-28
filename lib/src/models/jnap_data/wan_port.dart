// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class WANPort extends Jsonable {
  final int portId;
  const WANPort({
    required this.portId,
  });

  @override
  WANPort copyWith({
    int? portId,
  }) {
    return WANPort(
      portId: portId ?? this.portId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'portId': portId,
    }..removeWhere((key, value) => value == null);
  }

  factory WANPort.fromMap(Map<String, dynamic> map) {
    return WANPort(
      portId: map['portId'] as int,
    );
  }

  factory WANPort.fromJson(String source) => WANPort.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [portId];
}