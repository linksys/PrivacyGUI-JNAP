import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:riverpod/riverpod.dart';

class BaseService {
  final Ref _ref;
  final List<MapEntry<JNAPAction, Map<String, dynamic>>> _commands;

  BaseService(this._ref, this._commands);

  Map<JNAPAction, JNAPSuccess>? fetchCacheData() {
    final cache = _ref.read(cacheManagerProvider).fetchCacheData();
    final checkCacheDataList =
        _commands.where((command) => cache.keys.contains(command.key.command));
    // Have not done any polling yet
    if (checkCacheDataList.length != _commands.length) return null;

    final cacheDataList = checkCacheDataList
        .where((command) => cache[command.key.command]['data'] != null)
        .map((command) => MapEntry(command.key,
            JNAPSuccess.fromJson(cache[command.key.command]['data'])))
        .toList();
    return Map.fromEntries(cacheDataList);
  }
}
