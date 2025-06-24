import 'package:jnap/src/modules/jnap_service.dart';

///
///   http://linksys.com/jnap/wirelessap/AirtimeFairness
///
final airtimeFairnessService = JNAPService(
  name: 'AirtimeFairness',
  path: 'wirelessap/',
  supportedServices: [
    JNAPServiceSupported(name: 'isSupportAirtimeFairness', supportedVersion: 1),
  ],
);
