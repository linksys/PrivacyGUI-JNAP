import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/jnap_data/get_routing_settings.dart';

class SetRoutingSettings extends Jsonable {
  final bool isNATEnabled;
  final bool isDynamicRoutingEnabled;
  final List<NamedStaticRouteEntry> entries;

  const SetRoutingSettings({
    required this.isNATEnabled,
    required this.isDynamicRoutingEnabled,
    required this.entries,
  });

  @override
  SetRoutingSettings copyWith({
    bool? isNATEnabled,
    bool? isDynamicRoutingEnabled,
    List<NamedStaticRouteEntry>? entries,
  }) {
    return SetRoutingSettings(
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

  factory SetRoutingSettings.fromMap(Map<String, dynamic> map) {
    return SetRoutingSettings(
      isNATEnabled: map['isNATEnabled'] as bool,
      isDynamicRoutingEnabled: map['isDynamicRoutingEnabled'] as bool,
      entries: List<NamedStaticRouteEntry>.from(
        (map['entries'] as List).map<NamedStaticRouteEntry>(
          (x) => NamedStaticRouteEntry.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory SetRoutingSettings.fromJson(String source) =>
      SetRoutingSettings.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [
        isNATEnabled,
        isDynamicRoutingEnabled,
        entries,
      ];
}
