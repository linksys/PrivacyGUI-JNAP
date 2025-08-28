import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/device.dart';

void main() {
  group('RawDeviceConnection', () {
    const rawDeviceConnection = RawDeviceConnection(
      macAddress: '00:11:22:33:44:55',
      ipAddress: '192.168.1.100',
      ipv6Address: 'fe80::1',
      parentDeviceID: 'parent123',
      isGuest: true,
    );

    final Map<String, dynamic> rawDeviceConnectionMap = {
      'macAddress': '00:11:22:33:44:55',
      'ipAddress': '192.168.1.100',
      'ipv6Address': 'fe80::1',
      'parentDeviceID': 'parent123',
      'isGuest': true,
    };

    test('toMap returns a valid map', () {
      expect(rawDeviceConnection.toMap(), rawDeviceConnectionMap);
    });

    test('fromMap creates a valid object', () {
      expect(RawDeviceConnection.fromMap(rawDeviceConnectionMap), rawDeviceConnection);
    });

    test('toJson returns a valid JSON string', () {
      expect(rawDeviceConnection.toJson(), json.encode(rawDeviceConnectionMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RawDeviceConnection.fromJson(json.encode(rawDeviceConnectionMap)), rawDeviceConnection);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedConnection = rawDeviceConnection.copyWith(
        ipAddress: '192.168.1.101',
        isGuest: false,
      );
      expect(updatedConnection.ipAddress, '192.168.1.101');
      expect(updatedConnection.isGuest, false);
      expect(updatedConnection.macAddress, rawDeviceConnection.macAddress);
    });

    test('props are correct', () {
      final conn1 = RawDeviceConnection(macAddress: 'mac1');
      final conn2 = RawDeviceConnection(macAddress: 'mac1');
      final conn3 = RawDeviceConnection(macAddress: 'mac2');
      expect(conn1, conn2);
      expect(conn1.props, conn2.props);
      expect(conn1 == conn3, false);
      expect(conn1.props == conn3.props, false);
    });
  });

  group('RawDeviceProperty', () {
    const rawDeviceProperty = RawDeviceProperty(
      name: 'propertyName',
      value: 'propertyValue',
    );

    final Map<String, dynamic> rawDevicePropertyMap = {
      'name': 'propertyName',
      'value': 'propertyValue',
    };

    test('toMap returns a valid map', () {
      expect(rawDeviceProperty.toMap(), rawDevicePropertyMap);
    });

    test('fromMap creates a valid object', () {
      expect(RawDeviceProperty.fromMap(rawDevicePropertyMap), rawDeviceProperty);
    });

    test('toJson returns a valid JSON string', () {
      expect(rawDeviceProperty.toJson(), json.encode(rawDevicePropertyMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RawDeviceProperty.fromJson(json.encode(rawDevicePropertyMap)), rawDeviceProperty);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedProperty = rawDeviceProperty.copyWith(
        value: 'newValue',
      );
      expect(updatedProperty.value, 'newValue');
      expect(updatedProperty.name, rawDeviceProperty.name);
    });

    test('props are correct', () {
      final prop1 = RawDeviceProperty(name: 'name1', value: 'value1');
      final prop2 = RawDeviceProperty(name: 'name1', value: 'value1');
      final prop3 = RawDeviceProperty(name: 'name2', value: 'value2');
      expect(prop1, prop2);
      expect(prop1.props, prop2.props);
      expect(prop1 == prop3, false);
      expect(prop1.props == prop3.props, false);
    });
  });

  group('RawDeviceUnit', () {
    const rawDeviceUnit = RawDeviceUnit(
      serialNumber: 'SN123',
      firmwareVersion: '1.0.0',
      firmwareDate: '2023-01-01',
      operatingSystem: 'Linux',
    );

    final Map<String, dynamic> rawDeviceUnitMap = {
      'serialNumber': 'SN123',
      'firmwareVersion': '1.0.0',
      'firmwareDate': '2023-01-01',
      'operatingSystem': 'Linux',
    };

    test('toMap returns a valid map', () {
      expect(rawDeviceUnit.toMap(), rawDeviceUnitMap);
    });

    test('fromMap creates a valid object', () {
      expect(RawDeviceUnit.fromMap(rawDeviceUnitMap), rawDeviceUnit);
    });

    test('toJson returns a valid JSON string', () {
      expect(rawDeviceUnit.toJson(), json.encode(rawDeviceUnitMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RawDeviceUnit.fromJson(json.encode(rawDeviceUnitMap)), rawDeviceUnit);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedUnit = rawDeviceUnit.copyWith(
        firmwareVersion: '1.0.1',
      );
      expect(updatedUnit.firmwareVersion, '1.0.1');
      expect(updatedUnit.serialNumber, rawDeviceUnit.serialNumber);
    });

    test('props are correct', () {
      final unit1 = RawDeviceUnit(serialNumber: 'SN1');
      final unit2 = RawDeviceUnit(serialNumber: 'SN1');
      final unit3 = RawDeviceUnit(serialNumber: 'SN2');
      expect(unit1, unit2);
      expect(unit1.props, unit2.props);
      expect(unit1 == unit3, false);
      expect(unit1.props == unit3.props, false);
    });
  });

  group('RawDeviceModel', () {
    const rawDeviceModel = RawDeviceModel(
      deviceType: 'Router',
      manufacturer: 'Belkin',
      modelNumber: 'MR9000',
      hardwareVersion: '1.0',
      modelDescription: 'Smart Mesh Router',
    );

    final Map<String, dynamic> rawDeviceModelMap = {
      'deviceType': 'Router',
      'manufacturer': 'Belkin',
      'modelNumber': 'MR9000',
      'hardwareVersion': '1.0',
      'modelDescription': 'Smart Mesh Router',
    };

    test('toMap returns a valid map', () {
      expect(rawDeviceModel.toMap(), rawDeviceModelMap);
    });

    test('fromMap creates a valid object', () {
      expect(RawDeviceModel.fromMap(rawDeviceModelMap), rawDeviceModel);
    });

    test('toJson returns a valid JSON string', () {
      expect(rawDeviceModel.toJson(), json.encode(rawDeviceModelMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RawDeviceModel.fromJson(json.encode(rawDeviceModelMap)), rawDeviceModel);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedModel = rawDeviceModel.copyWith(
        modelNumber: 'MR9001',
      );
      expect(updatedModel.modelNumber, 'MR9001');
      expect(updatedModel.deviceType, rawDeviceModel.deviceType);
    });

    test('props are correct', () {
      final model1 = RawDeviceModel(deviceType: 'type1');
      final model2 = RawDeviceModel(deviceType: 'type1');
      final model3 = RawDeviceModel(deviceType: 'type2');
      expect(model1, model2);
      expect(model1.props, model2.props);
      expect(model1 == model3, false);
      expect(model1.props == model3.props, false);
    });
  });

  group('RawDeviceKnownInterface', () {
    const rawDeviceKnownInterface = RawDeviceKnownInterface(
      macAddress: '00:11:22:33:44:55',
      interfaceType: 'Ethernet',
      band: '2.4GHz',
    );

    final Map<String, dynamic> rawDeviceKnownInterfaceMap = {
      'macAddress': '00:11:22:33:44:55',
      'interfaceType': 'Ethernet',
      'band': '2.4GHz',
    };

    test('toMap returns a valid map', () {
      expect(rawDeviceKnownInterface.toMap(), rawDeviceKnownInterfaceMap);
    });

    test('fromMap creates a valid object', () {
      expect(RawDeviceKnownInterface.fromMap(rawDeviceKnownInterfaceMap), rawDeviceKnownInterface);
    });

    test('toJson returns a valid JSON string', () {
      expect(rawDeviceKnownInterface.toJson(), json.encode(rawDeviceKnownInterfaceMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RawDeviceKnownInterface.fromJson(json.encode(rawDeviceKnownInterfaceMap)), rawDeviceKnownInterface);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInterface = rawDeviceKnownInterface.copyWith(
        band: '5GHz',
      );
      expect(updatedInterface.band, '5GHz');
      expect(updatedInterface.macAddress, rawDeviceKnownInterface.macAddress);
    });

    test('props are correct', () {
      final interface1 = RawDeviceKnownInterface(macAddress: 'mac1', interfaceType: 'type1');
      final interface2 = RawDeviceKnownInterface(macAddress: 'mac1', interfaceType: 'type1');
      final interface3 = RawDeviceKnownInterface(macAddress: 'mac2', interfaceType: 'type2');
      expect(interface1, interface2);
      expect(interface1.props, interface2.props);
      expect(interface1 == interface3, false);
      expect(interface1.props == interface3.props, false);
    });
  });

  group('RawDevice', () {
    const connection1 = RawDeviceConnection(macAddress: '00:11:22:33:44:55');
    const connection2 = RawDeviceConnection(macAddress: 'AA:BB:CC:DD:EE:FF');
    const property1 = RawDeviceProperty(name: 'userDeviceOS', value: 'iOS');
    const property2 = RawDeviceProperty(name: 'userDeviceManufacturer', value: 'Apple');
    const unit = RawDeviceUnit(serialNumber: 'SN123');
    const model = RawDeviceModel(deviceType: 'Mobile');
    const knownInterface1 = RawDeviceKnownInterface(macAddress: '00:11:22:33:44:55', interfaceType: 'WiFi');

    const rawDevice = RawDevice(
      connections: [connection1, connection2],
      properties: [property1, property2],
      unit: unit,
      deviceID: 'device123',
      maxAllowedProperties: 10,
      model: model,
      isAuthority: true,
      lastChangeRevision: 1,
      friendlyName: 'My iPhone',
      knownInterfaces: [knownInterface1],
      knownMACAddresses: ['00:11:22:33:44:55'],
      nodeType: 'Client',
    );

    final Map<String, dynamic> rawDeviceMap = {
      'connections': [connection1.toMap(), connection2.toMap()],
      'properties': [property1.toMap(), property2.toMap()],
      'unit': unit.toMap(),
      'deviceID': 'device123',
      'maxAllowedProperties': 10,
      'model': model.toMap(),
      'isAuthority': true,
      'lastChangeRevision': 1,
      'friendlyName': 'My iPhone',
      'knownInterfaces': [knownInterface1.toMap()],
      'knownMACAddresses': ['00:11:22:33:44:55'],
      'nodeType': 'Client',
    };

    test('toMap returns a valid map', () {
      expect(rawDevice.toMap(), rawDeviceMap);
    });

    test('fromMap creates a valid object', () {
      expect(RawDevice.fromMap(rawDeviceMap), rawDevice);
    });

    test('toJson returns a valid JSON string', () {
      expect(rawDevice.toJson(), json.encode(rawDeviceMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RawDevice.fromJson(json.encode(rawDeviceMap)), rawDevice);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedDevice = rawDevice.copyWith(
        friendlyName: 'My New iPhone',
        maxAllowedProperties: 12,
      );
      expect(updatedDevice.friendlyName, 'My New iPhone');
      expect(updatedDevice.maxAllowedProperties, 12);
      expect(updatedDevice.deviceID, rawDevice.deviceID);
    });

    test('hasSameInterface returns true if macAddress exists in knownInterfaces', () {
      expect(rawDevice.hasSameInterface('00:11:22:33:44:55'), true);
    });

    test('hasSameInterface returns false if macAddress does not exist in knownInterfaces', () {
      expect(rawDevice.hasSameInterface('FF:FF:FF:FF:FF:FF'), false);
    });

    test('hasConnection returns true if macAddress exists in connections', () {
      expect(rawDevice.hasConnection('00:11:22:33:44:55'), true);
    });

    test('hasConnection returns false if macAddress does not exist in connections', () {
      expect(rawDevice.hasConnection('11:22:33:44:55:66'), false);
    });

    test('operatingSystem returns correct value', () {
      expect(rawDevice.operatingSystem, 'iOS');
    });

    test('manufacturer returns correct value', () {
      expect(rawDevice.manufacturer, 'Apple');
    });

    test('modelNumber returns correct value', () {
      expect(rawDevice.modelNumber, null); // No modelNumber in properties for this test case
    });

    test('props are correct', () {
      final device1 = RawDevice(
        connections: [connection1],
        properties: [property1],
        unit: unit,
        deviceID: 'id1',
        maxAllowedProperties: 1,
        model: model,
        isAuthority: true,
        lastChangeRevision: 1,
      );
      final device2 = RawDevice(
        connections: [connection1],
        properties: [property1],
        unit: unit,
        deviceID: 'id1',
        maxAllowedProperties: 1,
        model: model,
        isAuthority: true,
        lastChangeRevision: 1,
      );
      final device3 = RawDevice(
        connections: [connection2],
        properties: [property2],
        unit: unit,
        deviceID: 'id2',
        maxAllowedProperties: 2,
        model: model,
        isAuthority: false,
        lastChangeRevision: 2,
      );

      expect(device1, device2);
      expect(device1.props, device2.props);
      expect(device1 == device3, false);
      expect(device1.props == device3.props, false);
    });
  });
}
