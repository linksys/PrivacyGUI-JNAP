import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/wan_port.dart';

void main() {
  group('WANPortData', () {
    const wanPort = WANPortData(
      portId: 1,
    );

    final Map<String, dynamic> wanPortMap = {
      'portId': 1,
    };

    test('toMap returns a valid map', () {
      expect(wanPort.toMap(), wanPortMap);
    });

    test('fromMap creates a valid object', () {
      expect(WANPortData.fromMap(wanPortMap), wanPort);
    });

    test('toJson returns a valid JSON string', () {
      expect(wanPort.toJson(), json.encode(wanPortMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WANPortData.fromJson(json.encode(wanPortMap)), wanPort);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedPort = wanPort.copyWith(
        portId: 2,
      );
      expect(updatedPort.portId, 2);
    });

    test('props are correct', () {
      final port1 = WANPortData(portId: 1);
      final port2 = WANPortData(portId: 1);
      final port3 = WANPortData(portId: 2);
      expect(port1, port2);
      expect(port1.props, port2.props);
      expect(port1 == port3, false);
      expect(port1.props == port3.props, false);
    });
  });
}