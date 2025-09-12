import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:test/test.dart';

void main() {
  group('DeviceUtil on RawDevice', () {
    test('getDeviceLocation returns userDeviceLocation if present', () {
      final device = RawDevice(
        properties: [
          RawDeviceProperty(name: 'userDeviceLocation', value: 'Living Room'),
          RawDeviceProperty(name: 'userDeviceName', value: 'My Node'),
        ],
        connections: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceLocation(), 'Living Room');
    });

    test('getDeviceLocation falls back to getDeviceName', () {
      final device = RawDevice(
        properties: [
          RawDeviceProperty(name: 'userDeviceName', value: 'My Node'),
        ],
        friendlyName: 'Friendly Node',
        connections: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceLocation(), 'My Node');
    });

    test('getDeviceName returns userDeviceName if present', () {
      final device = RawDevice(
        properties: [
          RawDeviceProperty(name: 'userDeviceName', value: 'My Precious'),
        ],
        friendlyName: 'Gollum',
        connections: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceName(), 'My Precious');
    });

    test('getDeviceName falls back to friendlyName', () {
      final device = RawDevice(
        properties: [],
        friendlyName: 'Friendly',
        model: RawDeviceModel(modelNumber: 'ModelX', deviceType: 'Router'),
        connections: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceName(), 'Friendly');
    });

    test('getDeviceName falls back to modelNumber', () {
      final device = RawDevice(
        properties: [],
        model: RawDeviceModel(modelNumber: 'ModelX', deviceType: 'Router'),
        connections: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceName(), 'ModelX');
    });

    test('getDeviceName returns default for guest device', () {
      final device = RawDevice(
        properties: [],
        model: RawDeviceModel(deviceType: 'Device'),
        connections: [RawDeviceConnection(isGuest: true, macAddress: 'AA:BB:CC:DD:EE:FF')],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceName(), 'Guest Network Device');
    });

    test('getDeviceName returns default for network device', () {
      final device = RawDevice(
        properties: [],
        model: RawDeviceModel(deviceType: 'Device'),
        connections: [RawDeviceConnection(isGuest: false, macAddress: 'AA:BB:CC:DD:EE:FF')],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getDeviceName(), 'Network Device');
    });

    test('getMacAddress returns from knownInterfaces', () {
      final device = RawDevice(
        knownInterfaces: [
          RawDeviceKnownInterface(macAddress: 'AA:BB:CC:DD:EE:FF', interfaceType: 'Wireless', band: '5GHz'),
        ],
        connections: [],
        properties: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getMacAddress(), 'AA:BB:CC:DD:EE:FF');
    });

    test('getMacAddress falls back to knownMACAddresses', () {
      final device = RawDevice(
        knownMACAddresses: ['11:22:33:44:55:66'],
        connections: [],
        properties: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.getMacAddress(), '11:22:33:44:55:66');
    });

    test('containsMacAddress', () {
      final device = RawDevice(
        knownInterfaces: [
          RawDeviceKnownInterface(macAddress: 'AA:BB:CC:DD:EE:FF', interfaceType: 'Wireless', band: '5GHz'),
        ],
        connections: [],
        properties: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.containsMacAddress('AA:BB:CC:DD:EE:FF'), isTrue);
      expect(device.containsMacAddress('11:22:33:44:55:66'), isFalse);
    });

    test('containsIpAddress', () {
      final device = RawDevice(
        connections: [RawDeviceConnection(ipAddress: '192.168.1.100', macAddress: 'AA:BB:CC:DD:EE:FF')],
        properties: [],
        unit: RawDeviceUnit(),
        deviceID: '',
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        isAuthority: false,
        lastChangeRevision: 0,
      );
      expect(device.containsIpAddress('192.168.1.100'), isTrue);
      expect(device.containsIpAddress('192.168.1.101'), isFalse);
    });
  });

  group('LinksysDeviceExt on LinksysDevice', () {
    final baseDevice = LinksysDevice(
      connections: [],
      properties: [],
      unit: RawDeviceUnit(),
      deviceID: '',
      maxAllowedProperties: 0,
      model: RawDeviceModel(modelNumber: '', deviceType: ''),
      isAuthority: false,
      lastChangeRevision: 0,
    );

    test('isOnline', () {
      expect(baseDevice.copyWith(connections: []).isOnline(), isFalse);
      expect(baseDevice.copyWith(connections: [RawDeviceConnection(macAddress: 'AA:BB:CC:DD:EE:FF')]).isOnline(), isTrue);
    });

    test('isNodeDevice', () {
      expect(baseDevice.copyWith(nodeType: 'Master').isNodeDevice, isTrue);
      expect(baseDevice.copyWith(nodeType: 'Slave').isNodeDevice, isTrue);
      expect(baseDevice.copyWith(isAuthority: true).isNodeDevice, isTrue);
      expect(baseDevice.copyWith(nodeType: null, isAuthority: false).isNodeDevice, isFalse);
    });

    test('isExternalDevice', () {
      expect(baseDevice.copyWith(nodeType: null).isExternalDevice, isTrue);
      expect(baseDevice.copyWith(nodeType: 'Master').isExternalDevice, isFalse);
    });

    test('isMasterDevice', () {
      expect(baseDevice.copyWith(isAuthority: true).isMasterDevice, isTrue);
      expect(baseDevice.copyWith(nodeType: 'Master').isMasterDevice, isTrue);
      expect(baseDevice.copyWith(isAuthority: false, nodeType: 'Slave').isMasterDevice, isFalse);
    });

    test('isSlaveDevice', () {
      expect(baseDevice.copyWith(isAuthority: false, nodeType: 'Slave').isSlaveDevice, isTrue);
      expect(baseDevice.copyWith(isAuthority: true).isSlaveDevice, isFalse);
    });

    test('isMainWifiDevice', () {
      expect(baseDevice.copyWith(connectedWifiType: WifiConnectionType.main).isMainWifiDevice, isTrue);
      expect(baseDevice.copyWith(connectedWifiType: WifiConnectionType.guest).isMainWifiDevice, isFalse);
    });

    test('isGuestWifiDevice', () {
      expect(baseDevice.copyWith(connectedWifiType: WifiConnectionType.guest).isGuestWifiDevice, isTrue);
      expect(baseDevice.copyWith(connectedWifiType: WifiConnectionType.main).isGuestWifiDevice, isFalse);
    });
  });
}
