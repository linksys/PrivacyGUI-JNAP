import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';

void main() {
  group('UnicodeRange', () {
    const unicodeRange = UnicodeRange(
      lowCodepoint: 0x0020,
      highCodepoint: 0x007E,
    );

    final Map<String, dynamic> unicodeRangeMap = {
      'lowCodepoint': 0x0020,
      'highCodepoint': 0x007E,
    };

    test('toMap returns a valid map', () {
      expect(unicodeRange.toMap(), unicodeRangeMap);
    });

    test('fromMap creates a valid object', () {
      expect(UnicodeRange.fromMap(unicodeRangeMap), unicodeRange);
    });

    test('toJson returns a valid JSON string', () {
      expect(unicodeRange.toJson(), json.encode(unicodeRangeMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(UnicodeRange.fromJson(json.encode(unicodeRangeMap)), unicodeRange);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRange = unicodeRange.copyWith(
        lowCodepoint: 0x0021,
      );
      expect(updatedRange.lowCodepoint, 0x0021);
      expect(updatedRange.highCodepoint, unicodeRange.highCodepoint);
    });

    test('props are correct', () {
      final range1 = UnicodeRange(lowCodepoint: 1, highCodepoint: 2);
      final range2 = UnicodeRange(lowCodepoint: 1, highCodepoint: 2);
      final range3 = UnicodeRange(lowCodepoint: 3, highCodepoint: 4);
      expect(range1, range2);
      expect(range1.props, range2.props);
      expect(range1 == range3, false);
      expect(range1.props == range3.props, false);
    });
  });

  group('GuestPasswordRestriction', () {
    const unicodeRange = UnicodeRange(
      lowCodepoint: 0x0020,
      highCodepoint: 0x007E,
    );

    const guestPasswordRestriction = GuestPasswordRestriction(
      minLength: 8,
      maxLength: 63,
      allowedCharacters: [unicodeRange],
    );

    final Map<String, dynamic> guestPasswordRestrictionMap = {
      'minLength': 8,
      'maxLength': 63,
      'allowedCharacters': [unicodeRange.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(guestPasswordRestriction.toMap(), guestPasswordRestrictionMap);
    });

    test('fromMap creates a valid object', () {
      expect(GuestPasswordRestriction.fromMap(guestPasswordRestrictionMap), guestPasswordRestriction);
    });

    test('toJson returns a valid JSON string', () {
      expect(guestPasswordRestriction.toJson(), json.encode(guestPasswordRestrictionMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GuestPasswordRestriction.fromJson(json.encode(guestPasswordRestrictionMap)), guestPasswordRestriction);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRestriction = guestPasswordRestriction.copyWith(
        minLength: 10,
      );
      expect(updatedRestriction.minLength, 10);
      expect(updatedRestriction.maxLength, guestPasswordRestriction.maxLength);
    });

    test('props are correct', () {
      final restriction1 = GuestPasswordRestriction(minLength: 1, maxLength: 2, allowedCharacters: [unicodeRange]);
      final restriction2 = GuestPasswordRestriction(minLength: 1, maxLength: 2, allowedCharacters: [unicodeRange]);
      final restriction3 = GuestPasswordRestriction(minLength: 3, maxLength: 4, allowedCharacters: []);
      expect(restriction1, restriction2);
      expect(restriction1.props, restriction2.props);
      expect(restriction1 == restriction3, false);
      expect(restriction1.props == restriction3.props, false);
    });
  });

  group('GuestRadioInfo', () {
    const guestRadioInfo = GuestRadioInfo(
      radioID: 'radio1',
      isEnabled: true,
      broadcastGuestSSID: true,
      guestSSID: 'GuestWiFi',
      guestPassword: 'guestpass',
      guestWPAPassphrase: 'wpa_pass',
      canEnableRadio: true,
    );

    final Map<String, dynamic> guestRadioInfoMap = {
      'radioID': 'radio1',
      'isEnabled': true,
      'broadcastGuestSSID': true,
      'guestSSID': 'GuestWiFi',
      'guestPassword': 'guestpass',
      'guestWPAPassphrase': 'wpa_pass',
      'canEnableRadio': true,
    };

    test('toMap returns a valid map', () {
      expect(guestRadioInfo.toMap(), guestRadioInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(GuestRadioInfo.fromMap(guestRadioInfoMap), guestRadioInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(guestRadioInfo.toJson(), json.encode(guestRadioInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GuestRadioInfo.fromJson(json.encode(guestRadioInfoMap)), guestRadioInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = guestRadioInfo.copyWith(
        isEnabled: false,
        guestSSID: 'NewGuestWiFi',
      );
      expect(updatedInfo.isEnabled, false);
      expect(updatedInfo.guestSSID, 'NewGuestWiFi');
      expect(updatedInfo.radioID, guestRadioInfo.radioID);
    });

    test('props are correct', () {
      final info1 = GuestRadioInfo(radioID: 'r1', isEnabled: true, broadcastGuestSSID: true, guestSSID: 's1');
      final info2 = GuestRadioInfo(radioID: 'r1', isEnabled: true, broadcastGuestSSID: true, guestSSID: 's1');
      final info3 = GuestRadioInfo(radioID: 'r2', isEnabled: false, broadcastGuestSSID: false, guestSSID: 's2');
      expect(info1, info2);
      expect(info1.props, info2.props);
      expect(info1 == info3, false);
      expect(info1.props == info3.props, false);
    });
  });

  group('GuestRadioSettings', () {
    const guestRadioInfo = GuestRadioInfo(
      radioID: 'radio1',
      isEnabled: true,
      broadcastGuestSSID: true,
      guestSSID: 'GuestWiFi',
    );
    const unicodeRange = UnicodeRange(
      lowCodepoint: 0x0020,
      highCodepoint: 0x007E,
    );
    const guestPasswordRestriction = GuestPasswordRestriction(
      minLength: 8,
      maxLength: 63,
      allowedCharacters: [unicodeRange],
    );

    const guestRadioSettings = GuestRadioSettings(
      isGuestNetworkACaptivePortal: true,
      isGuestNetworkEnabled: true,
      radios: [guestRadioInfo],
      maxSimultaneousGuests: 10,
      guestPasswordRestrictions: guestPasswordRestriction,
      maxSimultaneousGuestsLimit: 20,
    );

    final Map<String, dynamic> guestRadioSettingsMap = {
      'isGuestNetworkACaptivePortal': true,
      'isGuestNetworkEnabled': true,
      'radios': [guestRadioInfo.toMap()],
      'maxSimultaneousGuests': 10,
      'guestPasswordRestrictions': guestPasswordRestriction.toMap(),
      'maxSimultaneousGuestsLimit': 20,
    };

    test('toMap returns a valid map', () {
      expect(guestRadioSettings.toMap(), guestRadioSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(GuestRadioSettings.fromMap(guestRadioSettingsMap), guestRadioSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(guestRadioSettings.toJson(), json.encode(guestRadioSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GuestRadioSettings.fromJson(json.encode(guestRadioSettingsMap)), guestRadioSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = guestRadioSettings.copyWith(
        isGuestNetworkEnabled: false,
        maxSimultaneousGuests: 15,
      );
      expect(updatedSettings.isGuestNetworkEnabled, false);
      expect(updatedSettings.maxSimultaneousGuests, 15);
      expect(updatedSettings.radios, guestRadioSettings.radios);
    });

    test('props are correct', () {
      final settings1 = GuestRadioSettings(
        isGuestNetworkACaptivePortal: true,
        isGuestNetworkEnabled: true,
        radios: [guestRadioInfo],
      );
      final settings2 = GuestRadioSettings(
        isGuestNetworkACaptivePortal: true,
        isGuestNetworkEnabled: true,
        radios: [guestRadioInfo],
      );
      final settings3 = GuestRadioSettings(
        isGuestNetworkACaptivePortal: false,
        isGuestNetworkEnabled: false,
        radios: [],
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });

  group('SetGuestRadioSettings', () {
    const guestRadioInfo = GuestRadioInfo(
      radioID: 'radio1',
      isEnabled: true,
      broadcastGuestSSID: true,
      guestSSID: 'GuestWiFi',
    );

    const setGuestRadioSettings = SetGuestRadioSettings(
      isGuestNetworkEnabled: true,
      radios: [guestRadioInfo],
      maxSimultaneousGuests: 10,
    );

    final Map<String, dynamic> setGuestRadioSettingsMap = {
      'isGuestNetworkEnabled': true,
      'radios': [guestRadioInfo.toMap()],
      'maxSimultaneousGuests': 10,
    };

    test('toMap returns a valid map', () {
      expect(setGuestRadioSettings.toMap(), setGuestRadioSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SetGuestRadioSettings.fromMap(setGuestRadioSettingsMap), setGuestRadioSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(setGuestRadioSettings.toJson(), json.encode(setGuestRadioSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SetGuestRadioSettings.fromJson(json.encode(setGuestRadioSettingsMap)), setGuestRadioSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = setGuestRadioSettings.copyWith(
        isGuestNetworkEnabled: false,
        maxSimultaneousGuests: 15,
      );
      expect(updatedSettings.isGuestNetworkEnabled, false);
      expect(updatedSettings.maxSimultaneousGuests, 15);
      expect(updatedSettings.radios, setGuestRadioSettings.radios);
    });

    test('fromGuestRadioSettings creates a valid object', () {
      const guestRadioSettings = GuestRadioSettings(
        isGuestNetworkACaptivePortal: true,
        isGuestNetworkEnabled: true,
        radios: [guestRadioInfo],
        maxSimultaneousGuests: 10,
      );
      final convertedSettings = SetGuestRadioSettings.fromGuestRadioSettings(guestRadioSettings);
      expect(convertedSettings.isGuestNetworkEnabled, guestRadioSettings.isGuestNetworkEnabled);
      expect(convertedSettings.radios, guestRadioSettings.radios);
      expect(convertedSettings.maxSimultaneousGuests, guestRadioSettings.maxSimultaneousGuests);
    });

    test('props are correct', () {
      final settings1 = SetGuestRadioSettings(
        isGuestNetworkEnabled: true,
        radios: [guestRadioInfo],
      );
      final settings2 = SetGuestRadioSettings(
        isGuestNetworkEnabled: true,
        radios: [guestRadioInfo],
      );
      final settings3 = SetGuestRadioSettings(
        isGuestNetworkEnabled: false,
        radios: [],
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
