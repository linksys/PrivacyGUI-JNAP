
import 'package:jnap/src/modules/wireless_scheduler/action.dart';
import 'package:jnap/src/modules/wireless_scheduler/service.dart';
import 'package:test/test.dart';

void main() {
  group('WirelessScheduler actions', () {
    test('GetWirelessSchedulerSettings has correct properties', () {
      final action = GetWirelessSchedulerSettings.instance;
      expect(action.name, 'GetWirelessSchedulerSettings');
      expect(action.service, wirelessSchedulerService);
      expect(action.command, 'http://linksys.com/jnap/wirelessscheduler/GetWirelessSchedulerSettings');
    });
  });
}
