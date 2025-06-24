import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/guestnetwork/GuestNetwork
/// http://linksys.com/jnap/guestnetwork/GuestNetwork2
/// http://linksys.com/jnap/guestnetwork/GuestNetwork3
/// http://linksys.com/jnap/guestnetwork/GuestNetwork4
/// http://linksys.com/jnap/guestnetwork/GuestNetwork5
///
final guestNetworkService = JNAPService(
  name: 'GuestNetwork',
  path: 'guestnetwork/',
);
