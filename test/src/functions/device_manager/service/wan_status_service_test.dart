import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/service/wan_status_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockJnap extends Mock implements Jnap {}

class FakeJnapAction extends Fake implements JNAPAction {}

void main() {
  final wanStatusMap = {
    "macAddress": "80:69:1A:BB:46:CC",
    "detectedWANType": "DHCP",
    "wanStatus": "Connected",
    "wanIPv6Status": "Connecting",
    "wanConnection": {
      "wanType": "DHCP",
      "ipAddress": "192.168.1.87",
      "networkPrefixLength": 24,
      "gateway": "192.168.1.1",
      "mtu": 0,
      "dhcpLeaseMinutes": 120,
      "dnsServer1": "192.168.1.1"
    },
    "supportedWANTypes": ["DHCP", "Static", "PPPoE", "PPTP", "L2TP", "Bridge"],
    "supportedIPv6WANTypes": ["Automatic", "PPPoE", "Pass-through"],
    "supportedWANCombinations": [
      {"wanType": "DHCP", "wanIPv6Type": "Automatic"},
      {"wanType": "Static", "wanIPv6Type": "Automatic"},
      {"wanType": "PPPoE", "wanIPv6Type": "Automatic"},
      {"wanType": "L2TP", "wanIPv6Type": "Automatic"},
      {"wanType": "PPTP", "wanIPv6Type": "Automatic"},
      {"wanType": "Bridge", "wanIPv6Type": "Automatic"},
      {"wanType": "DHCP", "wanIPv6Type": "Pass-through"},
      {"wanType": "PPPoE", "wanIPv6Type": "PPPoE"}
    ]
  };

  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
  });

  group('WANStatusService', () {
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

    test('getWANStatus sends correct action', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = WANStatusService(ref);
      when(() => mockJnap.send(action: GetWANStatus.instance)).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: wanStatusMap));

      await service.getWANStatus();

      verify(() => mockJnap.send(action: GetWANStatus.instance)).called(1);
    });

    test('getWANStatusData parses response correctly', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = WANStatusService(ref);

      when(() => mockJnap.send(action: any(named: 'action'))).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: wanStatusMap));

      final result = await service.getWANStatusData();

      expect(result, isA<RouterWANStatus>());
      expect(result.wanStatus, 'Connected');
      expect(result.wanConnection?.ipAddress, '192.168.1.87');
    });
  });
}
