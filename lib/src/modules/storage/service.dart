import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/storage/Storage
/// http://linksys.com/jnap/storage/Storage2
final storageService = JNAPService(
  name: 'Storage',
  path: 'storage/',
);
