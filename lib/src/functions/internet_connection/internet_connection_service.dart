import 'package:jnap/jnap.dart';

class InternetConnectionService {
  final Jnap _jnap;
  InternetConnectionService(this._jnap);

  Stream<JNAPResult> scheduleCheckInternetConnection(
    int? maxRetries,
    int? retryDelayInMilliSec,
    int? timeoutInMilliSec,
  ) {
    return _jnap.scheduled(
      action: GetInternetConnectionStatus.instance,
      retryDelayInMilliSec: retryDelayInMilliSec ?? 3000,
      maxRetry: maxRetries ?? 1,
      overrides: timeoutInMilliSec != null
          ? JNAPConfigOverrides(timeoutMs: timeoutInMilliSec)
          : null,
      condition: (result) {
        if (result is! JNAPSuccess) {
          return false;
        }
        return result.output['connectionStatus'] == 'InternetConnected';
      },
    );
  }
}
