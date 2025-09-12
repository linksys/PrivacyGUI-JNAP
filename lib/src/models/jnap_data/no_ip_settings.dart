// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

class NoIPSettingsData extends Jsonable {
  final String username;
  final String password;
  final String hostName;
  const NoIPSettingsData({
    required this.username,
    required this.password,
    required this.hostName,
  });

  @override
  NoIPSettingsData copyWith({
    String? username,
    String? password,
    String? hostName,
  }) {
    return NoIPSettingsData(
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

  factory NoIPSettingsData.fromMap(Map<String, dynamic> map) {
    return NoIPSettingsData(
      username: map['username'] as String,
      password: map['password'] as String,
      hostName: map['hostName'] as String,
    );
  }

  @override
  List<Object> get props => [username, password, hostName];

  factory NoIPSettingsData.fromJson(String source) =>
      NoIPSettingsData.fromMap(jsonDecode(source));
}