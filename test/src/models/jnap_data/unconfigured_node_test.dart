import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/unconfigured_node.dart';

void main() {
  group('BTDiscoveryDataData', () {
    const btDiscoveryData = BTDiscoveryDataData(
      name: 'My Bluetooth Device',
      macAddress: '00:11:22:33:44:55',
      rssi: -70,
      modeLimit: 'Limited',
    );

    final Map<String, dynamic> btDiscoveryDataMap = {
      'name': 'My Bluetooth Device',
      'macAddress': '00:11:22:33:44:55',
      'rssi': -70,
      'modeLimit': 'Limited',
    };

    test('toMap returns a valid map', () {
      expect(btDiscoveryData.toMap(), btDiscoveryDataMap);
    });

    test('fromMap creates a valid object', () {
      expect(BTDiscoveryDataData.fromMap(btDiscoveryDataMap), btDiscoveryData);
    });

    test('toJson returns a valid JSON string', () {
      expect(btDiscoveryData.toJson(), json.encode(btDiscoveryDataMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(BTDiscoveryDataData.fromJson(json.encode(btDiscoveryDataMap)), btDiscoveryData);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedData = btDiscoveryData.copyWith(
        name: 'New Device Name',
        rssi: -80,
      );
      expect(updatedData.name, 'New Device Name');
      expect(updatedData.rssi, -80);
      expect(updatedData.macAddress, btDiscoveryData.macAddress);
    });

    test('props are correct', () {
      final data1 = BTDiscoveryDataData(name: 'n1', macAddress: 'm1', rssi: 1);
      final data2 = BTDiscoveryDataData(name: 'n1', macAddress: 'm1', rssi: 1);
      final data3 = BTDiscoveryDataData(name: 'n2', macAddress: 'm2', rssi: 2);
      expect(data1, data2);
      expect(data1.props, data2.props);
      expect(data1 == data3, false);
      expect(data1.props == data3.props, false);
    });
  });
}