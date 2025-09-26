import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/wan_settings.dart';

void main() {
  group('PortTaggingSettings', () {
    const portTaggingSettings = PortTaggingSettings(
      vlanID: 100,
      vlanPriority: 5,
      vlanStatus: 'Tagged',
    );

    final Map<String, dynamic> portTaggingSettingsMap = {
      'vlanID': 100,
      'vlanPriority': 5,
      'vlanStatus': 'Tagged',
    };

    test('toMap returns a valid map', () {
      expect(portTaggingSettings.toMap(), portTaggingSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(PortTaggingSettings.fromMap(portTaggingSettingsMap),
          portTaggingSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(portTaggingSettings.toJson(), json.encode(portTaggingSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PortTaggingSettings.fromJson(json.encode(portTaggingSettingsMap)),
          portTaggingSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = portTaggingSettings.copyWith(
        vlanID: 101,
      );
      expect(updatedSettings.vlanID, 101);
      expect(updatedSettings.vlanPriority, portTaggingSettings.vlanPriority);
    });

    test('props are correct', () {
      final pts1 =
          PortTaggingSettings(vlanID: 1, vlanPriority: 1, vlanStatus: 's1');
      final pts2 =
          PortTaggingSettings(vlanID: 1, vlanPriority: 1, vlanStatus: 's1');
      final pts3 =
          PortTaggingSettings(vlanID: 2, vlanPriority: 2, vlanStatus: 's2');
      expect(pts1, pts2);
      expect(pts1.props, pts2.props);
      expect(pts1 == pts3, false);
      expect(pts1.props == pts3.props, false);
    });
  });

  group('SinglePortVLANTaggingSettings', () {
    const portTaggingSettings = PortTaggingSettings(
      vlanID: 100,
      vlanPriority: 5,
      vlanStatus: 'Tagged',
    );

    const singlePortVLANTaggingSettings = SinglePortVLANTaggingSettings(
      isEnabled: true,
      vlanTaggingSettings: portTaggingSettings,
      vlanLowerLimit: 1,
      vlanUpperLimit: 4094,
    );

    final Map<String, dynamic> singlePortVLANTaggingSettingsMap = {
      'isEnabled': true,
      'vlanTaggingSettings': portTaggingSettings.toMap(),
      'vlanLowerLimit': 1,
      'vlanUpperLimit': 4094,
    };

    test('toMap returns a valid map', () {
      expect(singlePortVLANTaggingSettings.toMap(),
          singlePortVLANTaggingSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(
          SinglePortVLANTaggingSettings.fromMap(
              singlePortVLANTaggingSettingsMap),
          singlePortVLANTaggingSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(singlePortVLANTaggingSettings.toJson(),
          json.encode(singlePortVLANTaggingSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(
          SinglePortVLANTaggingSettings.fromJson(
              json.encode(singlePortVLANTaggingSettingsMap)),
          singlePortVLANTaggingSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = singlePortVLANTaggingSettings.copyWith(
        isEnabled: false,
      );
      expect(updatedSettings.isEnabled, false);
      expect(updatedSettings.vlanLowerLimit,
          singlePortVLANTaggingSettings.vlanLowerLimit);
    });

    test('props are correct', () {
      final spvts1 = SinglePortVLANTaggingSettings(
          isEnabled: true,
          vlanTaggingSettings: portTaggingSettings,
          vlanLowerLimit: 1,
          vlanUpperLimit: 2);
      final spvts2 = SinglePortVLANTaggingSettings(
          isEnabled: true,
          vlanTaggingSettings: portTaggingSettings,
          vlanLowerLimit: 1,
          vlanUpperLimit: 2);
      final spvts3 = SinglePortVLANTaggingSettings(
          isEnabled: false,
          vlanTaggingSettings: null,
          vlanLowerLimit: 3,
          vlanUpperLimit: 4);
      expect(spvts1, spvts2);
      expect(spvts1.props, spvts2.props);
      expect(spvts1 == spvts3, false);
      expect(spvts1.props == spvts3.props, false);
    });
  });

  group('StaticSettings', () {
    const staticSettings = StaticSettings(
      ipAddress: '192.168.1.1',
      networkPrefixLength: 24,
      gateway: '192.168.1.254',
      dnsServer1: '8.8.8.8',
      dnsServer2: '8.8.4.4',
      dnsServer3: '1.1.1.1',
      domainName: 'example.com',
    );

    final Map<String, dynamic> staticSettingsMap = {
      'ipAddress': '192.168.1.1',
      'networkPrefixLength': 24,
      'gateway': '192.168.1.254',
      'dnsServer1': '8.8.8.8',
      'dnsServer2': '8.8.4.4',
      'dnsServer3': '1.1.1.1',
      'domainName': 'example.com',
    };

    test('toMap returns a valid map', () {
      expect(staticSettings.toMap(), staticSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(StaticSettings.fromMap(staticSettingsMap), staticSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(staticSettings.toJson(), json.encode(staticSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(StaticSettings.fromJson(json.encode(staticSettingsMap)),
          staticSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = staticSettings.copyWith(
        ipAddress: '192.168.1.2',
      );
      expect(updatedSettings.ipAddress, '192.168.1.2');
      expect(updatedSettings.networkPrefixLength,
          staticSettings.networkPrefixLength);
    });

    test('props are correct', () {
      final ss1 = StaticSettings(
          ipAddress: 'ip1',
          networkPrefixLength: 1,
          gateway: 'g1',
          dnsServer1: 'd1');
      final ss2 = StaticSettings(
          ipAddress: 'ip1',
          networkPrefixLength: 1,
          gateway: 'g1',
          dnsServer1: 'd1');
      final ss3 = StaticSettings(
          ipAddress: 'ip2',
          networkPrefixLength: 2,
          gateway: 'g2',
          dnsServer1: 'd2');
      expect(ss1, ss2);
      expect(ss1.props, ss2.props);
      expect(ss1 == ss3, false);
      expect(ss1.props == ss3.props, false);
    });
  });

  group('PPPoESettings', () {
    const pppoeSettings = PPPoESettings(
      username: 'user',
      password: 'pass',
      serviceName: 'service',
      behavior: 'KeepAlive',
      maxIdleMinutes: 60,
      reconnectAfterSeconds: 300,
    );

    final Map<String, dynamic> pppoeSettingsMap = {
      'username': 'user',
      'password': 'pass',
      'serviceName': 'service',
      'behavior': 'KeepAlive',
      'maxIdleMinutes': 60,
      'reconnectAfterSeconds': 300,
    };

    test('toMap returns a valid map', () {
      expect(pppoeSettings.toMap(), pppoeSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(PPPoESettings.fromMap(pppoeSettingsMap), pppoeSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(pppoeSettings.toJson(), json.encode(pppoeSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(
          PPPoESettings.fromJson(json.encode(pppoeSettingsMap)), pppoeSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = pppoeSettings.copyWith(
        username: 'newuser',
      );
      expect(updatedSettings.username, 'newuser');
      expect(updatedSettings.password, pppoeSettings.password);
    });

    test('props are correct', () {
      final pps1 = PPPoESettings(
          username: 'u1',
          password: 'p1',
          serviceName: 's1',
          behavior: 'b1',
          maxIdleMinutes: 1,
          reconnectAfterSeconds: 2);
      final pps2 = PPPoESettings(
          username: 'u1',
          password: 'p1',
          serviceName: 's1',
          behavior: 'b1',
          maxIdleMinutes: 1,
          reconnectAfterSeconds: 2);
      final pps3 = PPPoESettings(
          username: 'u2',
          password: 'p2',
          serviceName: 's2',
          behavior: 'b2',
          maxIdleMinutes: 3,
          reconnectAfterSeconds: 4);
      expect(pps1, pps2);
      expect(pps1.props, pps2.props);
      expect(pps1 == pps3, false);
      expect(pps1.props == pps3.props, false);
    });
  });

  group('TPSettings', () {
    const staticSettings = StaticSettings(
      ipAddress: '192.168.1.1',
      networkPrefixLength: 24,
      gateway: '192.168.1.254',
      dnsServer1: '8.8.8.8',
    );

    const tpSettings = TPSettings(
      useStaticSettings: true,
      staticSettings: staticSettings,
      server: 'server.com',
      username: 'user',
      password: 'pass',
      behavior: 'ConnectOnDemand',
      maxIdleMinutes: 30,
      reconnectAfterSeconds: 600,
    );

    final Map<String, dynamic> tpSettingsMap = {
      'useStaticSettings': true,
      'staticSettings': staticSettings.toMap(),
      'server': 'server.com',
      'username': 'user',
      'password': 'pass',
      'behavior': 'ConnectOnDemand',
      'maxIdleMinutes': 30,
      'reconnectAfterSeconds': 600,
    };

    test('toMap returns a valid map', () {
      expect(tpSettings.toMap(), tpSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(TPSettings.fromMap(tpSettingsMap), tpSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(tpSettings.toJson(), json.encode(tpSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(TPSettings.fromJson(json.encode(tpSettingsMap)), tpSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = tpSettings.copyWith(
        server: 'newserver.com',
      );
      expect(updatedSettings.server, 'newserver.com');
      expect(updatedSettings.username, tpSettings.username);
    });

    test('props are correct', () {
      final tps1 = TPSettings(
          useStaticSettings: true,
          server: 's1',
          username: 'u1',
          password: 'p1',
          behavior: 'b1');
      final tps2 = TPSettings(
          useStaticSettings: true,
          server: 's1',
          username: 'u1',
          password: 'p1',
          behavior: 'b1');
      final tps3 = TPSettings(
          useStaticSettings: false,
          server: 's2',
          username: 'u2',
          password: 'p2',
          behavior: 'b2');
      expect(tps1, tps2);
      expect(tps1.props, tps2.props);
      expect(tps1 == tps3, false);
      expect(tps1.props == tps3.props, false);
    });
  });

  group('TelstraSettings', () {
    const telstraSettings = TelstraSettings(
      server: 'telstra.com',
      username: 'telstrauser',
      password: 'telstrapass',
    );

    final Map<String, dynamic> telstraSettingsMap = {
      'server': 'telstra.com',
      'username': 'telstrauser',
      'password': 'telstrapass',
    };

    test('toMap returns a valid map', () {
      expect(telstraSettings.toMap(), telstraSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(TelstraSettings.fromMap(telstraSettingsMap), telstraSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(telstraSettings.toJson(), json.encode(telstraSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(TelstraSettings.fromJson(json.encode(telstraSettingsMap)),
          telstraSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = telstraSettings.copyWith(
        username: 'newtelstrauser',
      );
      expect(updatedSettings.username, 'newtelstrauser');
      expect(updatedSettings.server, telstraSettings.server);
    });

    test('props are correct', () {
      final ts1 = TelstraSettings(server: 's1', username: 'u1', password: 'p1');
      final ts2 = TelstraSettings(server: 's1', username: 'u1', password: 'p1');
      final ts3 = TelstraSettings(server: 's2', username: 'u2', password: 'p2');
      expect(ts1, ts2);
      expect(ts1.props, ts2.props);
      expect(ts1 == ts3, false);
      expect(ts1.props == ts3.props, false);
    });
  });

  group('BridgeSettings', () {
    const staticSettings = StaticSettings(
      ipAddress: '192.168.1.1',
      networkPrefixLength: 24,
      gateway: '192.168.1.254',
      dnsServer1: '8.8.8.8',
    );

    const bridgeSettings = BridgeSettings(
      useStaticSettings: true,
      staticSettings: staticSettings,
    );

    final Map<String, dynamic> bridgeSettingsMap = {
      'useStaticSettings': true,
      'staticSettings': staticSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(bridgeSettings.toMap(), bridgeSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(BridgeSettings.fromMap(bridgeSettingsMap), bridgeSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(bridgeSettings.toJson(), json.encode(bridgeSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(BridgeSettings.fromJson(json.encode(bridgeSettingsMap)),
          bridgeSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = bridgeSettings.copyWith(
        useStaticSettings: false,
      );
      expect(updatedSettings.useStaticSettings, false);
      expect(updatedSettings.staticSettings, bridgeSettings.staticSettings);
    });

    test('props are correct', () {
      final bs1 = BridgeSettings(
          useStaticSettings: true, staticSettings: staticSettings);
      final bs2 = BridgeSettings(
          useStaticSettings: true, staticSettings: staticSettings);
      final bs3 =
          BridgeSettings(useStaticSettings: false, staticSettings: null);
      expect(bs1, bs2);
      expect(bs1.props, bs2.props);
      expect(bs1 == bs3, false);
      expect(bs1.props == bs3.props, false);
    });
  });

  group('AFTRSettings', () {
    const aftrSettings = AFTRSettings(
      aftrURL: 'aftr.example.com',
      afterAddress: '192.0.2.1',
    );

    final Map<String, dynamic> aftrSettingsMap = {
      'aftrURL': 'aftr.example.com',
      'afterAddress': '192.0.2.1',
    };

    test('toMap returns a valid map', () {
      expect(aftrSettings.toMap(), aftrSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(AFTRSettings.fromMap(aftrSettingsMap), aftrSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(aftrSettings.toJson(), json.encode(aftrSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(AFTRSettings.fromJson(json.encode(aftrSettingsMap)), aftrSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = aftrSettings.copyWith(
        aftrURL: 'new.example.com',
      );
      expect(updatedSettings.aftrURL, 'new.example.com');
      expect(updatedSettings.afterAddress, aftrSettings.afterAddress);
    });

    test('props are correct', () {
      final as1 = AFTRSettings(aftrURL: 'u1', afterAddress: 'a1');
      final as2 = AFTRSettings(aftrURL: 'u1', afterAddress: 'a1');
      final as3 = AFTRSettings(aftrURL: 'u2', afterAddress: 'a2');
      expect(as1, as2);
      expect(as1.props, as2.props);
      expect(as1 == as3, false);
      expect(as1.props == as3.props, false);
    });
  });

  group('DSLiteSettings', () {
    const aftrSettings = AFTRSettings(
      aftrURL: 'aftr.example.com',
      afterAddress: '192.0.2.1',
    );

    const dsliteSettings = DSLiteSettings(
      useManualSettings: true,
      manualSettings: aftrSettings,
    );

    final Map<String, dynamic> dsliteSettingsMap = {
      'useManualSettings': true,
      'manualSettings': aftrSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(dsliteSettings.toMap(), dsliteSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(DSLiteSettings.fromMap(dsliteSettingsMap), dsliteSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(dsliteSettings.toJson(), json.encode(dsliteSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(DSLiteSettings.fromJson(json.encode(dsliteSettingsMap)),
          dsliteSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = dsliteSettings.copyWith(
        useManualSettings: false,
      );
      expect(updatedSettings.useManualSettings, false);
      expect(updatedSettings.manualSettings, dsliteSettings.manualSettings);
    });

    test('props are correct', () {
      final dsls1 =
          DSLiteSettings(useManualSettings: true, manualSettings: aftrSettings);
      final dsls2 =
          DSLiteSettings(useManualSettings: true, manualSettings: aftrSettings);
      final dsls3 =
          DSLiteSettings(useManualSettings: false, manualSettings: null);
      expect(dsls1, dsls2);
      expect(dsls1.props, dsls2.props);
      expect(dsls1 == dsls3, false);
      expect(dsls1.props == dsls3.props, false);
    });
  });

  group('WirelessModeSettings', () {
    const wirelessModeSettings = WirelessModeSettings(
      ssid: 'MyWiFi',
      bssid: '00:11:22:33:44:55',
      band: '2.4GHz',
      security: 'WPA2',
      password: 'password',
    );

    final Map<String, dynamic> wirelessModeSettingsMap = {
      'ssid': 'MyWiFi',
      'bssid': '00:11:22:33:44:55',
      'band': '2.4GHz',
      'security': 'WPA2',
      'password': 'password',
    };

    test('toMap returns a valid map', () {
      expect(wirelessModeSettings.toMap(), wirelessModeSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(WirelessModeSettings.fromMap(wirelessModeSettingsMap),
          wirelessModeSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(
          wirelessModeSettings.toJson(), json.encode(wirelessModeSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(
          WirelessModeSettings.fromJson(json.encode(wirelessModeSettingsMap)),
          wirelessModeSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = wirelessModeSettings.copyWith(
        ssid: 'NewWiFi',
      );
      expect(updatedSettings.ssid, 'NewWiFi');
      expect(updatedSettings.band, wirelessModeSettings.band);
    });

    test('props are correct', () {
      final wms1 =
          WirelessModeSettings(ssid: 's1', security: 'sec1', password: 'p1');
      final wms2 =
          WirelessModeSettings(ssid: 's1', security: 'sec1', password: 'p1');
      final wms3 =
          WirelessModeSettings(ssid: 's2', security: 'sec2', password: 'p2');
      expect(wms1, wms2);
      expect(wms1.props, wms2.props);
      expect(wms1 == wms3, false);
      expect(wms1.props == wms3.props, false);
    });
  });

  group('RouterWANSettings', () {
    const pppoeSettings = PPPoESettings(
      username: 'user',
      password: 'pass',
      serviceName: 'service',
      behavior: 'KeepAlive',
      maxIdleMinutes: 60,
      reconnectAfterSeconds: 300,
    );
    const tpSettings = TPSettings(
      useStaticSettings: true,
      server: 'server.com',
      username: 'user',
      password: 'pass',
      behavior: 'ConnectOnDemand',
    );
    const telstraSettings = TelstraSettings(
      server: 'telstra.com',
      username: 'telstrauser',
      password: 'telstrapass',
    );
    const staticSettings = StaticSettings(
      ipAddress: '192.168.1.1',
      networkPrefixLength: 24,
      gateway: '192.168.1.254',
      dnsServer1: '8.8.8.8',
    );
    const bridgeSettings = BridgeSettings(
      useStaticSettings: true,
      staticSettings: staticSettings,
    );
    const aftrSettings = AFTRSettings(
      aftrURL: 'aftr.example.com',
      afterAddress: '192.0.2.1',
    );
    const dsliteSettings = DSLiteSettings(
      useManualSettings: true,
      manualSettings: aftrSettings,
    );
    const wirelessModeSettings = WirelessModeSettings(
      ssid: 'MyWiFi',
      security: 'WPA2',
      password: 'password',
    );
    const portTaggingSettings = PortTaggingSettings(
      vlanID: 100,
      vlanStatus: 'Tagged',
    );
    const wanTaggingSettings = SinglePortVLANTaggingSettings(
      isEnabled: true,
      vlanTaggingSettings: portTaggingSettings,
    );

    const routerWANSettings = RouterWANSettingsData(
      wanType: 'DHCP',
      mtu: 1500,
      pppoeSettings: pppoeSettings,
      tpSettings: tpSettings,
      telstraSettings: telstraSettings,
      staticSettings: staticSettings,
      bridgeSettings: bridgeSettings,
      dsliteSettings: dsliteSettings,
      wirelessModeSettings: wirelessModeSettings,
      domainName: 'home.local',
      wanTaggingSettings: wanTaggingSettings,
    );

    final Map<String, dynamic> routerWANSettingsMap = {
      'wanType': 'DHCP',
      'pppoeSettings': pppoeSettings.toMap(),
      'tpSettings': tpSettings.toMap(),
      'telstraSettings': telstraSettings.toMap(),
      'staticSettings': staticSettings.toMap(),
      'bridgeSettings': bridgeSettings.toMap(),
      'dsliteSettings': dsliteSettings.toMap(),
      'wirelessModeSettings': wirelessModeSettings.toMap(),
      'domainName': 'home.local',
      'mtu': 1500,
      'wanTaggingSettings': wanTaggingSettings.toMap(),
    };

    test('toMap returns a valid map', () {
      expect(routerWANSettings.toMap(), routerWANSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(
          RouterWANSettingsData.fromMap(routerWANSettingsMap), routerWANSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(routerWANSettings.toJson(), json.encode(routerWANSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RouterWANSettingsData.fromJson(json.encode(routerWANSettingsMap)),
          routerWANSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = routerWANSettings.copyWith(
        wanType: 'Static',
        mtu: 1492,
      );
      expect(updatedSettings.wanType, 'Static');
      expect(updatedSettings.mtu, 1492);
      expect(updatedSettings.domainName, routerWANSettings.domainName);
    });

    test('factory dhcp creates correct settings', () {
      final dhcpSettings = RouterWANSettingsData.dhcp(mtu: 1500);
      expect(dhcpSettings.wanType, 'DHCP');
      expect(dhcpSettings.mtu, 1500);
    });

    test('factory pppoe creates correct settings', () {
      final pppoe = RouterWANSettingsData.pppoe(
          mtu: 1492,
          pppoeSettings: pppoeSettings,
          wanTaggingSettings: wanTaggingSettings);
      expect(pppoe.wanType, 'PPPoE');
      expect(pppoe.mtu, 1492);
      expect(pppoe.pppoeSettings, pppoeSettings);
    });

    test('factory pptp creates correct settings', () {
      final pptp = RouterWANSettingsData.pptp(
          mtu: 1400,
          tpSettings: tpSettings,
          wanTaggingSettings: wanTaggingSettings);
      expect(pptp.wanType, 'PPTP');
      expect(pptp.mtu, 1400);
      expect(pptp.tpSettings, tpSettings);
    });

    test('factory l2tp creates correct settings', () {
      final l2tp = RouterWANSettingsData.l2tp(mtu: 1400, tpSettings: tpSettings);
      expect(l2tp.wanType, 'L2TP');
      expect(l2tp.mtu, 1400);
      expect(l2tp.tpSettings, tpSettings);
    });

    test('factory static creates correct settings', () {
      final staticWan = RouterWANSettingsData.static(
          mtu: 1500,
          staticSettings: staticSettings,
          wanTaggingSettings: wanTaggingSettings);
      expect(staticWan.wanType, 'Static');
      expect(staticWan.mtu, 1500);
      expect(staticWan.staticSettings, staticSettings);
    });

    test('factory bridge creates correct settings', () {
      final bridge = RouterWANSettingsData.bridge(bridgeSettings: bridgeSettings);
      expect(bridge.wanType, 'Bridge');
      expect(bridge.mtu, 0);
      expect(bridge.bridgeSettings, bridgeSettings);
    });

    test('props are correct', () {
      final rws1 = RouterWANSettingsData(wanType: 't1', mtu: 1);
      final rws2 = RouterWANSettingsData(wanType: 't1', mtu: 1);
      final rws3 = RouterWANSettingsData(wanType: 't2', mtu: 2);
      expect(rws1, rws2);
      expect(rws1.props, rws2.props);
      expect(rws1 == rws3, false);
      expect(rws1.props == rws3.props, false);
    });
  });
}
