import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/service/network_connections_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/layer2_connection.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockJnap extends Mock implements Jnap {}

class FakeJnapAction extends Fake implements JNAPAction {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
  });

  group('NetworkConnectionsService', () {
    late ProviderContainer container;
    late MockJnap mockJnap;
    late NetworkConnectionsService service;

    setUp(() {
      mockJnap = MockJnap();
      container = ProviderContainer(
        overrides: [
          jnapProvider.overrideWithValue(mockJnap),
        ],
      );
      final ref = container.read(Provider((ref) => ref));
      service = NetworkConnectionsService(ref);
    });

    group('getNetworkConnectionsList', () {
      test('uses GetNodesWirelessNetworkConnections when available', () async {
        when(() => mockJnap.send(
                action: GetNodesWirelessNetworkConnections.instance))
            .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {
                  'nodeWirelessConnections': [
                    {
                      'deviceID': 'node1',
                      'connections': [
                        {
                          'macAddress': 'MAC2',
                          'negotiatedMbps': 150,
                          "timestamp": "2025-09-11T10:13:48.000Z",
                          'wireless': {
                            "bssid": "80:69:1A:13:16:1C",
                            "isGuest": false,
                            "radioID": "RADIO_5GHz",
                            "band": "5GHz",
                            "signalDecibels": -84
                          }
                        }
                      ]
                    }
                  ]
                }));
        when(() => mockJnap.send(action: GetNetworkConnections.instance))
            .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));

        final result = await service.getNetworkConnectionsList();

        expect(result.length, 1);
        expect(result.first.macAddress, 'MAC2');
        verify(() => mockJnap.send(
            action: GetNodesWirelessNetworkConnections.instance)).called(1);
        verify(() => mockJnap.send(action: GetNetworkConnections.instance))
            .called(1);
      });

      test('falls back to GetNetworkConnections', () async {
        when(() => mockJnap.send(
                action: GetNodesWirelessNetworkConnections.instance))
            .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));
        when(() => mockJnap.send(action: GetNetworkConnections.instance))
            .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {
                  'connections': [
                    {
                      'macAddress': 'MAC2',
                      'negotiatedMbps': 150,
                      'wireless': {
                        "bssid": "80:69:1A:13:16:1C",
                        "isGuest": false,
                        "radioID": "RADIO_5GHz",
                        "band": "5GHz",
                        "signalDecibels": -84
                      }
                    }
                  ]
                }));

        final result = await service.getNetworkConnectionsList();

        expect(result.length, 1);
        expect(result.first.macAddress, 'MAC2');
      });
    });

    test('getWirelessConnectionsMap creates map correctly', () {
      final connectionsList = [
        Layer2ConnectionData(
            macAddress: 'MAC1',
            wireless: WirelessConnectionData(
                bssid: '', isGuest: false, signalDecibels: -50, band: '2.4GHz'),
            negotiatedMbps: 100),
        Layer2ConnectionData(
            macAddress: 'MAC2', negotiatedMbps: 150, wireless: null),
      ];

      final result =
          service.getWirelessConnectionsMap(connectionsList: connectionsList);

      expect(result.length, 1);
      expect(result.containsKey('MAC1'), isTrue);
      expect(result.containsKey('MAC2'), isFalse);
      expect(result['MAC1']?.signalDecibels, -50);
    });

    test('updateWirelessConnectionsWithBackhaulInfo updates correctly', () {
      final wirelessConnections = {
        'AA:BB:CC:DD:EE:FF': WirelessConnectionData(
            bssid: '', isGuest: false, signalDecibels: -50, band: '2.4GHz')
      };
      final backhaulInfoList = [
        BackHaulInfoData(
          connectionType: 'Wireless',
          wirelessConnectionInfo: WirelessConnectionInfo(
            stationBSSID: '11:22:33:44:55:66',
            stationRSSI: -60,
            radioID: '5G',
            apBSSID: 'AP_BSSID',
            channel: 1,
            apRSSI: -70,
          ),
          deviceUUID: 'deviceUUID',
          ipAddress: 'ipAddress',
          parentIPAddress: 'parentIPAddress',
          speedMbps: 'speedMbps',
          timestamp: 'timestamp',
        )
      ];

      final result = service.updateWirelessConnectionsWithBackhaulInfo(
        wirelessConnections: wirelessConnections,
        backhaulInfoList: backhaulInfoList,
      );

      expect(result.length, 2);
      expect(result.containsKey('11:22:33:44:55:66'), isTrue);
      expect(result['11:22:33:44:55:66']?.signalDecibels, -60);
      expect(result['11:22:33:44:55:66']?.radioID, 'RADIO_5Gz');
    });
  });
}
