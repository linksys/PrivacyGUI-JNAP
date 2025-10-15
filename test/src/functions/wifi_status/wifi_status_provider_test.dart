import 'package:jnap/jnap.dart';
import 'package:jnap/models.dart';
import 'package:jnap/src/functions/device_manager/device_manager_provider.dart';
import 'package:jnap/src/functions/wifi_status/wifi_status_provider.dart';
import 'package:jnap/src/functions/wifi_status/wifi_status_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockJnap extends Mock implements Jnap {}

class MockWifiStatusService extends Mock implements WifiStatusService {}

class FakeJnapAction extends Fake implements JNAPAction {}

class TestDeviceManagerNotifier extends DeviceManagerNotifier {
  TestDeviceManagerNotifier(this._initialState, this._bandByDeviceId);

  final DeviceManagerState _initialState;
  final Map<String, String> _bandByDeviceId;

  @override
  DeviceManagerState build() => _initialState;

  @override
  String getBandConnectedBy(LinksysDevice device) {
    return _bandByDeviceId[device.deviceID] ?? '';
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeJnapAction());
  });

  group('wifiStatusProvider', () {
    late MockJnap mockJnap;
    late MockWifiStatusService mockWifiStatusService;
    ProviderContainer? container;

    setUp(() {
      mockJnap = MockJnap();
      mockWifiStatusService = MockWifiStatusService();
    });

    tearDown(() {
      container?.dispose();
    });

    test('fetch aggregates radios, devices, and guest network data', () async {
      final radio24 = RouterRadio(
        radioID: 'RADIO_2.4GHz',
        physicalRadioID: 'ath0',
        bssid: 'AA:AA:AA:AA:AA:AA',
        band: '2.4GHz',
        supportedModes: const ['mode'],
        defaultMixedMode: 'mode',
        supportedChannelsForChannelWidths: const [
          SupportedChannelsForChannelWidths(
            channelWidth: 'Auto',
            channels: [1, 6, 11],
          ),
        ],
        supportedSecurityTypes: const ['WPA2-Personal'],
        maxRadiusSharedKeyLength: 64,
        settings: const RouterRadioSettings(
          isEnabled: true,
          mode: 'mode',
          ssid: 'Home24',
          broadcastSSID: true,
          channelWidth: 'Auto',
          channel: 1,
          security: 'WPA2-Personal',
          wpaPersonalSettings: WpaPersonalSettings(passphrase: 'pass24'),
        ),
      );
      final radio5 = RouterRadio(
        radioID: 'RADIO_5GHz',
        physicalRadioID: 'ath1',
        bssid: 'BB:BB:BB:BB:BB:BB',
        band: '5GHz',
        supportedModes: const ['mode'],
        defaultMixedMode: 'mode',
        supportedChannelsForChannelWidths: const [
          SupportedChannelsForChannelWidths(
            channelWidth: 'Auto',
            channels: [36, 40],
          ),
        ],
        supportedSecurityTypes: const ['None', 'WPA2-Personal'],
        maxRadiusSharedKeyLength: 64,
        settings: const RouterRadioSettings(
          isEnabled: true,
          mode: 'mode',
          ssid: 'Home5',
          broadcastSSID: false,
          channelWidth: 'Auto',
          channel: 36,
          security: 'None',
        ),
      );
      when(() => mockJnap.send(action: GetRadioInfo.instance)).thenAnswer(
        (_) async => JNAPSuccess(
          result: 'OK',
          output: {
            'radios': [
              radio24.toMap(),
              radio5.toMap(),
            ],
          },
        ),
      );
      final guestSettings = GuestRadioSettingsData(
        isGuestNetworkACaptivePortal: false,
        isGuestNetworkEnabled: true,
        radios: const [
          GuestRadioInfo(
            radioID: 'RADIO_2.4GHz',
            isEnabled: true,
            broadcastGuestSSID: true,
            guestSSID: 'GuestWifi',
            guestWPAPassphrase: 'guestPass',
          ),
        ],
      );
      when(() => mockJnap.send(action: GetGuestRadioSettings.instance))
          .thenAnswer(
        (_) async => JNAPSuccess(
          result: 'OK',
          output: guestSettings.toMap(),
        ),
      );
      when(() => mockWifiStatusService.getPortConnections()).thenAnswer(
        (_) async => const RouterEthernetPortConnectionsData(
          wanPortConnection: 'WAN',
          lanPortConnections: ['LAN1'],
        ),
      );

      final main24 = _buildDevice(
        id: 'main-24',
        type: WifiConnectionType.main,
      );
      final main5 = _buildDevice(
        id: 'main-5',
        type: WifiConnectionType.main,
      );
      final guestDevice = _buildDevice(
        id: 'guest-1',
        type: WifiConnectionType.guest,
      );

      final initialState = DeviceManagerState(
        deviceList: [main24, main5, guestDevice],
      );
      final bandByDevice = {
        'main-24': '2.4GHz',
        'main-5': '5GHz',
      };

      container = ProviderContainer(
        overrides: [
          jnapProvider.overrideWithValue(mockJnap),
          wifiStatusServiceProvider.overrideWithValue(mockWifiStatusService),
          deviceManagerProvider.overrideWith(
            () => TestDeviceManagerNotifier(initialState, bandByDevice),
          ),
        ],
      );

      final notifier = container!.read(wifiStatusProvider.notifier);

      await notifier.fetch();

      final states = container!.read(wifiStatusProvider);
      expect(states, hasLength(3));

      final band24 = states.firstWhere((s) => s.band == '2.4GHz');
      expect(band24.isGuest, isFalse);
      expect(band24.deviceCount, '1');
      expect(band24.ssid, 'Home24');
      expect(band24.password, 'pass24');
      expect(band24.radios, ['RADIO_2.4GHz']);
      expect(band24.canBeDisabled, isTrue);
      expect(band24.qrData,
          'WIFI:S:Home24;P:pass24;T:WPA;H:false;;'); // WPA security

      final band5 = states.firstWhere((s) => s.band == '5GHz');
      expect(band5.deviceCount, '1');
      expect(band5.password, isEmpty);
      expect(band5.qrData,
          'WIFI:S:Home5;P:;T:NONE;H:true;;'); // Hidden SSID converts to H:true

      final guest = states.singleWhere((s) => s.isGuest);
      expect(guest.deviceCount, '1');
      expect(guest.ssid, 'GuestWifi');
      expect(guest.password, 'guestPass');
      expect(guest.radios, ['RADIO_2.4GHz']);

      verify(() => mockJnap.send(action: GetRadioInfo.instance)).called(1);
      verify(() => mockJnap.send(action: GetGuestRadioSettings.instance))
          .called(1);
      verify(() => mockWifiStatusService.getPortConnections()).called(1);
    });
  });
}

LinksysDevice _buildDevice({
  required String id,
  required WifiConnectionType type,
}) {
  return LinksysDevice(
    connections: const [
      RawDeviceConnection(macAddress: 'AA:BB:CC:DD:EE:FF'),
    ],
    properties: const <RawDeviceProperty>[],
    unit: const RawDeviceUnit(),
    deviceID: id,
    maxAllowedProperties: 0,
    model: const RawDeviceModel(deviceType: 'Device'),
    isAuthority: false,
    lastChangeRevision: 0,
    knownInterfaces: const [
      RawDeviceKnownInterface(
        macAddress: 'AA:BB:CC:DD:EE:FF',
        interfaceType: 'Wireless',
      ),
    ],
    nodeType: null,
    connectedWifiType: type,
    connectionType: 'Wireless',
  );
}
