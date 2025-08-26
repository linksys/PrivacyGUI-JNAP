import 'package:test/test.dart';
import 'package:jnap/src/utilties/nodes/wifi.dart';

void main() {
  group('Wifi Signal Level', () {
    group('getWifiSignalLevel', () {
      // SNR tests (positive values)
      test('should return "excellent" for SNR >= 40', () {
        expect(getWifiSignalLevel(40), NodeSignalLevel.excellent);
        expect(getWifiSignalLevel(50), NodeSignalLevel.excellent);
      });

      test('should return "good" for SNR between 25 and 39', () {
        expect(getWifiSignalLevel(25), NodeSignalLevel.good);
        expect(getWifiSignalLevel(39), NodeSignalLevel.good);
      });

      test('should return "fair" for SNR between 10 and 24', () {
        expect(getWifiSignalLevel(10), NodeSignalLevel.fair);
        expect(getWifiSignalLevel(24), NodeSignalLevel.fair);
      });

      test('should return "poor" for SNR < 10', () {
        expect(getWifiSignalLevel(9), NodeSignalLevel.poor);
        expect(getWifiSignalLevel(0), NodeSignalLevel.poor);
      });

      // RSSI tests (negative values)
      test('should return "excellent" for RSSI >= -65', () {
        expect(getWifiSignalLevel(-65), NodeSignalLevel.excellent);
        expect(getWifiSignalLevel(-50), NodeSignalLevel.excellent);
      });

      test('should return "good" for RSSI between -71 and -66', () {
        expect(getWifiSignalLevel(-71), NodeSignalLevel.good);
        expect(getWifiSignalLevel(-66), NodeSignalLevel.good);
      });

      test('should return "fair" for RSSI between -78 and -72', () {
        expect(getWifiSignalLevel(-78), NodeSignalLevel.fair);
        expect(getWifiSignalLevel(-72), NodeSignalLevel.fair);
      });

      test('should return "poor" for RSSI < -78', () {
        expect(getWifiSignalLevel(-79), NodeSignalLevel.poor);
        expect(getWifiSignalLevel(-100), NodeSignalLevel.poor);
      });

      // Wired test
      test('should return "wired" for null signal strength', () {
        expect(getWifiSignalLevel(null), NodeSignalLevel.wired);
      });
    });
  });
}