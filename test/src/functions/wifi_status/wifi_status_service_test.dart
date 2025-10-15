import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/wifi_status/wifi_status_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJnap extends Mock implements Jnap {}

class FakeJnapAction extends Fake implements JNAPAction {}

class FakeJnapConfigOverrides extends Fake implements JNAPConfigOverrides {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
    registerFallbackValue(FakeJnapConfigOverrides());
  });

  group('WifiStatusService', () {
    late MockJnap mockJnap;
    late WifiStatusService service;

    setUp(() {
      mockJnap = MockJnap();
      service = WifiStatusService(mockJnap);
    });

    test('getPortConnections fetches and normalizes ethernet ports', () async {
      when(() => mockJnap.send(
            action: GetEthernetPortConnections.instance,
            overrides: any(named: 'overrides'),
          )).thenAnswer(
        (_) async => JNAPSuccess(result: 'OK', output: {
          'wanPortConnection': 'WANPort',
          'lanPortConnections': [
            'LAN1',
            'None',
            42,
            'lan2',
          ],
        }),
      );

      final result = await service.getPortConnections();

      expect(result.wanPortConnection, 'WANPort');
      expect(result.lanPortConnections, ['LAN1', 'lan2']);

      final capturedOverrides = verify(
        () => mockJnap.send(
          action: GetEthernetPortConnections.instance,
          overrides: captureAny(named: 'overrides'),
        ),
      ).captured.single as JNAPConfigOverrides;

      expect(capturedOverrides.cached, isFalse);
      expect(capturedOverrides.forceRemote, isTrue);
    });
  });
}
