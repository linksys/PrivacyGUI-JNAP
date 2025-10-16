import 'package:collection/collection.dart';
import 'package:jnap/src/functions/device_manager/device_manager_provider.dart';
import 'package:jnap/src/functions/device_manager/devices_extensions.dart';
import 'package:riverpod/riverpod.dart';
import 'package:jnap/src/functions/device_manager/service/radio_info_service.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/functions/wifi_status/wifi_status_service.dart';
import 'package:jnap/src/functions/wifi_status/wifi_status_state.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:jnap/src/utilties/wifi_credential.dart';

final wifiStatusServiceProvider = Provider<WifiStatusService>((ref) {
  return WifiStatusService(ref.read(jnapProvider));
});

final wifiStatusProvider =
    NotifierProvider<WifiStatusNotifier, List<WifiStatusState>>(
  () => WifiStatusNotifier(),
);

class WifiStatusNotifier extends Notifier<List<WifiStatusState>> {
  @override
  List<WifiStatusState> build() => const [];

  Future<void> fetch() async {
    // Fetch device data first
    await ref.read(deviceManagerProvider.notifier).fetch();
    final radioInfoService = RadioInfoService(ref);
    final wifiStatusService = ref.read(wifiStatusServiceProvider);

    final getRadioInfoData = await radioInfoService.getRadioInfo();
    final guestSettings = await radioInfoService.getGuestRadioSettingsData();
    final portConnections = await wifiStatusService.getPortConnections();

    final deviceManager = ref.read(deviceManagerProvider);
    // Convert the raw radio data into a List of RouterRadio models
    final radioList = List.from(getRadioInfoData.output['radios'] ?? [])
        .map((e) => RouterRadio.fromMap(e))
        .toList();
    // Check if any Wifi can be disabled (at least one Wifi must be enabled)
    final isMoreThanOneEnabled =
        radioList.where((e) => (e.settings.isEnabled)).length > 1;
    final canBeDisabled =
        isMoreThanOneEnabled || portConnections.lanPortConnections.isNotEmpty;
    // Group the 'radioList' by the Wi-Fi band (e.g., 2.4GHz, 5GHz)
    // Create a map structure where the key is the band and the value is a list of all radios belonging to that band
    final wifiList = radioList
        .groupFoldBy<String, List<RouterRadio>>(
            // The current way is commonly used to separate the configuration for different frequency bands.
            (element) =>
                ////element.settings.ssid + (element.settings.wpaPersonalSettings?.passphrase ?? ''),
                element.band,
            // It accumulates the radios into a list for each group (band)
            (previous, element) => [...(previous ?? []), element])
        // Convert the resulting map (Map<String, List<RouterRadio>>) into an Iterable of MapEntry
        .entries
        // Map each MapEntry to a WifiStatusState object
        .map((entry) {
      final radio = entry.value.first;
      final ssid = radio.settings.ssid;
      final password = radio.settings.wpaPersonalSettings?.passphrase ?? '';
      final securityType = _securityTypeFrom(radio.settings.security);
      final qrData = WiFiCredential(
        ssid: ssid,
        password: password,
        type: securityType,
        isHidden: !radio.settings.broadcastSSID,
      ).generate();
      final deviceCount = deviceManager.mainWifiDevices
          .where((device) {
            final currentDeviceBand = ref
                .read(deviceManagerProvider.notifier)
                .getBandConnectedBy(device);
            return device.nodeType == null &&
                device.isOnline() &&
                currentDeviceBand == entry.key;
          })
          .length
          .toString();

      return WifiStatusState(
        band: entry.key,
        isGuest: false,
        isEnabled: radio.settings.isEnabled,
        deviceCount: deviceCount,
        ssid: ssid,
        password: password,
        radios: entry.value.map((e) => e.radioID).toList(),
        canBeDisabled: canBeDisabled,
        qrData: qrData,
      );
    });

    final guestWifiList = <WifiStatusState>[];
    if (guestSettings != null) {
      final guestRadio = guestSettings.radios.first;
      final ssid = guestRadio.guestSSID;
      final password =
          guestRadio.guestWPAPassphrase ?? guestRadio.guestPassword ?? '';
      final deviceCount = deviceManager.guestWifiDevices
          .where((device) => device.isOnline())
          .length
          .toString();

      final qrData = WiFiCredential(
        ssid: ssid,
        password: password,
        type: SecurityType.wpa,
      ).generate();
      guestWifiList.add(WifiStatusState(
        band: '',
        isGuest: true,
        isEnabled: guestSettings.isGuestNetworkEnabled,
        deviceCount: deviceCount,
        ssid: ssid,
        password: password,
        radios: guestSettings.radios.map((e) => e.radioID).toList(),
        canBeDisabled: canBeDisabled,
        qrData: qrData,
      ));
    }
    state = List.unmodifiable([...wifiList, ...guestWifiList]);
  }

  SecurityType _securityTypeFrom(String security) {
    final normalized = security.toLowerCase();
    if (normalized.contains('wpa')) {
      return SecurityType.wpa;
    }
    if (normalized.contains('wep')) {
      return SecurityType.wep;
    }
    return SecurityType.none;
  }
}
