
import 'package:jnap/src/modules/firewall/action.dart';
import 'package:jnap/src/modules/firewall/service.dart';
import 'package:test/test.dart';

void main() {
  group('Firewall actions', () {
    test('GetPortRangeForwardingRules has correct properties', () {
      final action = GetPortRangeForwardingRules.instance;
      expect(action.name, 'GetPortRangeForwardingRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetPortRangeForwardingRules');
    });

    test('GetPortRangeTriggeringRules has correct properties', () {
      final action = GetPortRangeTriggeringRules.instance;
      expect(action.name, 'GetPortRangeTriggeringRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetPortRangeTriggeringRules');
    });

    test('GetSinglePortForwardingRules has correct properties', () {
      final action = GetSinglePortForwardingRules.instance;
      expect(action.name, 'GetSinglePortForwardingRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetSinglePortForwardingRules');
    });

    test('SetPortRangeForwardingRules has correct properties', () {
      final action = SetPortRangeForwardingRules.instance;
      expect(action.name, 'SetPortRangeForwardingRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetPortRangeForwardingRules');
    });

    test('SetPortRangeTriggeringRules has correct properties', () {
      final action = SetPortRangeTriggeringRules.instance;
      expect(action.name, 'SetPortRangeTriggeringRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetPortRangeTriggeringRules');
    });

    test('SetSinglePortForwardingRules has correct properties', () {
      final action = SetSinglePortForwardingRules.instance;
      expect(action.name, 'SetSinglePortForwardingRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetSinglePortForwardingRules');
    });

    test('GetIPv6FirewallRules has correct properties', () {
      final action = GetIPv6FirewallRules.instance;
      expect(action.name, 'GetIPv6FirewallRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetIPv6FirewallRules');
    });

    test('SetIPv6FirewallRules has correct properties', () {
      final action = SetIPv6FirewallRules.instance;
      expect(action.name, 'SetIPv6FirewallRules');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetIPv6FirewallRules');
    });

    test('GetFirewallSettings has correct properties', () {
      final action = GetFirewallSettings.instance;
      expect(action.name, 'GetFirewallSettings');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetFirewallSettings');
    });

    test('SetFirewallSettings has correct properties', () {
      final action = SetFirewallSettings.instance;
      expect(action.name, 'SetFirewallSettings');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetFirewallSettings');
    });

    test('GetDMZSettings has correct properties', () {
      final action = GetDMZSettings.instance;
      expect(action.name, 'GetDMZSettings');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetDMZSettings');
    });

    test('SetDMZSettings has correct properties', () {
      final action = SetDMZSettings.instance;
      expect(action.name, 'SetDMZSettings');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetDMZSettings');
    });

    test('GetALGSettings has correct properties', () {
      final action = GetALGSettings.instance;
      expect(action.name, 'GetALGSettings');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/GetALGSettings');
    });

    test('SetALGSettings has correct properties', () {
      final action = SetALGSettings.instance;
      expect(action.name, 'SetALGSettings');
      expect(action.service, firewallService);
      expect(action.command, 'http://linksys.com/jnap/firewall/SetALGSettings');
    });
  });
}
