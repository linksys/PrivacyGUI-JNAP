
import 'package:jnap/src/modules/owned_network/action.dart';
import 'package:jnap/src/modules/owned_network/service.dart';
import 'package:test/test.dart';

void main() {
  group('OwnedNetwork actions', () {
    test('GetOwnedNetworkID has correct properties', () {
      final action = GetOwnedNetworkID.instance;
      expect(action.name, 'GetOwnedNetworkID');
      expect(action.service, ownedNetworkService);
      expect(action.command, 'http://linksys.com/jnap/ownednetwork/GetOwnedNetworkID');
    });

    test('IsOwnedNetwork has correct properties', () {
      final action = IsOwnedNetwork.instance;
      expect(action.name, 'IsOwnedNetwork');
      expect(action.service, ownedNetworkService);
      expect(action.command, 'http://linksys.com/jnap/ownednetwork/IsOwnedNetwork');
    });

    test('SetNetworkOwner has correct properties', () {
      final action = SetNetworkOwner.instance;
      expect(action.name, 'SetNetworkOwner');
      expect(action.service, ownedNetworkService);
      expect(action.command, 'http://linksys.com/jnap/ownednetwork/SetNetworkOwner');
    });
  });
}
