import 'dart:convert';

import '../jsonable.dart';

class SupportedTimezoneData extends Jsonable {
  final bool observesDST;
  final String timeZoneID;
  final String description;
  final int utcOffsetMinutes;

  @override
  List<Object?> get props => [
        observesDST,
        timeZoneID,
        description,
        utcOffsetMinutes,
      ];

  const SupportedTimezoneData({
    required this.observesDST,
    required this.timeZoneID,
    required this.description,
    required this.utcOffsetMinutes,
  });

  @override
  SupportedTimezoneData copyWith({
    bool? observesDST,
    String? timeZoneID,
    String? description,
    int? utcOffsetMinutes,
  }) {
    return SupportedTimezoneData(
      observesDST: observesDST ?? this.observesDST,
      timeZoneID: timeZoneID ?? this.timeZoneID,
      description: description ?? this.description,
      utcOffsetMinutes: utcOffsetMinutes ?? this.utcOffsetMinutes,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'observesDST': observesDST,
      'timeZoneID': timeZoneID,
      'description': description,
      'utcOffsetMinutes': utcOffsetMinutes,
    }..removeWhere((key, value) => value == null);
  }

  factory SupportedTimezoneData.fromMap(Map<String, dynamic> json) {
    return SupportedTimezoneData(
      observesDST: json['observesDST'],
      timeZoneID: json['timeZoneID'],
      description: json['description'],
      utcOffsetMinutes: json['utcOffsetMinutes'],
    );
  }
  factory SupportedTimezoneData.fromJson(String source) =>
      SupportedTimezoneData.fromMap(jsonDecode(source));
}