import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/macfilter/MACFilter
/// http://linksys.com/jnap/macfilter/MACFilter2
final macFilterService = JNAPService(
  name: 'MACFilter',
  path: 'macfilter/',
  supportedServices: [
    JNAPServiceSupported(name: 'GetSTABSSID', supportedVersion: 2),
  ],
);
