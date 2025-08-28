import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/set_routing_settings.dart';
import 'package:jnap/src/models/jnap_data/get_routing_settings.dart';

void main() {
  group('SetRoutingSettings', () {
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

    const setRoutingSettings = SetRoutingSettings(
      isNATEnabled: true,
      isDynamicRoutingEnabled: true,
      entries: [namedStaticRouteEntry],
    );

    final Map<String, dynamic> setRoutingSettingsMap = {
      'isNATEnabled': true,
      'isDynamicRoutingEnabled': true,
      'entries': [namedStaticRouteEntry.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(setRoutingSettings.toMap(), setRoutingSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SetRoutingSettings.fromMap(setRoutingSettingsMap), setRoutingSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(setRoutingSettings.toJson(), json.encode(setRoutingSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SetRoutingSettings.fromJson(json.encode(setRoutingSettingsMap)), setRoutingSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = setRoutingSettings.copyWith(
        isNATEnabled: false,
        entries: [],
      );
      expect(updatedSettings.isNATEnabled, false);
      expect(updatedSettings.entries, []);
      expect(updatedSettings.isDynamicRoutingEnabled, setRoutingSettings.isDynamicRoutingEnabled);
    });

    test('props are correct', () {
      final settings1 = SetRoutingSettings(
        isNATEnabled: true,
        isDynamicRoutingEnabled: true,
        entries: [namedStaticRouteEntry],
      );
      final settings2 = SetRoutingSettings(
        isNATEnabled: true,
        isDynamicRoutingEnabled: true,
        entries: [namedStaticRouteEntry],
      );
      final settings3 = SetRoutingSettings(
        isNATEnabled: false,
        isDynamicRoutingEnabled: false,
        entries: [],
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
