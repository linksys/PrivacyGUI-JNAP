import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/service/radio_info_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockJnap extends Mock implements Jnap {}

class FakeJnapAction extends Fake implements JNAPAction {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
  });

  group('RadioInfoService', () {
    late ProviderContainer container;
    late MockJnap mockJnap;
    late RadioInfoService service;

    setUp(() {
      mockJnap = MockJnap();
      container = ProviderContainer(
        overrides: [
          jnapProvider.overrideWithValue(mockJnap),
        ],
      );
      final ref = container.read(Provider((ref) => ref));
      service = RadioInfoService(ref);
    });

    test('getRadioInfo sends correct action', () async {
      when(() => mockJnap.send(action: GetRadioInfo.instance)).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: {'radios': []}));

      await service.getRadioInfo();

      verify(() => mockJnap.send(action: GetRadioInfo.instance)).called(1);
    });

    test('getGuestRadioSettings sends correct action', () async {
      when(() => mockJnap.send(action: GetGuestRadioSettings.instance))
          .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));

      await service.getGuestRadioSettings();

      verify(() => mockJnap.send(action: GetGuestRadioSettings.instance))
          .called(1);
    });

    test('getRadioInfoMap parses response correctly', () async {
      final mockResponse = {
        'radios': [
          {
            "radioID": "RADIO_2.4GHz",
            "physicalRadioID": "ath0",
            "bssid": "80:69:1A:BB:46:CD",
            "band": "2.4GHz",
            "supportedModes": [
              "802.11bg",
              "802.11bgn",
              "802.11bgnax",
              "802.11mixed"
            ],
            "defaultMixedMode": "802.11mixed",
            "supportedChannelsForChannelWidths": [
              {
                "channelWidth": "Auto",
                "channels": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
              },
              {
                "channelWidth": "Standard",
                "channels": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
              }
            ],
            "supportedSecurityTypes": [
              "Enhanced-Open+None",
              "Enhanced-Open-Only",
              "None",
              "WPA2-Personal",
              "WPA2/WPA3-Mixed-Personal",
              "WPA3-Personal"
            ],
            "maxRADIUSSharedKeyLength": 64,
            "settings": {
              "isEnabled": true,
              "mode": "802.11mixed",
              "ssid": "Linksys03041",
              "broadcastSSID": true,
              "channelWidth": "Auto",
              "channel": 0,
              "security": "WPA2/WPA3-Mixed-Personal",
              "wpaPersonalSettings": {"passphrase": "7sVzt65hf@"}
            }
          }
        ]
      };
      when(() => mockJnap.send(action: GetRadioInfo.instance)).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: mockResponse));

      final result = await service.getRadioInfoMap();

      expect(result, isA<Map<String, RouterRadio>>());
      expect(result.length, 1);
      expect(result['RADIO_2.4GHz']?.band, '2.4GHz');
      expect(result['RADIO_2.4GHz']?.settings.ssid, 'Linksys03041');
    });

    test('getGuestRadioSettingsData parses response correctly', () async {
      final mockResponse = {
        "isGuestNetworkACaptivePortal": false,
        "isGuestNetworkEnabled": true,
        "radios": [
          {
            "radioID": "RADIO_2.4GHz",
            "isEnabled": true,
            "broadcastGuestSSID": true,
            "guestSSID": "Linksys03041-guest",
            "guestWPAPassphrase": "BeMyGuest",
            "canEnableRadio": true
          },
          {
            "radioID": "RADIO_5GHz",
            "isEnabled": true,
            "broadcastGuestSSID": true,
            "guestSSID": "Linksys03041-guest",
            "guestWPAPassphrase": "BeMyGuest",
            "canEnableRadio": true
          }
        ]
      };
      when(() => mockJnap.send(action: GetGuestRadioSettings.instance))
          .thenAnswer(
              (_) async => JNAPSuccess(result: 'OK', output: mockResponse));

      final result = await service.getGuestRadioSettingsData();

      expect(result, isA<GuestRadioSettings>());
      expect(result?.radios.first.guestSSID, 'Linksys03041-guest');
    });

    test('getGuestRadioSettingsData handles empty response', () async {
      when(() => mockJnap.send(action: GetGuestRadioSettings.instance))
          .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));

      final result = await service.getGuestRadioSettingsData();

      expect(result, isNull);
    });
  });
}
