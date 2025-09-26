// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jnap/src/models/jsonable.dart';

class SendSysinfoEmailData extends Jsonable {
  final List<String> addressList;

  const SendSysinfoEmailData({
    required this.addressList,
  });

  @override
  SendSysinfoEmailData copyWith({
    List<String>? addressList,
  }) {
    return SendSysinfoEmailData(
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
  factory SendSysinfoEmailData.fromMap(Map<String, dynamic> map) {
    return SendSysinfoEmailData(
        addressList: List<String>.from(
      map['addressList'],
    ));
  }

  factory SendSysinfoEmailData.fromJson(String source) =>
      SendSysinfoEmailData.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [addressList];
}