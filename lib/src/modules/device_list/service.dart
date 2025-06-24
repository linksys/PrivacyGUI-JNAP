import 'package:jnap/src/modules/jnap_service.dart';

/// http://linksys.com/jnap/devicelist/DeviceList
/// http://linksys.com/jnap/devicelist/DeviceList2
/// http://linksys.com/jnap/devicelist/DeviceList4
/// http://linksys.com/jnap/devicelist/DeviceList5
/// http://linksys.com/jnap/devicelist/DeviceList6
/// http://linksys.com/jnap/devicelist/DeviceList7
///
final deviceListService = JNAPService(
  name: 'DeviceList',
  path: 'devicelist/',
);
