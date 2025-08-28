import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';

void main() {
  group('SupportedChannelsForChannelWidths', () {
    const supportedChannels = SupportedChannelsForChannelWidths(
      channelWidth: '20MHz',
      channels: [1, 6, 11],
    );

    final Map<String, dynamic> supportedChannelsMap = {
      'channelWidth': '20MHz',
      'channels': [1, 6, 11],
    };

    test('toMap returns a valid map', () {
      expect(supportedChannels.toMap(), supportedChannelsMap);
    });

    test('fromMap creates a valid object', () {
      expect(SupportedChannelsForChannelWidths.fromMap(supportedChannelsMap), supportedChannels);
    });

    test('toJson returns a valid JSON string', () {
      expect(supportedChannels.toJson(), json.encode(supportedChannelsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SupportedChannelsForChannelWidths.fromJson(json.encode(supportedChannelsMap)), supportedChannels);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedChannels = supportedChannels.copyWith(
        channelWidth: '40MHz',
      );
      expect(updatedChannels.channelWidth, '40MHz');
      expect(updatedChannels.channels, supportedChannels.channels);
    });

    test('props are correct', () {
      final sc1 = SupportedChannelsForChannelWidths(channelWidth: 'w1', channels: [1]);
      final sc2 = SupportedChannelsForChannelWidths(channelWidth: 'w1', channels: [1]);
      final sc3 = SupportedChannelsForChannelWidths(channelWidth: 'w2', channels: [2]);
      expect(sc1, sc2);
      expect(sc1.props, sc2.props);
      expect(sc1 == sc3, false);
      expect(sc1.props == sc3.props, false);
    });
  });

  group('WepSettings', () {
    const wepSettings = WepSettings(
      encryption: 'WEP64',
      key1: 'key1',
      key2: 'key2',
      key3: 'key3',
      key4: 'key4',
      txKey: 1,
    );

    final Map<String, dynamic> wepSettingsMap = {
      'encryption': 'WEP64',
      'key1': 'key1',
      'key2': 'key2',
      'key3': 'key3',
      'key4': 'key4',
      'txKey': 1,
    };

    test('toMap returns a valid map', () {
      expect(wepSettings.toMap(), wepSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(WepSettings.fromMap(wepSettingsMap), wepSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(wepSettings.toJson(), json.encode(wepSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WepSettings.fromJson(json.encode(wepSettingsMap)), wepSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = wepSettings.copyWith(
        encryption: 'WEP128',
      );
      expect(updatedSettings.encryption, 'WEP128');
      expect(updatedSettings.key1, wepSettings.key1);
    });

    test('props are correct', () {
      final ws1 = WepSettings(encryption: 'e1', key1: 'k1', key2: 'k2', key3: 'k3', key4: 'k4', txKey: 1);
      final ws2 = WepSettings(encryption: 'e1', key1: 'k1', key2: 'k2', key3: 'k3', key4: 'k4', txKey: 1);
      final ws3 = WepSettings(encryption: 'e2', key1: 'k5', key2: 'k6', key3: 'k7', key4: 'k8', txKey: 2);
      expect(ws1, ws2);
      expect(ws1.props, ws2.props);
      expect(ws1 == ws3, false);
      expect(ws1.props == ws3.props, false);
    });
  });

  group('WpaPersonalSettings', () {
    const wpaPersonalSettings = WpaPersonalSettings(
      passphrase: 'password123',
    );

    final Map<String, dynamic> wpaPersonalSettingsMap = {
      'passphrase': 'password123',
    };

    test('toMap returns a valid map', () {
      expect(wpaPersonalSettings.toMap(), wpaPersonalSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(WpaPersonalSettings.fromMap(wpaPersonalSettingsMap), wpaPersonalSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(wpaPersonalSettings.toJson(), json.encode(wpaPersonalSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WpaPersonalSettings.fromJson(json.encode(wpaPersonalSettingsMap)), wpaPersonalSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = wpaPersonalSettings.copyWith(
        passphrase: 'newpassword',
      );
      expect(updatedSettings.passphrase, 'newpassword');
    });

    test('props are correct', () {
      final wps1 = WpaPersonalSettings(passphrase: 'p1');
      final wps2 = WpaPersonalSettings(passphrase: 'p1');
      final wps3 = WpaPersonalSettings(passphrase: 'p2');
      expect(wps1, wps2);
      expect(wps1.props, wps2.props);
      expect(wps1 == wps3, false);
      expect(wps1.props == wps3.props, false);
    });
  });

  group('WpaEnterpriseSettings', () {
    const wpaEnterpriseSettings = WpaEnterpriseSettings(
      radiusServer: '192.168.1.1',
      radiusPort: 1812,
      sharedKey: 'sharedkey123',
    );

    final Map<String, dynamic> wpaEnterpriseSettingsMap = {
      'radiusServer': '192.168.1.1',
      'radiusPort': 1812,
      'sharedKey': 'sharedkey123',
    };

    test('toMap returns a valid map', () {
      expect(wpaEnterpriseSettings.toMap(), wpaEnterpriseSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(WpaEnterpriseSettings.fromMap(wpaEnterpriseSettingsMap), wpaEnterpriseSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(wpaEnterpriseSettings.toJson(), json.encode(wpaEnterpriseSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WpaEnterpriseSettings.fromJson(json.encode(wpaEnterpriseSettingsMap)), wpaEnterpriseSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = wpaEnterpriseSettings.copyWith(
        radiusPort: 1813,
      );
      expect(updatedSettings.radiusPort, 1813);
      expect(updatedSettings.radiusServer, wpaEnterpriseSettings.radiusServer);
    });

    test('props are correct', () {
      final wes1 = WpaEnterpriseSettings(radiusServer: 's1', radiusPort: 1, sharedKey: 'k1');
      final wes2 = WpaEnterpriseSettings(radiusServer: 's1', radiusPort: 1, sharedKey: 'k1');
      final wes3 = WpaEnterpriseSettings(radiusServer: 's2', radiusPort: 2, sharedKey: 'k2');
      expect(wes1, wes2);
      expect(wes1.props, wes2.props);
      expect(wes1 == wes3, false);
      expect(wes1.props == wes3.props, false);
    });
  });

  group('RouterRadioSettings', () {
    const wepSettings = WepSettings(
      encryption: 'WEP64',
      key1: 'key1',
      key2: 'key2',
      key3: 'key3',
      key4: 'key4',
      txKey: 1,
    );
    const wpaPersonalSettings = WpaPersonalSettings(
      passphrase: 'password123',
    );
    const wpaEnterpriseSettings = WpaEnterpriseSettings(
      radiusServer: '192.168.1.1',
      radiusPort: 1812,
      sharedKey: 'sharedkey123',
    );

    const routerRadioSettings = RouterRadioSettings(
      isEnabled: true,
      mode: 'Mixed',
      ssid: 'MyWiFi',
      broadcastSSID: true,
      channelWidth: '20MHz',
      channel: 6,
      security: 'WPA2Personal',
      wepSettings: wepSettings,
      wpaPersonalSettings: wpaPersonalSettings,
      wpaEnterpriseSettings: wpaEnterpriseSettings,
    );

    final Map<String, dynamic> routerRadioSettingsMap = {
      'isEnabled': true,
      'mode': 'Mixed',
      'ssid': 'MyWiFi',
      'broadcastSSID': true,
      'channelWidth': '20MHz',
      'channel': 6,
      'security': 'WPA2Personal',
      'wepSettings': wepSettings.toMap(),
      'wpaPersonalSettings': wpaPersonalSettings.toMap(),
      'wpaEnterpriseSettings': wpaEnterpriseSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(routerRadioSettings.toMap(), routerRadioSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(RouterRadioSettings.fromMap(routerRadioSettingsMap), routerRadioSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(routerRadioSettings.toJson(), json.encode(routerRadioSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RouterRadioSettings.fromJson(json.encode(routerRadioSettingsMap)), routerRadioSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = routerRadioSettings.copyWith(
        isEnabled: false,
        ssid: 'NewWiFi',
      );
      expect(updatedSettings.isEnabled, false);
      expect(updatedSettings.ssid, 'NewWiFi');
      expect(updatedSettings.mode, routerRadioSettings.mode);
    });

    test('props are correct', () {
      final rrs1 = RouterRadioSettings(isEnabled: true, mode: 'm1', ssid: 's1', broadcastSSID: true, channelWidth: 'cw1', channel: 1, security: 'sec1');
      final rrs2 = RouterRadioSettings(isEnabled: true, mode: 'm1', ssid: 's1', broadcastSSID: true, channelWidth: 'cw1', channel: 1, security: 'sec1');
      final rrs3 = RouterRadioSettings(isEnabled: false, mode: 'm2', ssid: 's2', broadcastSSID: false, channelWidth: 'cw2', channel: 2, security: 'sec2');
      expect(rrs1, rrs2);
      expect(rrs1.props, rrs2.props);
      expect(rrs1 == rrs3, false);
      expect(rrs1.props == rrs3.props, false);
    });
  });

  group('RouterRadio', () {
    const supportedChannels = SupportedChannelsForChannelWidths(
      channelWidth: '20MHz',
      channels: [1, 6, 11],
    );
    const routerRadioSettings = RouterRadioSettings(
      isEnabled: true,
      mode: 'Mixed',
      ssid: 'MyWiFi',
      broadcastSSID: true,
      channelWidth: '20MHz',
      channel: 6,
      security: 'WPA2Personal',
    );

    const routerRadio = RouterRadio(
      radioID: 'radio1',
      physicalRadioID: 'phy_radio1',
      bssid: '00:11:22:33:44:55',
      band: '2.4GHz',
      supportedModes: ['Mixed', 'NOnly'],
      defaultMixedMode: 'Mixed',
      supportedChannelsForChannelWidths: [supportedChannels],
      supportedSecurityTypes: ['WPA2Personal', 'WPA2Enterprise'],
      maxRadiusSharedKeyLength: 63,
      settings: routerRadioSettings,
    );

    final Map<String, dynamic> routerRadioMap = {
      'radioID': 'radio1',
      'physicalRadioID': 'phy_radio1',
      'bssid': '00:11:22:33:44:55',
      'band': '2.4GHz',
      'supportedModes': ['Mixed', 'NOnly'],
      'defaultMixedMode': 'Mixed',
      'supportedChannelsForChannelWidths': [supportedChannels.toMap()],
      'supportedSecurityTypes': ['WPA2Personal', 'WPA2Enterprise'],
      'maxRADIUSSharedKeyLength': 63,
      'settings': routerRadioSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(routerRadio.toMap(), routerRadioMap);
    });

    test('fromMap creates a valid object', () {
      expect(RouterRadio.fromMap(routerRadioMap), routerRadio);
    });

    test('toJson returns a valid JSON string', () {
      expect(routerRadio.toJson(), json.encode(routerRadioMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RouterRadio.fromJson(json.encode(routerRadioMap)), routerRadio);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedRadio = routerRadio.copyWith(
        band: '5GHz',
        defaultMixedMode: 'AOnly',
      );
      expect(updatedRadio.band, '5GHz');
      expect(updatedRadio.defaultMixedMode, 'AOnly');
      expect(updatedRadio.radioID, routerRadio.radioID);
    });

    test('props are correct', () {
      final rr1 = RouterRadio(radioID: 'r1', physicalRadioID: 'pr1', bssid: 'b1', band: 'band1', supportedModes: ['m1'], supportedChannelsForChannelWidths: [supportedChannels], supportedSecurityTypes: ['s1'], maxRadiusSharedKeyLength: 1, settings: routerRadioSettings);
      final rr2 = RouterRadio(radioID: 'r1', physicalRadioID: 'pr1', bssid: 'b1', band: 'band1', supportedModes: ['m1'], supportedChannelsForChannelWidths: [supportedChannels], supportedSecurityTypes: ['s1'], maxRadiusSharedKeyLength: 1, settings: routerRadioSettings);
      final rr3 = RouterRadio(radioID: 'r2', physicalRadioID: 'pr2', bssid: 'b2', band: 'band2', supportedModes: ['m2'], supportedChannelsForChannelWidths: [], supportedSecurityTypes: [], maxRadiusSharedKeyLength: 2, settings: routerRadioSettings.copyWith(isEnabled: false));
      expect(rr1, rr2);
      expect(rr1.props, rr2.props);
      expect(rr1 == rr3, false);
      expect(rr1.props == rr3.props, false);
    });
  });

  group('GetRadioInfo', () {
    const supportedChannels = SupportedChannelsForChannelWidths(
      channelWidth: '20MHz',
      channels: [1, 6, 11],
    );
    const routerRadioSettings = RouterRadioSettings(
      isEnabled: true,
      mode: 'Mixed',
      ssid: 'MyWiFi',
      broadcastSSID: true,
      channelWidth: '20MHz',
      channel: 6,
      security: 'WPA2Personal',
    );
    const routerRadio = RouterRadio(
      radioID: 'radio1',
      physicalRadioID: 'phy_radio1',
      bssid: '00:11:22:33:44:55',
      band: '2.4GHz',
      supportedModes: ['Mixed', 'NOnly'],
      defaultMixedMode: 'Mixed',
      supportedChannelsForChannelWidths: [supportedChannels],
      supportedSecurityTypes: ['WPA2Personal', 'WPA2Enterprise'],
      maxRadiusSharedKeyLength: 63,
      settings: routerRadioSettings,
    );

    const getRadioInfo = GetRadioInfo(
      isBandSteeringSupported: true,
      radios: [routerRadio],
    );

    final Map<String, dynamic> getRadioInfoMap = {
      'isBandSteeringSupported': true,
      'radios': [routerRadio.toMap()],
    };

    test('toMap returns a valid map', () {
      expect(getRadioInfo.toMap(), getRadioInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(GetRadioInfo.fromMap(getRadioInfoMap), getRadioInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(getRadioInfo.toJson(), json.encode(getRadioInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(GetRadioInfo.fromJson(json.encode(getRadioInfoMap)), getRadioInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = getRadioInfo.copyWith(
        isBandSteeringSupported: false,
      );
      expect(updatedInfo.isBandSteeringSupported, false);
      expect(updatedInfo.radios, getRadioInfo.radios);
    });

    test('props are correct', () {
      final gri1 = GetRadioInfo(isBandSteeringSupported: true, radios: [routerRadio]);
      final gri2 = GetRadioInfo(isBandSteeringSupported: true, radios: [routerRadio]);
      final gri3 = GetRadioInfo(isBandSteeringSupported: false, radios: []);
      expect(gri1, gri2);
      expect(gri1.props, gri2.props);
      expect(gri1 == gri3, false);
      expect(gri1.props == gri3.props, false);
    });
  });
}
