import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:jnap/src/functions/device_manager/service/devices_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:jnap/src/models/jnap_data/device.dart';
import 'package:jnap/src/models/jnap_data/wirless_connection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockJnap extends Mock implements Jnap {}

class FakeJnapAction extends Fake implements JNAPAction {}

class FakeJnapTransactionBuilder extends Fake
    implements JNAPTransactionBuilder {}

class FakeJnapConfigOverrides extends Fake implements JNAPConfigOverrides {}

void main() {
  late ProviderContainer container;
  late MockJnap mockJnap;
  late DevicesService devicesService;

  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
    registerFallbackValue(FakeJnapTransactionBuilder());
    registerFallbackValue(FakeJnapConfigOverrides());
  });

  // Helper to create a basic device
  LinksysDevice createDevice({
    required String deviceID,
    String? nodeType,
    bool isAuthority = false,
    List<RawDeviceConnection> connections = const [],
    List<RawDeviceKnownInterface> knownInterfaces = const [
      RawDeviceKnownInterface(
          macAddress: 'AA:BB:CC:11:22:33', interfaceType: 'WiFi'),
    ],
    String? mac,
  }) {
    return LinksysDevice(
      connections: connections,
      properties: [],
      unit: RawDeviceUnit(),
      deviceID: deviceID,
      maxAllowedProperties: 10,
      model: RawDeviceModel(
        deviceType: 'TestDevice',
        modelNumber: 'TestModel',
      ),
      isAuthority: isAuthority,
      lastChangeRevision: 1,
      knownInterfaces: knownInterfaces,
      nodeType: nodeType,
    );
  }

  setUp(() {
    mockJnap = MockJnap();
    container = ProviderContainer(overrides: [
      jnapProvider.overrideWithValue(mockJnap),
    ]);
    final ref = container.read(Provider((ref) => ref));
    devicesService = DevicesService(ref);
  });

  group('getDeviceListAndLocations', () {
    test('correctly separates nodes and external devices', () {
      final data = {
        'devices': [
          createDevice(
                  deviceID: 'master', isAuthority: true, nodeType: 'Master')
              .toMap(),
          createDevice(deviceID: 'slave', nodeType: 'Slave').toMap(),
          createDevice(deviceID: 'client', nodeType: null).toMap(),
        ]
      };

      final result = devicesService.getDeviceListAndLocations(data, {});
      expect(result.where((d) => d.isNodeDevice).length, 2);
      expect(result.where((d) => d.isExternalDevice).length, 1);
      expect(result.first.deviceID, 'master'); // Master should be first
    });

    test('assigns connected devices to nodes', () {
      final data = {
        'devices': [
          createDevice(
              deviceID: 'master',
              isAuthority: true,
              nodeType: 'Master',
              connections: [
                RawDeviceConnection(
                    ipAddress: '192.168.1.1', macAddress: 'AA:BB:CC:11:22:33')
              ]).toMap(),
          createDevice(
            deviceID: 'client',
            nodeType: null,
            connections: [
              RawDeviceConnection(
                  parentDeviceID: 'master',
                  ipAddress: '192.168.1.100',
                  macAddress: 'AA:BB:CC:11:22:33')
            ],
          ).toMap(),
        ]
      };

      final result = devicesService.getDeviceListAndLocations(data, {});
      final master = result.firstWhere((d) => d.deviceID == 'master');
      expect(master.connectedDevices.length, 1);
      expect(master.connectedDevices.first.deviceID, 'client');
    });

    test('determines wifi connection type for external devices', () {
      final clientDevice = createDevice(
        deviceID: 'client',
        nodeType: null,
        mac: 'AA:BB:CC:11:22:33',
        connections: [
          RawDeviceConnection(
              parentDeviceID: 'master',
              ipAddress: '192.168.1.100',
              macAddress: 'AA:BB:CC:11:22:33')
        ],
      );
      final data = {
        'devices': [clientDevice.toMap()]
      };
      final wirelessConnections = {
        'AA:BB:CC:11:22:33': WirelessConnectionData(
            bssid: '', isGuest: true, band: '2.4GHz', signalDecibels: -55),
      };

      final result =
          devicesService.getDeviceListAndLocations(data, wirelessConnections);
      final client = result.firstWhere((d) => d.deviceID == 'client');
      expect(client.isGuestWifiDevice, isTrue);
    });
  });

  group('updateDeviceIpWithBackhaulInfo', () {
    test('updates device IP and connection info from backhaul data', () {
      final device = createDevice(
        deviceID: 'slave-uuid',
        nodeType: 'Slave',
        connections: [
          RawDeviceConnection(
              ipAddress: '0.0.0.0', macAddress: 'AA:BB:CC:11:22:33')
        ],
      );
      final backhaulInfo = [
        BackHaulInfoData(
            deviceUUID: 'slave-uuid',
            ipAddress: '192.168.1.50',
            parentIPAddress: '',
            connectionType: 'Wireless',
            wirelessConnectionInfo: WirelessConnectionInfo(
                radioID: 'radio1',
                channel: 1,
                apRSSI: -55,
                stationRSSI: -55,
                apBSSID: 'apBSSID1',
                stationBSSID: 'stationBSSID1'),
            speedMbps: '500',
            timestamp: ''),
      ];

      final result = devicesService.updateDeviceIpWithBackhaulInfo(
        deviceList: [device],
        backhaulInfoList: backhaulInfo,
      );
      final updatedDevice = result.first;
      expect(updatedDevice.connections.first.ipAddress, '192.168.1.50');
      expect(updatedDevice.connectionType, 'Wireless');
      expect(updatedDevice.speedMbps, '500');
      expect(updatedDevice.wirelessConnectionInfo?.stationRSSI, -55);
    });
  });

  group('updateDeviceWirelessSignalWithWirelessConnections', () {
    test('updates signal strength from wireless connections data', () {
      final device = createDevice(deviceID: 'client', mac: 'AA:BB:CC:11:22:33');
      final wirelessConnections = {
        'AA:BB:CC:11:22:33': WirelessConnectionData(
            bssid: '', isGuest: false, signalDecibels: -65, band: '2.4GHz'),
      };

      final result =
          devicesService.updateDeviceWirelessSignalWithWirelessConnections(
        deviceList: [device],
        wirelessConnections: wirelessConnections,
      );
      expect(result.first.signalDecibels, -65);
    });
  });

  group('findParent', () {
    final master = createDevice(
        deviceID: 'master',
        isAuthority: true,
        connections: [
          RawDeviceConnection(
              ipAddress: '192.168.1.1', macAddress: 'AA:BB:CC:11:22:33')
        ]);
    final slave = createDevice(
        deviceID: 'slave',
        nodeType: 'Slave',
        connections: [
          RawDeviceConnection(
              ipAddress: '192.168.1.50', macAddress: 'AA:BB:CC:11:22:34')
        ]);
    final client = createDevice(deviceID: 'client', connections: [
      RawDeviceConnection(
          parentDeviceID: 'slave', macAddress: 'AA:BB:CC:11:22:35')
    ]);

    test('finds parent via parentDeviceID', () {
      final parent = devicesService.findParent(
        deviceID: 'client',
        deviceList: [master, slave, client],
        masterDevice: master,
        backhaulInfoList: [],
      );
      expect(parent?.deviceID, 'slave');
    });

    test('finds parent via backhaul info', () {
      final backhaul = [
        BackHaulInfoData(
            deviceUUID: 'slave',
            ipAddress: '192.168.1.50',
            parentIPAddress: '192.168.1.1',
            connectionType: 'Wireless',
            speedMbps: '500',
            wirelessConnectionInfo: WirelessConnectionInfo(
                stationRSSI: -55,
                radioID: 'radio-1',
                channel: 1,
                apRSSI: -65,
                apBSSID: 'AA:BB:CC:11:22:33',
                stationBSSID: 'AA:BB:CC:11:22:34'),
            timestamp: '2025-09-10T19:01:23.234Z')
      ];
      final parent = devicesService.findParent(
        deviceID: 'slave',
        deviceList: [master, slave],
        masterDevice: master,
        backhaulInfoList: backhaul,
      );
      expect(parent?.deviceID, 'master');
    });

    test('returns master for orphan node', () {
      final orphanSlave = createDevice(
          deviceID: 'slave',
          nodeType: 'Slave',
          connections: [
            RawDeviceConnection(
                parentDeviceID: null, macAddress: 'AA:BB:CC:11:22:36')
          ]);
      final parent = devicesService.findParent(
        deviceID: 'slave',
        deviceList: [master, orphanSlave],
        masterDevice: master,
        backhaulInfoList: [],
      );
      expect(parent?.deviceID, 'master');
    });
  });

  group('API-calling methods', () {
    setUp(() {
      when(() => mockJnap.send(
            action: any(named: 'action'),
            data: any(named: 'data'),
            overrides: any(named: 'overrides'),
          )).thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));
    });

    test('updateDeviceNameAndIcon sends SetDeviceProperties and GetDevices',
        () async {
      await devicesService.updateDeviceNameAndIcon(
        deviceList: [],
        targetId: 'test-id',
        newName: 'New Name',
        isLocation: true,
      );

      verify(() => mockJnap.send(
          action: SetDeviceProperties.instance,
          data: any(named: 'data'),
          overrides: any(named: 'overrides'))).called(1);
      verify(() => mockJnap.send(
          action: GetDevices.instance,
          overrides: any(named: 'overrides'))).called(1);
    });

    test('deleteDevices uses a transaction', () async {
      when(() => mockJnap.transaction(
            transactionBuilder: any(named: 'transactionBuilder'),
            overrides: any(named: 'overrides'),
          )).thenAnswer((_) async => JNAPTransactionSuccessWrap(data: [
            MapEntry(
                DeleteDevice.instance, JNAPSuccess(result: 'OK', output: {})),
          ], result: 'OK'));

      final result = await devicesService.deleteDevices(
        deviceIds: ['id1'],
        deviceList: [
          createDevice(deviceID: 'id1'),
          createDevice(deviceID: 'id2')
        ],
      );

      verify(() => mockJnap.transaction(
          transactionBuilder: any(named: 'transactionBuilder'),
          overrides: any(named: 'overrides'))).called(1);
      expect(result.length, 1);
      expect(result.first.deviceID, 'id2');
    });

    test('deauthClient sends ClientDeauth action', () async {
      await devicesService.deauthClient(macAddress: 'AA:BB:CC:DD:EE:FF');

      final captured = verify(() => mockJnap.send(
          action: ClientDeauth.instance,
          data: captureAny(named: 'data'),
          overrides: any(named: 'overrides'))).captured;
      expect(captured.first['macAddress'], 'AA:BB:CC:DD:EE:FF');
    });
  });
}
