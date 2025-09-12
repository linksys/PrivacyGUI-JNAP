import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/service/backhaul_info_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockJnap extends Mock implements Jnap {}

class FakeJnapAction extends Fake implements JNAPAction {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
  });

  group('BackhaulInfoService', () {
    late ProviderContainer container;
    late MockJnap mockJnap;

    setUp(() {
      mockJnap = MockJnap();
      container = ProviderContainer(
        overrides: [
          jnapProvider.overrideWithValue(mockJnap),
        ],
      );
    });

    test('getBackhaulInfo sends correct action', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      when(() => mockJnap.send(action: any(named: 'action'))).thenAnswer(
          (_) async =>
              JNAPSuccess(result: 'OK', output: {'backhaulDevices': []}));

      await service.getBackhaulInfo();

      verify(() => mockJnap.send(action: GetBackhaulInfo.instance)).called(1);
    });

    test('getBackhaulInfoList parses response correctly', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      final mockResponse = {
        "backhaulDevices": [
          {
            "deviceUUID": "0217b8a4-1082-4532-8345-80691abb4694",
            "ipAddress": "10.138.1.166",
            "parentIPAddress": "10.138.1.1",
            "connectionType": "Wireless",
            "wirelessConnectionInfo": {
              "radioID": "5GL",
              "channel": 40,
              "apRSSI": -67,
              "stationRSSI": -18,
              "apBSSID": "80:69:1A:BB:46:CE",
              "stationBSSID": "86:69:1A:BB:46:96",
              "txRate": 2168673,
              "rxRate": 2494972,
              "isMultiLinkOperation": false
            },
            "speedMbps": "176.239",
            "timestamp": "2024-12-25T07:14:06Z"
          }
        ],
      };
      when(() => mockJnap.send(action: any(named: 'action'))).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: mockResponse));

      final result = await service.getBackhaulInfoList();

      expect(result, isA<List<BackHaulInfoData>>());
      expect(result.length, 1);
      expect(result.first.deviceUUID, '0217b8a4-1082-4532-8345-80691abb4694');
      expect(result.first.connectionType, 'Wireless');
    });

    test('getBackhaulInfoList handles empty response', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      when(() => mockJnap.send(action: any(named: 'action'))).thenAnswer(
          (_) async =>
              JNAPSuccess(result: 'OK', output: {'backhaulDevices': []}));

      final result = await service.getBackhaulInfoList();

      expect(result, isEmpty);
    });

    test('getBackhaulInfoList handles null response', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = BackhaulInfoService(ref);
      when(() => mockJnap.send(action: any(named: 'action')))
          .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));

      final result = await service.getBackhaulInfoList();

      expect(result, isEmpty);
    });
  });
}
