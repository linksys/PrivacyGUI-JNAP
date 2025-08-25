import 'package:web/web.dart';
import 'package:jnap/src/cache/cache_manager.dart';

class BasedCacheManager implements CacheManager {
  final Storage _localStorage = window.localStorage;
  static const _key = 'cached_data';
  @override
  Future<String?> get() {
    final data = Future.value(_localStorage.getItem(_key));
    return data;
  }

  @override
  Future<void> set(String value) async {
    _localStorage.setItem(_key, value);
  }
}
