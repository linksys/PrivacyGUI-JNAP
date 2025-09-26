import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/get_routing_settings.dart';

class SetRoutingSettingsData extends Jsonable {
  final bool isNATEnabled;
  final bool isDynamicRoutingEnabled;
  final List<NamedStaticRouteEntry> entries;

  const SetRoutingSettingsData({
    required this.isNATEnabled,
    required this.isDynamicRoutingEnabled,
    required this.entries,
  });

  @override
  SetRoutingSettingsData copyWith({
    bool? isNATEnabled,
    bool? isDynamicRoutingEnabled,
    List<NamedStaticRouteEntry>? entries,
  }) {
    return SetRoutingSettingsData(
      isNATEnabled: isNATEnabled ?? this.isNATEnabled,
      isDynamicRoutingEnabled:
          isDynamicRoutingEnabled ?? this.isDynamicRoutingEnabled,
      entries: entries ?? this.entries,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isNATEnabled': isNATEnabled,
      'isDynamicRoutingEnabled': isDynamicRoutingEnabled,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory SetRoutingSettingsData.fromMap(Map<String, dynamic> map) {
    return SetRoutingSettingsData(
      isNATEnabled: map['isNATEnabled'] as bool,
      isDynamicRoutingEnabled: map['isDynamicRoutingEnabled'] as bool,
      entries: List<NamedStaticRouteEntry>.from(
        (map['entries'] as List).map<NamedStaticRouteEntry>(
          (x) => NamedStaticRouteEntry.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory SetRoutingSettingsData.fromJson(String source) =>
      SetRoutingSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [
        isNATEnabled,
        isDynamicRoutingEnabled,
        entries,
      ];
}