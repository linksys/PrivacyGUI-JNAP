import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/wirelessap/WirelessAP
/// http://linksys.com/jnap/wirelessap/WirelessAP2
/// http://linksys.com/jnap/wirelessap/WirelessAP3
/// http://linksys.com/jnap/wirelessap/WirelessAP4
/// http://linksys.com/jnap/wirelessap/WirelessAP5
final wirelessAPService = JNAPService(
  name: 'WirelessAP',
  path: 'wirelessap/',
  supportedServices: [
    JNAPServiceSupported(name: 'ClientDeauth', supportedVersion: 5),
  ],
);
