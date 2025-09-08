import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/functions/device_manager/service/backhaul_info_service.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockDataCacheManager extends Mock implements PollingCacheManager {}

void main() {
  group('BackhaulInfoService', () {
    late MockDataCacheManager mockCacheManager;
    late ProviderContainer container;

    setUp(() {
      mockCacheManager = MockDataCacheManager();
      container = ProviderContainer(overrides: [
        cacheManagerProvider.overrideWithValue(mockCacheManager),
      ]);
    });

    test('getBackhaulInfoFromCache returns correct data', () {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      final mockData = {
        'backhaulDevices': [
          {'deviceUUID': '1', 'ipAddress': '192.168.1.1'}
        ]
      };
      final mockCache = {
        GetBackhaulInfo.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getBackhaulInfoFromCache();

      expect(result, equals(mockData));
    });

    test('getBackhaulInfoList returns list of BackHaulInfoData', () {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      final mockData = {
        'backhaulDevices': [
          {
            'deviceUUID': 'uuid1',
            'parentIPAddress': '192.168.1.1',
            'ipAddress': '192.168.1.10',
            'connectionType': 'Ethernet',
            'speedMbps': 1000,
          }
        ]
      };
      final mockCache = {
        GetBackhaulInfo.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getBackhaulInfoList();

      expect(result, isA<List<BackHaulInfoData>>());
      expect(result.length, 1);
      expect(result.first.deviceUUID, 'uuid1');
    });

    test('getBackhaulInfoList returns empty list when cache is empty', () {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      when(() => mockCacheManager.fetchCacheData()).thenReturn({});

      final result = service.getBackhaulInfoList();

      expect(result, isEmpty);
    });
  });
}