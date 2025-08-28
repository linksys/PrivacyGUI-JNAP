import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/firewall_settings.dart';

void main() {
  group('FirewallSettings', () {
    const firewallSettings = FirewallSettings(
      blockAnonymousRequests: true,
      blockIDENT: true,
      blockIPSec: true,
      blockL2TP: true,
      blockMulticast: true,
      blockNATRedirection: true,
      blockPPTP: true,
      isIPv4FirewallEnabled: true,
      isIPv6FirewallEnabled: true,
    );

    final Map<String, dynamic> firewallSettingsMap = {
      'blockAnonymousRequests': true,
      'blockIDENT': true,
      'blockIPSec': true,
      'blockL2TP': true,
      'blockMulticast': true,
      'blockNATRedirection': true,
      'blockPPTP': true,
      'isIPv4FirewallEnabled': true,
      'isIPv6FirewallEnabled': true,
    };

    test('toMap returns a valid map', () {
      expect(firewallSettings.toMap(), firewallSettingsMap);
    });

    test('fromMap creates a valid object', () {
      expect(FirewallSettings.fromMap(firewallSettingsMap), firewallSettings);
    });

    test('toJson returns a valid JSON string', () {
      expect(firewallSettings.toJson(), json.encode(firewallSettingsMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(FirewallSettings.fromJson(json.encode(firewallSettingsMap)), firewallSettings);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSettings = firewallSettings.copyWith(
        blockAnonymousRequests: false,
        isIPv4FirewallEnabled: false,
      );
      expect(updatedSettings.blockAnonymousRequests, false);
      expect(updatedSettings.isIPv4FirewallEnabled, false);
      expect(updatedSettings.blockIDENT, firewallSettings.blockIDENT);
    });

    test('props are correct', () {
      final settings1 = FirewallSettings(
        blockAnonymousRequests: true,
        blockIDENT: true,
        blockIPSec: true,
        blockL2TP: true,
        blockMulticast: true,
        blockNATRedirection: true,
        blockPPTP: true,
        isIPv4FirewallEnabled: true,
        isIPv6FirewallEnabled: true,
      );
      final settings2 = FirewallSettings(
        blockAnonymousRequests: true,
        blockIDENT: true,
        blockIPSec: true,
        blockL2TP: true,
        blockMulticast: true,
        blockNATRedirection: true,
        blockPPTP: true,
        isIPv4FirewallEnabled: true,
        isIPv6FirewallEnabled: true,
      );
      final settings3 = FirewallSettings(
        blockAnonymousRequests: false,
        blockIDENT: false,
        blockIPSec: false,
        blockL2TP: false,
        blockMulticast: false,
        blockNATRedirection: false,
        blockPPTP: false,
        isIPv4FirewallEnabled: false,
        isIPv6FirewallEnabled: false,
      );

      expect(settings1, settings2);
      expect(settings1.props, settings2.props);
      expect(settings1 == settings3, false);
      expect(settings1.props == settings3.props, false);
    });
  });
}
