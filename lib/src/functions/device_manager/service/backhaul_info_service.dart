import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/base_service.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:riverpod/riverpod.dart';

class BackhaulInfoService extends BaseService {
  final Ref _ref;

  BackhaulInfoService(this._ref)
      : super(_ref, [
          MapEntry(GetBackhaulInfo.instance, {}),
        ]);

  Map<String, dynamic>? getBackhaulInfoFromCache() {
    final cache = fetchCacheData();
    final getBackhaulInfo = (cache?[GetBackhaulInfo.instance])?.output;
    return getBackhaulInfo;
  }

  List<BackHaulInfoData> getBackhaulInfoList() {
    return List.from(
      getBackhaulInfoFromCache()?['backhaulDevices'] ?? [],
    ).map((e) => BackHaulInfoData.fromMap(e)).toList();
  }
}
