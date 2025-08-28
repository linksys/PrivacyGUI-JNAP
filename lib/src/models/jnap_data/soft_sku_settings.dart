// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class SoftSKUSettings extends Jsonable {
  final String modelNumber;
  const SoftSKUSettings({
    required this.modelNumber,
  });

  @override
  SoftSKUSettings copyWith({
    String? modelNumber,
  }) {
    return SoftSKUSettings(
      modelNumber: modelNumber ?? this.modelNumber,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modelNumber': modelNumber,
    };
  }

  @override
  factory SoftSKUSettings.fromMap(Map<String, dynamic> map) {
    return SoftSKUSettings(
      modelNumber: map['modelNumber'] as String,
    );
  }

  @override
  List<Object> get props => [modelNumber];

  factory SoftSKUSettings.fromJson(String source) =>
      SoftSKUSettings.fromMap(jsonDecode(source));
}
