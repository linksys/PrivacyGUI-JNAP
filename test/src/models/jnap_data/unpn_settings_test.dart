import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/unpn_settings.dart';

void main() {
  group('UPnPSettingsData', () {
    const upnpSettings = UPnPSettingsData(
      isUPnPEnabled: true,
      canUsersConfigure: true,
      canUsersDisableWANAccess: true,
    );

    final Map<String, dynamic> upnpSettingsMap = {
      'isUPnPEnabled': true,
      'canUsersConfigure': true,
      'canUsersDisableWANAccess': true,
    };

    test('toMap returns a valid map', () {
      expect(upnpSettings.toMap(), upnpSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(UPnPSettingsData.fromMap(upnpSettingsMap), upnpSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(upnpSettings.toJson(), json.encode(upnpSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(UPnPSettingsData.fromJson(json.encode(upnpSettingsMap)), upnpSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = upnpSettings.copyWith(
        isUPnPEnabled: false,
      );
      expect(updatedSettings.isUPnPEnabled, false);
      expect(updatedSettings.canUsersConfigure, upnpSettings.canUsersConfigure);
    });

    test('props are correct', () {
      final settings1 = UPnPSettingsData(isUPnPEnabled: true, canUsersConfigure: true, canUsersDisableWANAccess: true);
      final settings2 = UPnPSettingsData(isUPnPEnabled: true, canUsersConfigure: true, canUsersDisableWANAccess: true);
      final settings3 = UPnPSettingsData(isUPnPEnabled: false, canUsersConfigure: false, canUsersDisableWANAccess: false);
      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}