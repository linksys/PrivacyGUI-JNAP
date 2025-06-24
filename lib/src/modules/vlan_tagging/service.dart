import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/vlantagging/VLANTagging
/// http://linksys.com/jnap/vlantagging/VLANTagging2
final vlanTaggingService = JNAPService(
  name: 'VLANTagging',
  path: 'vlantagging/',
);
