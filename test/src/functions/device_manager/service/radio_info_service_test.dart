import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/functions/device_manager/service/radio_info_service.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockDataCacheManager extends Mock implements PollingCacheManager {}

void main() {
  group('RadioInfoService', () {
    late MockDataCacheManager mockCacheManager;
    late ProviderContainer container;

    setUp(() {
      mockCacheManager = MockDataCacheManager();
      container = ProviderContainer(overrides: [
        cacheManagerProvider.overrideWithValue(mockCacheManager),
      ]);
    });

    test('getRadioInfoMapFromCache returns map of RouterRadio', () {
      final ref = container.read(Provider((ref) => ref));
      final service = RadioInfoService(ref);
      final mockData = {'radios': [{'radioID': 'radio1'}]};
      final mockCache = {
        GetRadioInfo.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        },
        GetGuestRadioSettings.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: {'radios': []}).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getRadioInfoMapFromCache();

      expect(result, isA<Map<String, RouterRadio>>());
      expect(result.keys.first, 'radio1');
    });

    test('getGuestRadioSettingsFromCache returns GuestRadioSettings', () {
      final ref = container.read(Provider((ref) => ref));
      final service = RadioInfoService(ref);
      final mockData = {'radios': [{'guestSSID': 'guest'}]};
      final mockCache = {
        GetGuestRadioSettings.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        },
        GetRadioInfo.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: {'radios': []}).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getGuestRadioSettingsFromCache();

      expect(result, isA<GuestRadioSettings>());
      expect(result?.radios.first.guestSSID, 'guest');
    });
  });
}