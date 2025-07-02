import 'package:jnap/src/modules/jnap_service.dart';

///   http://linksys.com/jnap/core/Core
///   http://linksys.com/jnap/core/Core2
///   http://linksys.com/jnap/core/Core3
///   http://linksys.com/jnap/core/Core4
///   http://linksys.com/jnap/core/Core5
///   http://linksys.com/jnap/core/Core6
///   http://linksys.com/jnap/core/Core7
///   http://linksys.com/jnap/core/Core8
///   http://linksys.com/jnap/core/Core9
///
/// Service supported
/// isSupportAdminPasswordAuthStatus -> core7
/// isSupportChildReboot -> core8
/// isSupportChildFactoryReset -> core9
final coreService = JNAPService(
  name: 'Core',
  path: 'core/',
  supportedServices: [
    JNAPServiceSupported(
        name: 'AdminPasswordAuthStatus', supportedVersion: 7),
    JNAPServiceSupported(name: 'ChildReboot', supportedVersion: 8),
    JNAPServiceSupported(name: 'ChildFactoryReset', supportedVersion: 9),
  ],
)..updateVersion(1); // Core version should be at least 1
