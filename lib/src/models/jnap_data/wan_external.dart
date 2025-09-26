// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../jsonable.dart';

class WanExternalData extends Jsonable {
  final String? publicWanIPv4;
  final String? publicWanIPv6;
  final String? privateWanIPv4;
  final String? privateWanIPv6;

  const WanExternalData({
    this.publicWanIPv4,
    this.publicWanIPv6,
    this.privateWanIPv4,
    this.privateWanIPv6,
  });

  @override
  WanExternalData copyWith({
    String? publicWanIPv4,
    String? publicWanIPv6,
    String? privateWanIPv4,
    String? privateWanIPv6,
  }) {
    return WanExternalData(
      publicWanIPv4: publicWanIPv4 ?? this.publicWanIPv4,
      publicWanIPv6: publicWanIPv6 ?? this.publicWanIPv6,
      privateWanIPv4: privateWanIPv4 ?? this.privateWanIPv4,
      privateWanIPv6: privateWanIPv6 ?? this.privateWanIPv6,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PublicWanIPv4': publicWanIPv4,
      'PublicWanIPv6': publicWanIPv6,
      'PrivateWanIPv4': privateWanIPv4,
      'PrivateWanIPv6': privateWanIPv6,
    };
  }

  factory WanExternalData.fromMap(Map<String, dynamic> map) {
    return WanExternalData(
      publicWanIPv4:
          map['PublicWanIPv4'] != null ? map['PublicWanIPv4'] as String : null,
      publicWanIPv6:
          map['PublicWanIPv6'] != null ? map['PublicWanIPv6'] as String : null,
      privateWanIPv4: map['PrivateWanIPv4'] != null
          ? map['PrivateWanIPv4'] as String
          : null,
      privateWanIPv6: map['PrivateWanIPv6'] != null
          ? map['PrivateWanIPv6'] as String
          : null,
    );
  }

  factory WanExternalData.fromJson(String source) =>
      WanExternalData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [
        publicWanIPv4,
        publicWanIPv6,
        privateWanIPv4,
        privateWanIPv6,
      ];
}