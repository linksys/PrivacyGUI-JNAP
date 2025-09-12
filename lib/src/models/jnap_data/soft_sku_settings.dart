// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class SoftSKUSettingsData extends Jsonable {
  final String modelNumber;
  const SoftSKUSettingsData({
    required this.modelNumber,
  });

  @override
  SoftSKUSettingsData copyWith({
    String? modelNumber,
  }) {
    return SoftSKUSettingsData(
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
  factory SoftSKUSettingsData.fromMap(Map<String, dynamic> map) {
    return SoftSKUSettingsData(
      modelNumber: map['modelNumber'] as String,
    );
  }

  @override
  List<Object> get props => [modelNumber];

  factory SoftSKUSettingsData.fromJson(String source) =>
      SoftSKUSettingsData.fromMap(jsonDecode(source));
}