
import 'package:jnap/src/modules/vlan_tagging/action.dart';
import 'package:jnap/src/modules/vlan_tagging/service.dart';
import 'package:test/test.dart';

void main() {
  group('VLANTagging actions', () {
    test('GetVLANTaggingSettings has correct properties', () {
      final action = GetVLANTaggingSettings.instance;
      expect(action.name, 'GetVLANTaggingSettings');
      expect(action.service, vlanTaggingService);
      expect(action.command, 'http://linksys.com/jnap/vlantagging/GetVLANTaggingSettings');
    });

    test('SetVLANTaggingSettings has correct properties', () {
      final action = SetVLANTaggingSettings.instance;
      expect(action.name, 'SetVLANTaggingSettings');
      expect(action.service, vlanTaggingService);
      expect(action.command, 'http://linksys.com/jnap/vlantagging/SetVLANTaggingSettings');
    });

    test('GetVLANTaggingSettings handles versioning', () {
      final action = GetVLANTaggingSettings.instance;
      vlanTaggingService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/vlantagging/GetVLANTaggingSettings2');
    });

    test('SetVLANTaggingSettings handles versioning', () {
      final action = SetVLANTaggingSettings.instance;
      vlanTaggingService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/vlantagging/SetVLANTaggingSettings2');
    });
  });
}
