import 'dart:async';
import 'package:jnap/jnap.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:jnap/src/functions/internet_connection/internet_connection_service.dart';

/// Expose InternetConnectionService via DI so tests (and callers) can override it
final internetConnectionServiceProvider =
    Provider<InternetConnectionService>((ref) {
  return InternetConnectionService(Jnap.instance);
});

final internetConnectionProvider =
    NotifierProvider<InternetConnectionNotifier, InternetConnectionState>(
  () => InternetConnectionNotifier(),
);

@immutable
class InternetConnectionState {
  final bool isInternetConnected;
  const InternetConnectionState({required this.isInternetConnected});

  InternetConnectionState copyWith({bool? isInternetConnected}) =>
      InternetConnectionState(
        isInternetConnected: isInternetConnected ?? this.isInternetConnected,
      );
}

class InternetConnectionNotifier extends Notifier<InternetConnectionState> {
  StreamSubscription? _sub;

  @override
  InternetConnectionState build() {
    ref.onDispose(() {
      _sub?.cancel();
    });
    // Set default to not connected until checked
    return const InternetConnectionState(isInternetConnected: false);
  }

  /// Start or refresh an internet connectivity check.
  void check({
    int? maxRetries,
    int? retryDelayInMilliSec,
    int? timeoutInMilliSec,
  }) {
    _sub?.cancel();
    _sub = ref
        .read(internetConnectionServiceProvider)
        .scheduleCheckInternetConnection(
          maxRetries,
          retryDelayInMilliSec,
          timeoutInMilliSec,
        )
        .listen(
      (result) {
        final connected = result is JNAPSuccess &&
            result.output['connectionStatus'] == 'InternetConnected';
        state = state.copyWith(isInternetConnected: connected);
      },
      onError: (_) {
        state = state.copyWith(isInternetConnected: false);
      },
    );
  }
}
