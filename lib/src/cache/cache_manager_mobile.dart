import 'dart:io';

import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/cache_manager.dart';

class BasedCacheManager implements CacheManager {
  Directory? _cacheDir;

  // Add a constructor that allows injecting _cacheDir for testing
  BasedCacheManager({Directory? testCacheDir}) {
    _cacheDir = testCacheDir;
  }

  @override
  Future<String?> get() async {
    final file = await _getFile(createIfNotExist: false); // Don't create
    if (await file.exists()) {
      final content = await file.readAsString();
      return content.isEmpty ? null : content; // Return null if file is empty
    } else {
      return null;
    }
  }

  @override
  Future<void> set(String value) async {
    final file = await _getFile(createIfNotExist: true); // Create if not exists
    await file.writeAsString(value);
  }

  Future<File> _getFile({bool createIfNotExist = true}) async {
    _cacheDir ??= Directory.systemTemp;
    logger.d("[CacheManager] cache dir: ${_cacheDir!.path}");
    Uri uri = Uri.parse("${_cacheDir!.path}/$cacheFileName");
    File file = File.fromUri(uri);
    if (createIfNotExist && !file.existsSync()) {
      file.createSync();
    }
    return file;
  }
}
