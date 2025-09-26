// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/types.dart';

class GetRoutingSettingsData extends Jsonable {
  final bool isNATEnabled;
  final bool isDynamicRoutingEnabled;
  final int maxStaticRouteEntries;
  final List<NamedStaticRouteEntry> entries;

  const GetRoutingSettingsData({
    required this.isNATEnabled,
    required this.isDynamicRoutingEnabled,
    required this.maxStaticRouteEntries,
    required this.entries,
  });

  @override
  GetRoutingSettingsData copyWith({
    bool? isNATEnabled,
    bool? isDynamicRoutingEnabled,
    int? maxStaticRouteEntries,
    List<NamedStaticRouteEntry>? entries,
  }) {
    return GetRoutingSettingsData(
      isNATEnabled: isNATEnabled ?? this.isNATEnabled,
      isDynamicRoutingEnabled:
          isDynamicRoutingEnabled ?? this.isDynamicRoutingEnabled,
      maxStaticRouteEntries:
          maxStaticRouteEntries ?? this.maxStaticRouteEntries,
      entries: entries ?? this.entries,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isNATEnabled': isNATEnabled,
      'isDynamicRoutingEnabled': isDynamicRoutingEnabled,
      'maxStaticRouteEntries': maxStaticRouteEntries,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory GetRoutingSettingsData.fromMap(Map<String, dynamic> map) {
    return GetRoutingSettingsData(
      isNATEnabled: map['isNATEnabled'] as bool,
      isDynamicRoutingEnabled: map['isDynamicRoutingEnabled'] as bool,
      maxStaticRouteEntries: map['maxStaticRouteEntries'] as int,
      entries: List<NamedStaticRouteEntry>.from(
        map['entries'].map<NamedStaticRouteEntry>(
          (x) => NamedStaticRouteEntry.fromMap(x),
        ),
      ),
    );
  }

  factory GetRoutingSettingsData.fromJson(String source) =>
      GetRoutingSettingsData.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [
        isNATEnabled,
        isDynamicRoutingEnabled,
        maxStaticRouteEntries,
        entries,
      ];
}

class NamedStaticRouteEntry extends Jsonable {
  final String name;
  final StaticRouteEntry settings;

  const NamedStaticRouteEntry({
    required this.name,
    required this.settings,
  });

  @override
  NamedStaticRouteEntry copyWith({
    String? name,
    StaticRouteEntry? settings,
  }) {
    return NamedStaticRouteEntry(
      name: name ?? this.name,
      settings: settings ?? this.settings,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'settings': settings.toMap(),
    };
  }

  factory NamedStaticRouteEntry.fromMap(Map<String, dynamic> map) {
    return NamedStaticRouteEntry(
      name: map['name'] as String,
      settings:
          StaticRouteEntry.fromMap(map['settings'] as Map<String, dynamic>),
    );
  }

  factory NamedStaticRouteEntry.fromJson(String source) =>
      NamedStaticRouteEntry.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [
        name,
        settings,
      ];
}

class StaticRouteEntry extends Jsonable {
  final String destinationLAN;
  final String? gateway;
  final String interface;
  final int networkPrefixLength;

  const StaticRouteEntry({
    required this.destinationLAN,
    this.gateway,
    required this.interface,
    required this.networkPrefixLength,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'destinationLAN': destinationLAN,
      'gateway': gateway,
      'interface': interface,
      'networkPrefixLength': networkPrefixLength,
    };
  }

  factory StaticRouteEntry.fromMap(Map<String, dynamic> map) {
    return StaticRouteEntry(
      destinationLAN: map['destinationLAN'] ?? '',
      gateway: map['gateway'],
      interface: map['interface'] ?? '',
      networkPrefixLength: map['networkPrefixLength']?.toInt() ?? 0,
    );
  }

  factory StaticRouteEntry.fromJson(String source) =>
      StaticRouteEntry.fromMap(jsonDecode(source));

  @override
  List<Object?> get props =>
      [destinationLAN, gateway, interface, networkPrefixLength];

  @override
  StaticRouteEntry copyWith({
    String? destinationLAN,
    ValueGetter<String?>? gateway,
    String? interface,
    int? networkPrefixLength,
  }) {
    return StaticRouteEntry(
      destinationLAN: destinationLAN ?? this.destinationLAN,
      gateway: gateway != null ? gateway() : this.gateway,
      interface: interface ?? this.interface,
      networkPrefixLength: networkPrefixLength ?? this.networkPrefixLength,
    );
  }

  @override
  String toString() {
    return 'StaticRouteEntry(destinationLAN: $destinationLAN, gateway: $gateway, interface: $interface, networkPrefixLength: $networkPrefixLength)';
  }
}