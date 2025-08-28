import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';

void main() {
  group('WirelessConnection', () {
    const wirelessConnection = WirelessConnection(
      bssid: '00:11:22:33:44:55',
      isGuest: false,
      radioID: 'radio1',
      band: '2.4GHz',
      signalDecibels: -50,
      txRate: 100,
      rxRate: 200,
      isMLOCapable: true,
    );

    final Map<String, dynamic> wirelessConnectionMap = {
      'bssid': '00:11:22:33:44:55',
      'isGuest': false,
      'radioID': 'radio1',
      'band': '2.4GHz',
      'signalDecibels': -50,
      'txRate': 100,
      'rxRate': 200,
      'isMLOCapable': true,
    };

    test('toMap returns a valid map', () {
      expect(wirelessConnection.toMap(), wirelessConnectionMap);
    });

    test('fromMap creates a valid object', () {
      expect(WirelessConnection.fromMap(wirelessConnectionMap), wirelessConnection);
    });

    test('toJson returns a valid JSON string', () {
      expect(wirelessConnection.toJson(), json.encode(wirelessConnectionMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WirelessConnection.fromJson(json.encode(wirelessConnectionMap)), wirelessConnection);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedConnection = wirelessConnection.copyWith(
        isGuest: true,
        signalDecibels: -60,
      );
      expect(updatedConnection.isGuest, true);
      expect(updatedConnection.signalDecibels, -60);
      expect(updatedConnection.bssid, wirelessConnection.bssid);
    });

    test('props are correct', () {
      final wc1 = WirelessConnection(bssid: 'b1', isGuest: true, band: 'band1', signalDecibels: 1);
      final wc2 = WirelessConnection(bssid: 'b1', isGuest: true, band: 'band1', signalDecibels: 1);
      final wc3 = WirelessConnection(bssid: 'b2', isGuest: false, band: 'band2', signalDecibels: 2);
      expect(wc1, wc2);
      expect(wc1.props, wc2.props);
      expect(wc1 == wc3, false);
      expect(wc1.props == wc3.props, false);
    });
  });
}
