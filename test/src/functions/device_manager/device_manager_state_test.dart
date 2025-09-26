import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:test/test.dart';

void main() {
  group('LinksysDevice', () {
    final linksysDeviceMap = {
      "connections": [
        {
          "macAddress": "80:69:1A:BB:46:94",
          "ipAddress": "10.138.1.166",
          "ipv6Address": "fe80:0000:0000:0000:8269:1aff:febb:4694",
          "parentDeviceID": null,
          "isGuest": null
        }
      ],
      "properties": [],
      "unit": {
        "serialNumber": "65G10M27E03027",
        "firmwareVersion": "1.0.4.216421",
        "firmwareDate": null,
        "operatingSystem": null
      },
      "deviceID": "0217b8a4-1082-4532-8345-80691abb4694",
      "maxAllowedProperties": 16,
      "model": {
        "deviceType": "Infrastructure",
        "manufacturer": "Linksys",
        "modelNumber": "LN16",
        "hardwareVersion": null,
        "modelDescription": null
      },
      "isAuthority": false,
      "lastChangeRevision": 218,
      "friendlyName": "Linksys03076",
      "knownInterfaces": [
        {
          "macAddress": "8A:69:1A:BB:46:95",
          "interfaceType": "Unknown",
          "band": null
        },
        {
          "macAddress": "86:69:1A:BB:46:96",
          "interfaceType": "Wireless",
          "band": "5GHz"
        },
        {
          "macAddress": "80:69:1A:BB:46:94",
          "interfaceType": "Unknown",
          "band": null
        }
      ],
      "nodeType": "Slave",
      "connectedDevices": [],
      "connectedWifiType": "main",
      "signalDecibels": -84,
      "connectionType": "Wireless",
      "wirelessConnectionInfo": {
        "radioID": "5GL",
        "channel": 40,
        "apRSSI": -67,
        "stationRSSI": -18,
        "apBSSID": "80:69:1A:BB:46:CE",
        "stationBSSID": "86:69:1A:BB:46:96",
        "txRate": 2168673,
        "rxRate": 2494972,
        "isMultiLinkOperation": false
      },
      "speedMbps": "176.239",
      "mloList": ['5GL']
    };

    test('fromMap and toMap', () {
      final device = LinksysDevice.fromMap(linksysDeviceMap);
      expect(device.deviceID, '0217b8a4-1082-4532-8345-80691abb4694');
      expect(device.isAuthority, isFalse);
      expect(device.toMap(), linksysDeviceMap);
    });

    test('copyWith', () {
      final device = LinksysDevice.fromMap(linksysDeviceMap);
      final updatedDevice = device.copyWith(friendlyName: 'New-Name');
      expect(updatedDevice.friendlyName, 'New-Name');
      expect(device.friendlyName, 'Linksys03076');
    });

    test('json serialization', () {
      final device = LinksysDevice.fromMap(linksysDeviceMap);
      final json = device.toJson();
      final newDevice = LinksysDevice.fromJson(json);
      expect(newDevice, equals(device));
    });
  });

  group('DeviceManagerState', () {
    final deviceManagerStateMap = {
      'wirelessConnections': {},
      'radioInfos': {},
      'deviceList': [],
      'backhaulInfoData': [],
      'lastUpdateTime': 0,
    };

    test('fromMap and toMap', () {
      final state = DeviceManagerState.fromMap(deviceManagerStateMap);
      expect(state.deviceList, isEmpty);
      expect(state.toMap(), deviceManagerStateMap);
    });

    test('copyWith', () {
      final state = DeviceManagerState.fromMap(deviceManagerStateMap);
      final newState = state.copyWith(lastUpdateTime: 123);
      expect(newState.lastUpdateTime, 123);
      expect(state.lastUpdateTime, 0);
    });

    test('json serialization', () {
      final state = DeviceManagerState.fromMap(deviceManagerStateMap);
      final json = state.toJson();
      final newState = DeviceManagerState.fromJson(json);
      expect(newState, equals(state));
    });

    group('getters', () {
      final masterNode = LinksysDevice(
        deviceID: 'master',
        isAuthority: true,
        nodeType: 'Master',
        connections: [
          RawDeviceConnection(
              parentDeviceID: null, macAddress: '00:11:22:33:44:55')
        ],
        properties: [],
        unit: RawDeviceUnit(),
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        lastChangeRevision: 0,
      );
      final slaveNode = LinksysDevice(
        deviceID: 'slave',
        isAuthority: false,
        nodeType: 'Slave',
        connections: [
          RawDeviceConnection(
              parentDeviceID: 'master', macAddress: '00:11:22:33:44:55')
        ],
        properties: [],
        unit: RawDeviceUnit(),
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        lastChangeRevision: 0,
      );
      final externalMain = LinksysDevice(
        deviceID: 'external-main',
        nodeType: null,
        connectedWifiType: WifiConnectionType.main,
        connections: [
          RawDeviceConnection(
              parentDeviceID: 'master', macAddress: '00:11:22:33:44:55')
        ],
        properties: [],
        unit: RawDeviceUnit(),
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        lastChangeRevision: 0,
        isAuthority: false,
      );
      final externalGuest = LinksysDevice(
        deviceID: 'external-guest',
        nodeType: null,
        connectedWifiType: WifiConnectionType.guest,
        connections: [
          RawDeviceConnection(
              parentDeviceID: 'master', macAddress: '00:11:22:33:44:55')
        ],
        properties: [],
        unit: RawDeviceUnit(),
        maxAllowedProperties: 0,
        model: RawDeviceModel(modelNumber: '', deviceType: ''),
        lastChangeRevision: 0,
        isAuthority: false,
      );

      final state = DeviceManagerState(
          deviceList: [masterNode, slaveNode, externalMain, externalGuest]);

      test('nodeDevices', () {
        expect(state.nodeDevices, containsAll([masterNode, slaveNode]));
        expect(state.nodeDevices.length, 2);
      });

      test('externalDevices', () {
        expect(
            state.externalDevices, containsAll([externalMain, externalGuest]));
        expect(state.externalDevices.length, 2);
      });

      test('mainWifiDevices', () {
        expect(state.mainWifiDevices, contains(externalMain));
        expect(state.mainWifiDevices.length, 3);
      });

      test('guestWifiDevices', () {
        expect(state.guestWifiDevices, contains(externalGuest));
        expect(state.guestWifiDevices.length, 1);
      });

      test('masterDevice', () {
        expect(state.masterDevice, masterNode);
      });

      test('slaveDevices', () {
        expect(state.slaveDevices, contains(slaveNode));
        expect(state.slaveDevices.length, 1);
      });
    });
  });
}
