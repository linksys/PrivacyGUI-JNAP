import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/wirelessscheduler/WirelessScheduler
/// http://linksys.com/jnap/wirelessscheduler/WirelessScheduler2
final wirelessSchedulerService = JNAPService(
  name: 'WirelessScheduler',
  path: 'wirelessscheduler/',
);
