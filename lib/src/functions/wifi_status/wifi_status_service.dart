import 'package:jnap/jnap.dart';
import 'package:jnap/models.dart';

class WifiStatusService {
  final Jnap _jnap;
  WifiStatusService(this._jnap);

  Future<RouterEthernetPortConnectionsData> getPortConnections() async {
    final result = await _jnap.send(
      action: GetEthernetPortConnections.instance,
      overrides: JNAPConfigOverrides(
        cached: false,
        forceRemote: true,
      ),
    );

    final output = Map<String, dynamic>.from(result.output);
    return RouterEthernetPortConnectionsData.fromMap(output);
  }
}
