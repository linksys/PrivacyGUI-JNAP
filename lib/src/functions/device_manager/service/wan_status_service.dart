import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/base_service.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';
import 'package:riverpod/riverpod.dart';

class WANStatusService extends BaseService {
  final Ref _ref;

  WANStatusService(this._ref) : super(_ref, [
    MapEntry(GetWANStatus.instance, {}),
  ]);

  Map<String, dynamic>? getWANStatusFromCache() {
    final cache = fetchCacheData();
    final getWANStatus = (cache?[GetWANStatus.instance])?.output;
    return getWANStatus;
  }

  RouterWANStatus? getWANStatusModel(
    Map<String, dynamic>? data,
  ) {
    return data != null ? RouterWANStatus.fromMap(data) : null;
  }
}
