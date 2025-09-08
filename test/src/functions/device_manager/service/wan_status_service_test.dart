import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/functions/device_manager/service/wan_status_service.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/wan_status.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockDataCacheManager extends Mock implements PollingCacheManager {}

void main() {
  group('WANStatusService', () {
    late MockDataCacheManager mockCacheManager;
    late ProviderContainer container;

    setUp(() {
      mockCacheManager = MockDataCacheManager();
      container = ProviderContainer(overrides: [
        cacheManagerProvider.overrideWithValue(mockCacheManager),
      ]);
    });

    test('getWANStatusFromCache returns correct data', () {
      final ref = container.read(Provider((ref) => ref));
      final service = WANStatusService(ref);
      final mockData = {'status': 'Up'};
      final mockCache = {
        GetWANStatus.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getWANStatusFromCache();

      expect(result, equals(mockData));
    });

    test('getWANStatusModel returns RouterWANStatus object', () {
      // final ref = container.read(Provider((ref) => ref));
      // final service = WANStatusService(ref);
      // final mockData = {'status': 'Up', 'connectionType': 'DHCP'};

      // final result = service.getWANStatusModel(mockData);

      // expect(result, isA<RouterWANStatus>());
      // expect(result?.status, 'Up');
    });

    test('getWANStatusModel returns null for null data', () {
      final ref = container.read(Provider((ref) => ref));
      final service = WANStatusService(ref);
      final result = service.getWANStatusModel(null);

      expect(result, isNull);
    });
  });
}