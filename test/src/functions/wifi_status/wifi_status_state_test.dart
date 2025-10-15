import 'package:jnap/src/functions/wifi_status/wifi_status_state.dart';
import 'package:test/test.dart';

void main() {
  group('WifiStatusState', () {
    const state = WifiStatusState(
      band: '2.4GHz',
      isGuest: false,
      isEnabled: true,
      deviceCount: '3',
      ssid: 'Home24',
      password: 'pass24',
      radios: [],
      canBeDisabled: true,
      qrData: 'WIFI:S:Home24;P:pass24;T:WPA;H:false;;',
    );

    test('copyWith overrides provided fields', () {
      final updated = state.copyWith(
        band: '5GHz',
        isGuest: true,
        isEnabled: false,
        deviceCount: '5',
        ssid: 'Home5',
        password: 'pass5',
        radios: const ['RADIO_5'],
        canBeDisabled: false,
        qrData: 'qr',
      );

      expect(updated.band, '5GHz');
      expect(updated.isGuest, isTrue);
      expect(updated.isEnabled, isFalse);
      expect(updated.deviceCount, '5');
      expect(updated.ssid, 'Home5');
      expect(updated.password, 'pass5');
      expect(updated.radios, ['RADIO_5']);
      expect(updated.canBeDisabled, isFalse);
      expect(updated.qrData, 'qr');
    });

    test('toMap/fromMap round trip maintains values', () {
      final fullState = state.copyWith(radios: const ['RADIO_2_4']);
      final map = fullState.toMap();
      final recreated = WifiStatusState.fromMap(map);

      expect(recreated, equals(fullState));
    });

    test('empty factory returns default values', () {
      final empty = WifiStatusState.empty();

      expect(empty.band, isEmpty);
      expect(empty.isGuest, isFalse);
      expect(empty.isEnabled, isFalse);
      expect(empty.deviceCount, isEmpty);
      expect(empty.radios, isEmpty);
      expect(empty.canBeDisabled, isFalse);
      expect(empty.qrData, isEmpty);
    });
  });
}
