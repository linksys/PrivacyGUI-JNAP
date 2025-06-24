import 'package:jnap/src/modules/jnap_service.dart';

///   http://linksys.com/jnap/firmwareupdate/FirmwareUpdate
///   http://linksys.com/jnap/firmwareupdate/FirmwareUpdate2
final firmwareUpdateService = JNAPService(
  name: 'FirmwareUpdate',
  path: 'firmwareupdate/',
);
