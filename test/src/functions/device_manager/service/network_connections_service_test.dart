import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/functions/device_manager/service/network_connections_service.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockDataCacheManager extends Mock implements PollingCacheManager {}

void main() {
  group('NetworkConnectionsService', () {
    late MockDataCacheManager mockCacheManager;
    late ProviderContainer container;

    setUp(() {
      mockCacheManager = MockDataCacheManager();
      container = ProviderContainer(overrides: [
        cacheManagerProvider.overrideWithValue(mockCacheManager),
      ]);
    });

    test('getNetworkConnectionsFromCache returns connections from GetNetworkConnections', () {
      final ref = container.read(Provider((ref) => ref));
      final service = NetworkConnectionsService(ref);
      final mockData = {'connections': [{'macAddress': 'mac1'}]};
      final mockCache = {
        GetNetworkConnections.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        },
        GetNodesWirelessNetworkConnections.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: {'nodeWirelessConnections': []}).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getNetworkConnectionsFromCache();

      expect(result, isA<List<Layer2Connection>>());
      expect(result.length, 1);
      expect(result.first.macAddress, 'mac1');
    });

    test('getNetworkConnectionsFromCache returns connections from GetNodesWirelessNetworkConnections', () {
      final ref = container.read(Provider((ref) => ref));
      final service = NetworkConnectionsService(ref);
      final mockData = {'nodeWirelessConnections': [{'connections': [{'macAddress': 'mac2'}]}]};
      final mockCache = {
        GetNodesWirelessNetworkConnections.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        },
        GetNetworkConnections.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: {'connections':[]}).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getNetworkConnectionsFromCache();

      expect(result, isA<List<Layer2Connection>>());
      expect(result.length, 1);
      expect(result.first.macAddress, 'mac2');
    });
  });
}