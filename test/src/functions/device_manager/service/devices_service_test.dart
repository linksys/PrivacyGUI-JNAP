import 'package:jnap/jnap.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/service/devices_service.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockDataCacheManager extends Mock implements PollingCacheManager {}
class MockJnap extends Mock implements Jnap {}

void main() {
  group('DevicesService', () {
    late MockDataCacheManager mockCacheManager;
    late MockJnap mockJnap;
    late ProviderContainer container;

    setUp(() {
      mockCacheManager = MockDataCacheManager();
      mockJnap = MockJnap();
      container = ProviderContainer(overrides: [
        cacheManagerProvider.overrideWithValue(mockCacheManager),
        jnapProvider.overrideWithValue(mockJnap),
      ]);
    });

    test('getDevicesFromCache returns correct data', () {
      final ref = container.read(Provider((ref) => ref));
      final service = DevicesService(ref);
      final mockData = {'devices': [{'deviceID': '1'}]};
      final mockCache = {
        GetDevices.instance.command: {
          'data': JNAPSuccess(result: 'OK', output: mockData).toJson(),
        }
      };

      when(() => mockCacheManager.fetchCacheData()).thenReturn(mockCache);

      final result = service.getDevicesFromCache();

      expect(result, equals(mockData));
    });

    test('getDeviceListAndLocations returns sorted and processed device list', () {
      final ref = container.read(Provider((ref) => ref));
      final service = DevicesService(ref);
      final mockDevicesData = {
        'devices': [
          {
            'deviceID': '2',
            'properties': [
              {'name': 'nodeType', 'value': 'Slave'}
            ]
          },
          {
            'deviceID': '3',
            'properties': []
          },
          {
            'deviceID': '1',
            'properties': [
              {'name': 'nodeType', 'value': 'Master'},
              {'name': 'isAuthority', 'value': 'true'}
            ]
          },
        ]
      };
      final wirelessConnections = <String, WirelessConnection>{};

      final result = service.getDeviceListAndLocations(mockDevicesData, wirelessConnections);

      expect(result, isA<List<LinksysDevice>>());
      expect(result.length, 3);
      expect(result[0].deviceID, '1'); // Master/Authority first
      expect(result[1].deviceID, '2'); // Then other nodes
      expect(result[2].deviceID, '3'); // Then external devices
    });

    test('updateDeviceIpWithBackhaulInfo updates device IP', () {
      final ref = container.read(Provider((ref) => ref));
      final service = DevicesService(ref);
      final device = LinksysDevice.fromMap({
        'deviceID': 'uuid1',
        'connections': [{'ipAddress': '192.168.1.100'}]
      });
      final backhaulInfo = BackHaulInfoData.fromMap({
        'deviceUUID': 'uuid1',
        'ipAddress': '192.168.1.200'
      });

      final result = service.updateDeviceIpWithBackhaulInfo(
        deviceList: [device],
        backhaulInfoList: [backhaulInfo],
      );

      expect(result.first.connections.first.ipAddress, '192.168.1.200');
    });
  });
}