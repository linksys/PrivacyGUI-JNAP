// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class SendSysinfoEmail extends Jsonable {
  final List<String> addressList;

  const SendSysinfoEmail({
    required this.addressList,
  });

  @override
  SendSysinfoEmail copyWith({
    List<String>? addressList,
  }) {
    return SendSysinfoEmail(
      addressList: addressList ?? this.addressList,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressList': addressList,
    }..removeWhere((key, value) => value == null);
  }

  @override
  factory SendSysinfoEmail.fromMap(Map<String, dynamic> map) {
    return SendSysinfoEmail(
        addressList: List<String>.from(
      map['addressList'],
    ));
  }

  factory SendSysinfoEmail.fromJson(String source) =>
      SendSysinfoEmail.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [addressList];
}
