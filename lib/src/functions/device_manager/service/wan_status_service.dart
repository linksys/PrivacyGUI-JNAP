import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/wan_status.dart';
import 'package:riverpod/riverpod.dart';

class WANStatusService {
  final Ref _ref;

  WANStatusService(this._ref);

  Future<JNAPSuccess> getWANStatus() async {
    return await _ref.read(jnapProvider).send(action: GetWANStatus.instance);
  }

  Future<RouterWANStatus> getWANStatusData() async {
    final getWANStatusData = (await getWANStatus()).output;
    return RouterWANStatus.fromMap(getWANStatusData);
  }
}
