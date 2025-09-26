import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/dmz_settings.dart';

void main() {
  group('DMZSourceRestriction', () {
    const dmzSourceRestriction = DMZSourceRestriction(
      firstIPAddress: '192.168.1.100',
      lastIPAddress: '192.168.1.200',
    );

    final Map<String, dynamic> dmzSourceRestrictionMap = {
      'firstIPAddress': '192.168.1.100',
      'lastIPAddress': '192.168.1.200',
    };

    test('toMap returns a valid map', () {
      expect(dmzSourceRestriction.toMap(), dmzSourceRestrictionMap);
    });

    test('fromMap creates a valid object', () {
      expect(DMZSourceRestriction.fromMap(dmzSourceRestrictionMap), dmzSourceRestriction);
    });

    test('toJson returns a valid JSON string', () {
      expect(dmzSourceRestriction.toJson(), json.encode(dmzSourceRestrictionMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DMZSourceRestriction.fromJson(json.encode(dmzSourceRestrictionMap)), dmzSourceRestriction);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRestriction = dmzSourceRestriction.copyWith(
        firstIPAddress: '192.168.1.1',
      );
      expect(updatedRestriction.firstIPAddress, '192.168.1.1');
      expect(updatedRestriction.lastIPAddress, dmzSourceRestriction.lastIPAddress);
    });

    test('props are correct', () {
      final restriction1 = DMZSourceRestriction(firstIPAddress: 'ip1', lastIPAddress: 'ip2');
      final restriction2 = DMZSourceRestriction(firstIPAddress: 'ip1', lastIPAddress: 'ip2');
      final restriction3 = DMZSourceRestriction(firstIPAddress: 'ip3', lastIPAddress: 'ip4');
      expect(restriction1, restriction2);
      expect(restriction1.props, restriction2.props);
      expect(restriction1 == restriction3, false);
      expect(restriction1.props == restriction3.props, false);
    });
  });

  group('DMZSettingsData', () {
    const dmzSourceRestriction = DMZSourceRestriction(
      firstIPAddress: '192.168.1.100',
      lastIPAddress: '192.168.1.200',
    );

    const dmzSettings = DMZSettingsData(
      isDMZEnabled: true,
      sourceRestriction: dmzSourceRestriction,
      destinationIPAddress: '192.168.1.50',
      destinationMACAddress: 'AA:BB:CC:DD:EE:FF',
    );

    final Map<String, dynamic> dmzSettingsMap = {
      'isDMZEnabled': true,
      'sourceRestriction': dmzSourceRestriction.toMap(),
      'destinationIPAddress': '192.168.1.50',
      'destinationMACAddress': 'AA:BB:CC:DD:EE:FF',
    };

    test('toMap returns a valid map', () {
      expect(dmzSettings.toMap(), dmzSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(DMZSettingsData.fromMap(dmzSettingsMap), dmzSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(dmzSettings.toJson(), json.encode(dmzSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DMZSettingsData.fromJson(json.encode(dmzSettingsMap)), dmzSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = dmzSettings.copyWith(
        isDMZEnabled: false,
        destinationIPAddress: () => '192.168.1.51',
      );
      expect(updatedSettings.isDMZEnabled, false);
      expect(updatedSettings.destinationIPAddress, '192.168.1.51');
      expect(updatedSettings.sourceRestriction, dmzSettings.sourceRestriction);
    });

    test('props are correct', () {
      final settings1 = DMZSettingsData(
        isDMZEnabled: true,
        sourceRestriction: dmzSourceRestriction,
        destinationIPAddress: 'ip1',
        destinationMACAddress: 'mac1',
      );
      final settings2 = DMZSettingsData(
        isDMZEnabled: true,
        sourceRestriction: dmzSourceRestriction,
        destinationIPAddress: 'ip1',
        destinationMACAddress: 'mac1',
      );
      final settings3 = DMZSettingsData(
        isDMZEnabled: false,
        sourceRestriction: null,
        destinationIPAddress: 'ip2',
        destinationMACAddress: 'mac2',
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}