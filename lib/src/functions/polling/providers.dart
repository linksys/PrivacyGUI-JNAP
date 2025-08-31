import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/interfaces_impl.dart';
import 'package:jnap/src/functions/polling/polling_provider.dart';
import 'package:riverpod/riverpod.dart';

final pollingProvider =
    AsyncNotifierProvider<PollingNotifier, CoreTransactionData>(
        () => PollingNotifier());

final pollingConfigProvider =
    Provider<PollingConfig>((ref) => PollingConfigImpl());

final additionalTasksProvider =
    Provider<PollingAdditionalTasks>((ref) => PollingAdditionalTasksImpl(ref));

final completedNotifierProvider =
    Provider<PollingCompletedNotifier>((ref) => PollingCompletedNotifierImpl());

final cacheManagerProvider =
    Provider<PollingCacheManager>((ref) => PollingCacheManagerImpl());

