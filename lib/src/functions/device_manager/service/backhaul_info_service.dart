import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';
import 'package:riverpod/riverpod.dart';

class BackhaulInfoService {
  final Ref _ref;

  BackhaulInfoService(this._ref);

  Future<JNAPSuccess> getBackhaulInfo() async {
    return await _ref.read(jnapProvider).send(
          action: GetBackhaulInfo.instance,
        );
  }

  Future<List<BackHaulInfoData>> getBackhaulInfoList() async {
    return List.from(
      (await getBackhaulInfo()).output['backhaulDevices'] ?? [],
    ).map((e) => BackHaulInfoData.fromMap(e)).toList();
  }
}
