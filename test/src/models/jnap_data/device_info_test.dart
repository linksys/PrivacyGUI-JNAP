import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/device_info.dart';

void main() {
  group('NodeDeviceInfoData', () {
    const nodeDeviceInfo = NodeDeviceInfoData(
      modelNumber: 'ModelX',
      firmwareVersion: '1.0.0',
      description: 'Test Device',
      firmwareDate: '2023-01-01',
      manufacturer: 'TestCorp',
      serialNumber: 'SN12345',
      hardwareVersion: 'HW1.0',
      services: ['ServiceA', 'ServiceB'],
    );

    final Map<String, dynamic> nodeDeviceInfoMap = {
      'modelNumber': 'ModelX',
      'firmwareVersion': '1.0.0',
      'description': 'Test Device',
      'firmwareDate': '2023-01-01',
      'manufacturer': 'TestCorp',
      'serialNumber': 'SN12345',
      'hardwareVersion': 'HW1.0',
      'services': ['ServiceA', 'ServiceB'],
    };

    test('toMap returns a valid map', () {
      expect(nodeDeviceInfo.toMap(), nodeDeviceInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(NodeDeviceInfoData.fromMap(nodeDeviceInfoMap), nodeDeviceInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(nodeDeviceInfo.toJson(), json.encode(nodeDeviceInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(NodeDeviceInfoData.fromJson(json.encode(nodeDeviceInfoMap)), nodeDeviceInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = nodeDeviceInfo.copyWith(
        modelNumber: 'ModelY',
        services: ['ServiceC'],
      );
      expect(updatedInfo.modelNumber, 'ModelY');
      expect(updatedInfo.services, ['ServiceC']);
      expect(updatedInfo.firmwareVersion, nodeDeviceInfo.firmwareVersion);
    });

    test('props are correct', () {
      final info1 = NodeDeviceInfoData(
        modelNumber: 'ModelX',
        firmwareVersion: '1.0.0',
        description: 'Test Device',
        firmwareDate: '2023-01-01',
        manufacturer: 'TestCorp',
        serialNumber: 'SN12345',
        hardwareVersion: 'HW1.0',
        services: ['ServiceA', 'ServiceB'],
      );
      final info2 = NodeDeviceInfoData(
        modelNumber: 'ModelX',
        firmwareVersion: '1.0.0',
        description: 'Test Device',
        firmwareDate: '2023-01-01',
        manufacturer: 'TestCorp',
        serialNumber: 'SN12345',
        hardwareVersion: 'HW1.0',
        services: ['ServiceA', 'ServiceB'],
      );
      final info3 = NodeDeviceInfoData(
        modelNumber: 'ModelZ',
        firmwareVersion: '2.0.0',
        description: 'Another Device',
        firmwareDate: '2023-01-02',
        manufacturer: 'AnotherCorp',
        serialNumber: 'SN54321',
        hardwareVersion: 'HW2.0',
        services: ['ServiceD'],
      );

      expect(info1, info2);
      expect(info1.props, info2.props);
      expect(info1 == info3, false);
      expect(info1.props == info3.props, false);
    });
  });
}