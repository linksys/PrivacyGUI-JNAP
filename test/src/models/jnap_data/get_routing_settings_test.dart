import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/get_routing_settings.dart';

void main() {
  group('StaticRouteEntry', () {
    const staticRouteEntry = StaticRouteEntry(
      destinationLAN: '192.168.2.0',
      gateway: '192.168.1.1',
      interface: 'LAN',
      networkPrefixLength: 24,
    );

    final Map<String, dynamic> staticRouteEntryMap = {
      'destinationLAN': '192.168.2.0',
      'gateway': '192.168.1.1',
      'interface': 'LAN',
      'networkPrefixLength': 24,
    };

    test('toMap returns a valid map', () {
      expect(staticRouteEntry.toMap(), staticRouteEntryMap);
    });

    test('fromMap creates a valid object', () {
      expect(StaticRouteEntry.fromMap(staticRouteEntryMap), staticRouteEntry);
    });

    test('toJson returns a valid JSON string', () {
      expect(staticRouteEntry.toJson(), json.encode(staticRouteEntryMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(StaticRouteEntry.fromJson(json.encode(staticRouteEntryMap)), staticRouteEntry);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedEntry = staticRouteEntry.copyWith(
        destinationLAN: '192.168.3.0',
        gateway: () => '192.168.1.2',
      );
      expect(updatedEntry.destinationLAN, '192.168.3.0');
      expect(updatedEntry.gateway, '192.168.1.2');
      expect(updatedEntry.interface, staticRouteEntry.interface);
    });

    test('props are correct', () {
      final entry1 = StaticRouteEntry(destinationLAN: 'd1', interface: 'i1', networkPrefixLength: 1);
      final entry2 = StaticRouteEntry(destinationLAN: 'd1', interface: 'i1', networkPrefixLength: 1);
      final entry3 = StaticRouteEntry(destinationLAN: 'd2', interface: 'i2', networkPrefixLength: 2);
      expect(entry1, entry2);
      expect(entry1.props, entry2.props);
      expect(entry1 == entry3, false);
      expect(entry1.props == entry3.props, false);
    });
  });

  group('NamedStaticRouteEntry', () {
    const staticRouteEntry = StaticRouteEntry(
      destinationLAN: '192.168.2.0',
      gateway: '192.168.1.1',
      interface: 'LAN',
      networkPrefixLength: 24,
    );

    const namedStaticRouteEntry = NamedStaticRouteEntry(
      name: 'Route1',
      settings: staticRouteEntry,
    );

    final Map<String, dynamic> namedStaticRouteEntryMap = {
      'name': 'Route1',
      'settings': staticRouteEntry.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(namedStaticRouteEntry.toMap(), namedStaticRouteEntryMap);
    });

    test('fromMap creates a valid object', () {
      expect(NamedStaticRouteEntry.fromMap(namedStaticRouteEntryMap), namedStaticRouteEntry);
    });

    test('toJson returns a valid JSON string', () {
      expect(namedStaticRouteEntry.toJson(), json.encode(namedStaticRouteEntryMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NamedStaticRouteEntry.fromJson(json.encode(namedStaticRouteEntryMap)), namedStaticRouteEntry);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedEntry = namedStaticRouteEntry.copyWith(
        name: 'Route2',
      );
      expect(updatedEntry.name, 'Route2');
      expect(updatedEntry.settings, namedStaticRouteEntry.settings);
    });

    test('props are correct', () {
      final entry1 = NamedStaticRouteEntry(name: 'name1', settings: staticRouteEntry);
      final entry2 = NamedStaticRouteEntry(name: 'name1', settings: staticRouteEntry);
      final entry3 = NamedStaticRouteEntry(name: 'name2', settings: staticRouteEntry.copyWith(destinationLAN: 'd2'));
      expect(entry1, entry2);
      expect(entry1.props, entry2.props);
      expect(entry1 == entry3, false);
      expect(entry1.props == entry3.props, false);
    });
  });

  group('GetRoutingSettings', () {
    const staticRouteEntry = StaticRouteEntry(
      destinationLAN: '192.168.2.0',
      gateway: '192.168.1.1',
      interface: 'LAN',
      networkPrefixLength: 24,
    );

    const namedStaticRouteEntry = NamedStaticRouteEntry(
      name: 'Route1',
      settings: staticRouteEntry,
    );

    const getRoutingSettings = GetRoutingSettings(
      isNATEnabled: true,
      isDynamicRoutingEnabled: true,
      maxStaticRouteEntries: 10,
      entries: [namedStaticRouteEntry],
    );

    final Map<String, dynamic> getRoutingSettingsMap = {
      'isNATEnabled': true,
      'isDynamicRoutingEnabled': true,
      'maxStaticRouteEntries': 10,
      'entries': [namedStaticRouteEntry.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(getRoutingSettings.toMap(), getRoutingSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(GetRoutingSettings.fromMap(getRoutingSettingsMap), getRoutingSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(getRoutingSettings.toJson(), json.encode(getRoutingSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GetRoutingSettings.fromJson(json.encode(getRoutingSettingsMap)), getRoutingSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = getRoutingSettings.copyWith(
        isNATEnabled: false,
        maxStaticRouteEntries: 5,
      );
      expect(updatedSettings.isNATEnabled, false);
      expect(updatedSettings.maxStaticRouteEntries, 5);
      expect(updatedSettings.entries, getRoutingSettings.entries);
    });

    test('props are correct', () {
      final settings1 = GetRoutingSettings(
        isNATEnabled: true,
        isDynamicRoutingEnabled: true,
        maxStaticRouteEntries: 1,
        entries: [namedStaticRouteEntry],
      );
      final settings2 = GetRoutingSettings(
        isNATEnabled: true,
        isDynamicRoutingEnabled: true,
        maxStaticRouteEntries: 1,
        entries: [namedStaticRouteEntry],
      );
      final settings3 = GetRoutingSettings(
        isNATEnabled: false,
        isDynamicRoutingEnabled: false,
        maxStaticRouteEntries: 2,
        entries: [],
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
