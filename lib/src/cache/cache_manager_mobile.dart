import 'dart:io';

import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/cache_manager.dart';

class BasedCacheManager implements CacheManager {
  Directory? _cacheDir;

  @override
  Future<String?> get() async {
    final file = await _getFile();
    if (await file.exists()) {
      return file.readAsString();
    } else {
      return null;
    }
  }

  @override
  Future<void> set(String value) async {
    final file = await _getFile();
    await file.writeAsString(value);
  }

  Future<File> _getFile() async {
    _cacheDir ??= Directory.systemTemp;
    logger.d("[CacheManager] cache dir: ${_cacheDir!.path}");
    Uri uri = Uri.parse("${_cacheDir!.path}/$cacheFileName");
    File file = File.fromUri(uri);
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }
}
