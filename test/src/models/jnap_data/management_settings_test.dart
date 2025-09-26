import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/management_settings.dart';

void main() {
  group('ManagementSettingsData', () {
    const managementSettings = ManagementSettingsData(
      canManageUsingHTTP: true,
      canManageUsingHTTPS: true,
      isManageWirelesslySupported: true,
      canManageWirelessly: true,
      canManageRemotely: true,
    );

    final Map<String, dynamic> managementSettingsMap = {
      'canManageUsingHTTP': true,
      'canManageUsingHTTPS': true,
      'isManageWirelesslySupported': true,
      'canManageWirelessly': true,
      'canManageRemotely': true,
    };

    test('toMap returns a valid map', () {
      expect(managementSettings.toMap(), managementSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(ManagementSettingsData.fromMap(managementSettingsMap), managementSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(managementSettings.toJson(), json.encode(managementSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(ManagementSettingsData.fromJson(json.encode(managementSettingsMap)), managementSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = managementSettings.copyWith(
        canManageUsingHTTP: false,
        canManageRemotely: false,
      );
      expect(updatedSettings.canManageUsingHTTP, false);
      expect(updatedSettings.canManageRemotely, false);
      expect(updatedSettings.canManageUsingHTTPS, managementSettings.canManageUsingHTTPS);
    });

    test('toSetSettingsMap returns a valid map', () {
      expect(managementSettings.toSetSettingsMap(), {
        'canManageUsingHTTP': true,
        'canManageUsingHTTPS': true,
        'canManageWirelessly': true,
        'canManageRemotely': true,
      });
    });

    test('props are correct', () {
      final settings1 = ManagementSettingsData(
        canManageUsingHTTP: true,
        canManageUsingHTTPS: true,
        isManageWirelesslySupported: true,
        canManageRemotely: true,
      );
      final settings2 = ManagementSettingsData(
        canManageUsingHTTP: true,
        canManageUsingHTTPS: true,
        isManageWirelesslySupported: true,
        canManageRemotely: true,
      );
      final settings3 = ManagementSettingsData(
        canManageUsingHTTP: false,
        canManageUsingHTTPS: false,
        isManageWirelesslySupported: false,
        canManageRemotely: false,
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}