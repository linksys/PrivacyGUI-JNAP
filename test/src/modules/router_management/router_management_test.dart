
import 'package:jnap/src/modules/router_management/action.dart';
import 'package:jnap/src/modules/router_management/service.dart';
import 'package:test/test.dart';

void main() {
  group('RouterManagement actions', () {
    test('GetManagementSettings has correct properties', () {
      final action = GetManagementSettings.instance;
      expect(action.name, 'GetManagementSettings');
      expect(action.service, routerManagementService);
      expect(action.command, 'http://linksys.com/jnap/routermanagement/GetManagementSettings');
    });

    test('SetManagementSettings has correct properties', () {
      final action = SetManagementSettings.instance;
      expect(action.name, 'SetManagementSettings');
      expect(action.service, routerManagementService);
      expect(action.command, 'http://linksys.com/jnap/routermanagement/SetManagementSettings');
    });

    test('GetManagementSettings handles versioning', () {
      final action = GetManagementSettings.instance;
      routerManagementService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/routermanagement/GetManagementSettings2');
    });

    test('SetManagementSettings handles versioning', () {
      final action = SetManagementSettings.instance;
      routerManagementService.updateVersion(2);
      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/routermanagement/SetManagementSettings2');
    });
  });
}
