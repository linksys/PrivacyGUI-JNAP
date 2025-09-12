import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/interfaces_impl.dart';
import 'package:jnap/src/functions/polling/polling_provider.dart';
import 'package:riverpod/riverpod.dart';

final pollingProvider =
    AsyncNotifierProvider<PollingNotifier, CoreTransactionData>(
        () => PollingNotifier());

final pollingConfigProvider =
    Provider<PollingConfig>((ref) => PollingConfigImpl());

final pollingAdditionalTasksProvider =
    Provider<PollingAdditionalTasks>((ref) => PollingRefBasedAdditionalTasks(ref));

final pollingCompletedNotifierProvider =
    Provider<PollingCompletedNotifier>((ref) => PollingRefBasedCompletedNotifier(ref));

final pollingCacheManagerProvider =
    Provider<PollingCacheManager>((ref) => PollingCacheManagerImpl());

