import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/motionsensing/MotionSensing
/// http://linksys.com/jnap/motionsensing/MotionSensing2
final motionSensingService = JNAPService(
  name: 'MotionSensing',
  path: 'motionsensing/',
);
