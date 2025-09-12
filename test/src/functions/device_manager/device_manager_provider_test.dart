import 'dart:async';

import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/device_manager/device_manager_provider.dart';
import 'package:jnap/src/functions/device_manager/device_manager_state.dart';
import 'package:jnap/src/functions/polling/polling_provider.dart';

import 'package:jnap/src/functions/polling/providers.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockJnap extends Mock implements Jnap {}

class MockPollingNotifier extends Mock implements PollingNotifier {}

class DelegatingPollingNotifier extends PollingNotifier {
  final MockPollingNotifier mock;
  DelegatingPollingNotifier(this.mock);

  @override
  FutureOr<CoreTransactionData> build() => mock.build();

  @override
  Future<void> forcePolling() => mock.forcePolling();
}

class FakeJnapAction extends Fake implements JNAPAction {}

class FakeJnapTransactionBuilder extends Fake
    implements JNAPTransactionBuilder {}

class FakeJnapConfigOverrides extends Fake implements JNAPConfigOverrides {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
    registerFallbackValue(FakeJnapTransactionBuilder());
    registerFallbackValue(FakeJnapConfigOverrides());
  });

  group('DeviceManagerNotifier', () {
    late ProviderContainer container;
    late MockJnap mockJnap;
    late MockPollingNotifier mockPollingNotifier;

    setUp(() {
      mockJnap = MockJnap();
      mockPollingNotifier = MockPollingNotifier();

      // Setup default empty responses for all actions
      when(() => mockJnap.send(
            action: any(named: 'action'),
            data: any(named: 'data'),
            overrides: any(named: 'overrides'),
          )).thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {}));

      when(() => mockJnap.send(action: GetDevices.instance)).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: {'devices': []}));
      when(() => mockJnap.send(action: GetWANStatus.instance)).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: {'status': 'Down'}));
      when(() => mockJnap.send(action: GetBackhaulInfo.instance)).thenAnswer(
          (_) async =>
              JNAPSuccess(result: 'OK', output: {'backhaulDevices': []}));
      when(() => mockJnap.send(action: GetRadioInfo.instance)).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: {'radios': []}));
      when(() => mockJnap.send(action: GetNetworkConnections.instance))
          .thenAnswer((_) async =>
              JNAPSuccess(result: 'OK', output: {'connections': []}));
      when(() => mockJnap.send(
          action: GetNodesWirelessNetworkConnections
              .instance)).thenAnswer((_) async =>
          JNAPSuccess(result: 'OK', output: {'nodeWirelessConnections': []}));

      // Setup transaction mock
      when(() => mockJnap.transaction(
                transactionBuilder: any(named: 'transactionBuilder'),
                overrides: any(named: 'overrides'),
              ))
          .thenAnswer(
              (_) async => JNAPTransactionSuccessWrap(result: 'OK', data: []));

      when(() => mockPollingNotifier.build()).thenAnswer((_) async =>
          CoreTransactionData(lastUpdate: 12345, isReady: false, data: {}));
      when(() => mockPollingNotifier.forcePolling()).thenAnswer((_) async {});

      container = ProviderContainer(
        overrides: [
          jnapProvider.overrideWithValue(mockJnap),
          // pollingProvider.overrideWith(() => fakePollingNotifier),
          pollingProvider.overrideWith(() => DelegatingPollingNotifier(mockPollingNotifier)),
        ],
      );
    });

    test('initial state is empty', () {
      final state = container.read(deviceManagerProvider);
      expect(state, DeviceManagerState());
      expect(container.read(deviceManagerProvider.notifier).isEmptyState(),
          isTrue);
    });

    test('fetch populates state from JNAP calls', () async {
      // Arrange: Setup specific mock responses
      when(() => mockJnap.send(action: GetDevices.instance))
          .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {
                'devices': [
                  {
                    "connections": [
                      {
                        "macAddress": "80:69:1A:13:16:1A",
                        "ipAddress": "10.110.1.1",
                        "ipv6Address": null,
                        "parentDeviceID": null,
                        "isGuest": null
                      }
                    ],
                    "properties": [],
                    "unit": {
                      "serialNumber": "59A10M23D00062",
                      "firmwareVersion": "1.0.12.216221",
                      "firmwareDate": "2024-09-30T07:39:28Z",
                      "operatingSystem": null
                    },
                    "deviceID": "095aca62-3759-4249-88aa-80691a13161a",
                    "maxAllowedProperties": 16,
                    "model": {
                      "deviceType": "Infrastructure",
                      "manufacturer": "Linksys",
                      "modelNumber": "MBE70",
                      "hardwareVersion": "1",
                      "modelDescription": null
                    },
                    "isAuthority": true,
                    "lastChangeRevision": 298,
                    "friendlyName": "Linksys00062",
                    "knownInterfaces": [
                      {
                        "macAddress": "80:69:1A:13:16:1A",
                        "interfaceType": "Wired",
                        "band": null
                      }
                    ],
                    "nodeType": "Master",
                    "connectedDevices": [
                      {
                        "connections": [
                          {
                            "macAddress": "E2:56:F2:73:C2:38",
                            "ipAddress": "10.110.1.209",
                            "ipv6Address": null,
                            "parentDeviceID":
                                "095aca62-3759-4249-88aa-80691a13161a",
                            "isGuest": null
                          }
                        ],
                        "properties": [],
                        "unit": {
                          "serialNumber": null,
                          "firmwareVersion": null,
                          "firmwareDate": null,
                          "operatingSystem": "Android"
                        },
                        "deviceID": "1ac7a1f2-5e29-4881-946b-c3d7ec3ecadd",
                        "maxAllowedProperties": 16,
                        "model": {
                          "deviceType": "Mobile",
                          "manufacturer": null,
                          "modelNumber": null,
                          "hardwareVersion": null,
                          "modelDescription": null
                        },
                        "isAuthority": false,
                        "lastChangeRevision": 332,
                        "friendlyName": "Pixel-4a",
                        "knownInterfaces": [
                          {
                            "macAddress": "E2:56:F2:73:C2:38",
                            "interfaceType": "Wireless",
                            "band": "5GHz"
                          }
                        ],
                        "connectedDevices": [],
                        "connectedWifiType": "main",
                        "signalDecibels": -84,
                        "connectionType": "wireless",
                        "speedMbps": "--"
                      },
                      {
                        "connections": [
                          {
                            "macAddress": "A4:83:E7:11:8A:19",
                            "ipAddress": "10.110.1.144",
                            "ipv6Address": null,
                            "parentDeviceID":
                                "095aca62-3759-4249-88aa-80691a13161a",
                            "isGuest": null
                          }
                        ],
                        "properties": [],
                        "unit": {
                          "serialNumber": null,
                          "firmwareVersion": null,
                          "firmwareDate": null,
                          "operatingSystem": "macOS"
                        },
                        "deviceID": "a6d4e519-2eda-48a4-8588-3652394397e8",
                        "maxAllowedProperties": 16,
                        "model": {
                          "deviceType": "Computer",
                          "manufacturer": "Apple Inc.",
                          "modelNumber": "MacBook Pro",
                          "hardwareVersion": null,
                          "modelDescription": null
                        },
                        "isAuthority": false,
                        "lastChangeRevision": 315,
                        "friendlyName": "ASTWP-028279",
                        "knownInterfaces": [
                          {
                            "macAddress": "A4:83:E7:11:8A:19",
                            "interfaceType": "Wireless",
                            "band": "5GHz"
                          }
                        ],
                        "connectedDevices": [],
                        "connectedWifiType": "main",
                        "signalDecibels": -55,
                        "connectionType": "wireless",
                        "speedMbps": "--"
                      }
                    ],
                    "connectedWifiType": "main",
                    "connectionType": "wireless",
                    "speedMbps": "--"
                  }
                ]
              }));
      when(() => mockJnap.send(action: GetWANStatus.instance))
          .thenAnswer((_) async => JNAPSuccess(result: 'OK', output: {
                "macAddress": "80:69:1A:BB:46:CC",
                "detectedWANType": "DHCP",
                "wanStatus": "Connected",
                "wanIPv6Status": "Connecting",
                "wanConnection": {
                  "wanType": "DHCP",
                  "ipAddress": "192.168.1.87",
                  "networkPrefixLength": 24,
                  "gateway": "192.168.1.1",
                  "mtu": 0,
                  "dhcpLeaseMinutes": 120,
                  "dnsServer1": "192.168.1.1"
                },
                "supportedWANTypes": [
                  "DHCP",
                  "Static",
                  "PPPoE",
                  "PPTP",
                  "L2TP",
                  "Bridge"
                ],
                "supportedIPv6WANTypes": ["Automatic", "PPPoE", "Pass-through"],
                "supportedWANCombinations": [
                  {"wanType": "DHCP", "wanIPv6Type": "Automatic"},
                  {"wanType": "Static", "wanIPv6Type": "Automatic"},
                  {"wanType": "PPPoE", "wanIPv6Type": "Automatic"},
                  {"wanType": "L2TP", "wanIPv6Type": "Automatic"},
                  {"wanType": "PPTP", "wanIPv6Type": "Automatic"},
                  {"wanType": "Bridge", "wanIPv6Type": "Automatic"},
                  {"wanType": "DHCP", "wanIPv6Type": "Pass-through"},
                  {"wanType": "PPPoE", "wanIPv6Type": "PPPoE"}
                ]
              }));

      // Wait for the polling provider to be ready
      await container.read(pollingProvider.future);

      // Act
      await container.read(deviceManagerProvider.notifier).fetch();

      // Assert
      final state = container.read(deviceManagerProvider);
      expect(state.deviceList.length, 1);
      expect(state.deviceList.first.deviceID,
          '095aca62-3759-4249-88aa-80691a13161a');
      expect(state.wanStatus?.wanStatus, 'Connected');
      expect(state.lastUpdateTime, 12345);
    });

    test('deleteDevices calls transaction and updates state', () async {
      // Arrange
      final device1 = LinksysDevice.fromMap({
        "connections": [
          {
            "macAddress": "80:69:1A:13:16:1A",
            "ipAddress": "10.110.1.1",
            "ipv6Address": null,
            "parentDeviceID": null,
            "isGuest": null
          }
        ],
        "properties": [],
        "unit": {
          "serialNumber": "59A10M23D00062",
          "firmwareVersion": "1.0.12.216221",
          "firmwareDate": "2024-09-30T07:39:28Z",
          "operatingSystem": null
        },
        "deviceID": "095aca62-3759-4249-88aa-80691a13161a",
        "maxAllowedProperties": 16,
        "model": {
          "deviceType": "Infrastructure",
          "manufacturer": "Linksys",
          "modelNumber": "MBE70",
          "hardwareVersion": "1",
          "modelDescription": null
        },
        "isAuthority": true,
        "lastChangeRevision": 298,
        "friendlyName": "Linksys00062",
        "knownInterfaces": [
          {
            "macAddress": "80:69:1A:13:16:1A",
            "interfaceType": "Wired",
            "band": null
          }
        ],
        "nodeType": "Master",
        "connectedDevices": [
          {
            "connections": [
              {
                "macAddress": "E2:56:F2:73:C2:38",
                "ipAddress": "10.110.1.209",
                "ipv6Address": null,
                "parentDeviceID": "095aca62-3759-4249-88aa-80691a13161a",
                "isGuest": null
              }
            ],
            "properties": [],
            "unit": {
              "serialNumber": null,
              "firmwareVersion": null,
              "firmwareDate": null,
              "operatingSystem": "Android"
            },
            "deviceID": "1ac7a1f2-5e29-4881-946b-c3d7ec3ecadd",
            "maxAllowedProperties": 16,
            "model": {
              "deviceType": "Mobile",
              "manufacturer": null,
              "modelNumber": null,
              "hardwareVersion": null,
              "modelDescription": null
            },
            "isAuthority": false,
            "lastChangeRevision": 332,
            "friendlyName": "Pixel-4a",
            "knownInterfaces": [
              {
                "macAddress": "E2:56:F2:73:C2:38",
                "interfaceType": "Wireless",
                "band": "5GHz"
              }
            ],
            "connectedDevices": [],
            "connectedWifiType": "main",
            "signalDecibels": -84,
            "connectionType": "wireless",
            "speedMbps": "--"
          },
          {
            "connections": [
              {
                "macAddress": "A4:83:E7:11:8A:19",
                "ipAddress": "10.110.1.144",
                "ipv6Address": null,
                "parentDeviceID": "095aca62-3759-4249-88aa-80691a13161a",
                "isGuest": null
              }
            ],
            "properties": [],
            "unit": {
              "serialNumber": null,
              "firmwareVersion": null,
              "firmwareDate": null,
              "operatingSystem": "macOS"
            },
            "deviceID": "a6d4e519-2eda-48a4-8588-3652394397e8",
            "maxAllowedProperties": 16,
            "model": {
              "deviceType": "Computer",
              "manufacturer": "Apple Inc.",
              "modelNumber": "MacBook Pro",
              "hardwareVersion": null,
              "modelDescription": null
            },
            "isAuthority": false,
            "lastChangeRevision": 315,
            "friendlyName": "ASTWP-028279",
            "knownInterfaces": [
              {
                "macAddress": "A4:83:E7:11:8A:19",
                "interfaceType": "Wireless",
                "band": "5GHz"
              }
            ],
            "connectedDevices": [],
            "connectedWifiType": "main",
            "signalDecibels": -55,
            "connectionType": "wireless",
            "speedMbps": "--"
          }
        ],
        "connectedWifiType": "main",
        "connectionType": "wireless",
        "speedMbps": "--"
      });
      container.read(deviceManagerProvider.notifier).state =
          DeviceManagerState(deviceList: [device1]);

      when(() => mockJnap.transaction(
            transactionBuilder: any(named: 'transactionBuilder'),
            overrides: any(named: 'overrides'),
          )).thenAnswer((_) async => JNAPTransactionSuccessWrap(
              result: 'OK',
              data: [
                MapEntry(DeleteDevice.instance,
                    JNAPSuccess(result: 'OK', output: {}))
              ]));

      // Act
      await container
          .read(deviceManagerProvider.notifier)
          .deleteDevices(deviceIds: ['095aca62-3759-4249-88aa-80691a13161a']);

      // Assert
      final state = container.read(deviceManagerProvider);
      expect(state.deviceList, isEmpty);
      verify(() => mockPollingNotifier.forcePolling()).called(1);
    });

    test('deauthClient calls send and forces polling', () async {
      await container
          .read(deviceManagerProvider.notifier)
          .deauthClient(macAddress: 'some-mac');

      verify(() => mockJnap.send(
          action: ClientDeauth.instance,
          data: any(named: 'data'),
          overrides: any(named: 'overrides'))).called(1);
      verify(() => mockPollingNotifier.forcePolling()).called(1);
    });
  });
}
