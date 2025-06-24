import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/ownednetwork/OwnedNetwork
/// http://linksys.com/jnap/ownednetwork/OwnedNetwork2
/// http://linksys.com/jnap/ownednetwork/OwnedNetwork3
final ownedNetworkService = JNAPService(
  name: 'OwnedNetwork',
  path: 'ownednetwork/',
);
