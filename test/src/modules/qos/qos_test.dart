
import 'package:jnap/src/modules/qos/action.dart';
import 'package:jnap/src/modules/qos/service.dart';
import 'package:test/test.dart';

void main() {
  group('QoS actions', () {
    test('GetQoSSettings has correct properties', () {
      final action = GetQoSSettings.instance;
      expect(action.name, 'GetQoSSettings');
      expect(action.service, qosService);
      expect(action.command, 'http://linksys.com/jnap/qos/GetQoSSettings');
    });

    test('GetQoSSettings handles versioning', () {
      final action = GetQoSSettings.instance;
      qosService.updateVersion(3);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/qos/GetQoSSettings2');
    });
  });
}
