// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class NoIPSettings extends Jsonable {
  final String username;
  final String password;
  final String hostName;
  const NoIPSettings({
    required this.username,
    required this.password,
    required this.hostName,
  });

  @override
  NoIPSettings copyWith({
    String? username,
    String? password,
    String? hostName,
  }) {
    return NoIPSettings(
      username: username ?? this.username,
      password: password ?? this.password,
      hostName: hostName ?? this.hostName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'hostName': hostName,
    }..removeWhere((key, value) => value == null);
  }

  factory NoIPSettings.fromMap(Map<String, dynamic> map) {
    return NoIPSettings(
      username: map['username'] as String,
      password: map['password'] as String,
      hostName: map['hostName'] as String,
    );
  }

  @override
  List<Object> get props => [username, password, hostName];

  factory NoIPSettings.fromJson(String source) =>
      NoIPSettings.fromMap(jsonDecode(source));
}
