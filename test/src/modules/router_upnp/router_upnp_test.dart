
import 'package:jnap/src/modules/router_upnp/action.dart';
import 'package:jnap/src/modules/router_upnp/service.dart';
import 'package:test/test.dart';

void main() {
  group('RouterUPnP actions', () {
    test('GetUPnPSettings has correct properties', () {
      final action = GetUPnPSettings.instance;
      expect(action.name, 'GetUPnPSettings');
      expect(action.service, routerUPnPService);
      expect(action.command, 'http://linksys.com/jnap/routerupnp/GetUPnPSettings');
    });

    test('SetUPnPSettings has correct properties', () {
      final action = SetUPnPSettings.instance;
      expect(action.name, 'SetUPnPSettings');
      expect(action.service, routerUPnPService);
      expect(action.command, 'http://linksys.com/jnap/routerupnp/SetUPnPSettings');
    });
  });
}
