// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/types.dart';

class DMZSettings extends Jsonable {
  final bool isDMZEnabled;
  final DMZSourceRestriction? sourceRestriction;
  final String? destinationIPAddress;
  final String? destinationMACAddress;
  const DMZSettings({
    required this.isDMZEnabled,
    this.sourceRestriction,
    this.destinationIPAddress,
    this.destinationMACAddress,
  });

  // DMZSettings copyWith({
  //   bool? isDMZEnabled,
  //   DMZSourceRestriction? sourceRestriction,
  //   String? destinationIPAddress,
  //   String? destinationMACAddress,
  // }) {
  //   return DMZSettings(
  //     isDMZEnabled: isDMZEnabled ?? this.isDMZEnabled,
  //     sourceRestriction: sourceRestriction ?? this.sourceRestriction,
  //     destinationIPAddress: destinationIPAddress ?? this.destinationIPAddress,
  //     destinationMACAddress:
  //         destinationMACAddress ?? this.destinationMACAddress,
  //   );
  // }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDMZEnabled': isDMZEnabled,
      'sourceRestriction': sourceRestriction?.toMap(),
      'destinationIPAddress': destinationIPAddress,
      'destinationMACAddress': destinationMACAddress,
    };
  }

  factory DMZSettings.fromMap(Map<String, dynamic> map) {
    return DMZSettings(
      isDMZEnabled: map['isDMZEnabled'] as bool,
      sourceRestriction: map['sourceRestriction'] != null
          ? DMZSourceRestriction.fromMap(
              map['sourceRestriction'] as Map<String, dynamic>)
          : null,
      destinationIPAddress: map['destinationIPAddress'] != null
          ? map['destinationIPAddress'] as String
          : null,
      destinationMACAddress: map['destinationMACAddress'] != null
          ? map['destinationMACAddress'] as String
          : null,
    );
  }

  @override
  List<Object?> get props => [
        isDMZEnabled,
        sourceRestriction,
        destinationIPAddress,
        destinationMACAddress,
      ];

  @override
  DMZSettings copyWith({
    bool? isDMZEnabled,
    ValueGetter<DMZSourceRestriction?>? sourceRestriction,
    ValueGetter<String?>? destinationIPAddress,
    ValueGetter<String?>? destinationMACAddress,
  }) {
    return DMZSettings(
      isDMZEnabled: isDMZEnabled ?? this.isDMZEnabled,
      sourceRestriction: sourceRestriction != null
          ? sourceRestriction()
          : this.sourceRestriction,
      destinationIPAddress: destinationIPAddress != null
          ? destinationIPAddress()
          : this.destinationIPAddress,
      destinationMACAddress: destinationMACAddress != null
          ? destinationMACAddress()
          : this.destinationMACAddress,
    );
  }

  factory DMZSettings.fromJson(String source) =>
      DMZSettings.fromMap(jsonDecode(source));
}

class DMZSourceRestriction extends Jsonable {
  final String firstIPAddress;
  final String lastIPAddress;
  const DMZSourceRestriction({
    required this.firstIPAddress,
    required this.lastIPAddress,
  });

  @override
  DMZSourceRestriction copyWith({
    String? firstIPAddress,
    String? lastIPAddress,
  }) {
    return DMZSourceRestriction(
      firstIPAddress: firstIPAddress ?? this.firstIPAddress,
      lastIPAddress: lastIPAddress ?? this.lastIPAddress,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstIPAddress': firstIPAddress,
      'lastIPAddress': lastIPAddress,
    };
  }

  factory DMZSourceRestriction.fromMap(Map<String, dynamic> map) {
    return DMZSourceRestriction(
      firstIPAddress: map['firstIPAddress'] as String,
      lastIPAddress: (map['lastIPAddress'] ?? map['firstIPAddress']) as String,
    );
  }

  factory DMZSourceRestriction.fromJson(String source) =>
      DMZSourceRestriction.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [firstIPAddress, lastIPAddress];
}
