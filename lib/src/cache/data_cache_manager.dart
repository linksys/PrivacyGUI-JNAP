import 'dart:convert';

import 'package:jnap/logger.dart';
import 'package:jnap/src/cache/config.dart';
import 'package:meta/meta.dart';
import 'cache_manager_base.dart'
    if (dart.library.io) 'cache_manager_mobile.dart'
    if (dart.library.html) 'cache_manager_web.dart';

class DataCacheManager {
  static DataCacheManager? _instance;

  DataCacheManager._(BasedCacheManager cache) {
    init(cache);
  }
  factory DataCacheManager([BasedCacheManager? cache]) {
    _instance ??= DataCacheManager._(cache ?? BasedCacheManager());
    return _instance!;
  }

  /// cache system can cache multiple devices via serial number.
  /// data variable is specific device cache map data.
  /// cache is plain text for data that used for saving in file.
  String lastSerialNumber = "";
  late int defaultCacheExpiration;
  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;
  String _cache = "";
  late BasedCacheManager cacheManager;

  void init(BasedCacheManager cache) async {
    logger.d('Starting to init linksys cache manager');
    defaultCacheExpiration = CacheConfig.expiration - 10000;
    cacheManager = cache;
    _cache = await cacheManager.get() ?? "";
    logger.d('[CacheManager] init cache data: ${_cache.isNotEmpty}');
  }

  Future<void> clearCache(String action) async {
    if (action.isNotEmpty) {
      if (data.isNotEmpty && data.keys.contains(action)) {
        logger.d('[CacheManager] remove cache data: $action');
        _data.remove(action);
      }
    } else {
      logger.d('[CacheManager] remove all cache data');
      _data = {};
    }

    if (lastSerialNumber.isNotEmpty) {
      await saveCache(lastSerialNumber);
    }
  }

  /// Load cache data for a specific serial number.
  ///
  /// Returns true if the cache was loaded successfully, false otherwise.
  Future<bool> loadCache({required String serialNumber}) async {
    // If the serial number is the same, and data is already loaded, no need to reload.
    // This assumes that if lastSerialNumber matches, _data is already correct.
    if (serialNumber == lastSerialNumber && data.isNotEmpty) {
      logger.d(
          "[CacheManager] SN is same, cache already loaded for <$serialNumber>");
      return false; // Indicate no *new* loading occurred for this SN
    }

    logger.d(
        "[CacheManager] SN changed or data empty. Starting to load cache for <$serialNumber>");
    String? value;
    try {
      value = await cacheManager.get();
      logger.d("[CacheManager] Loaded cache for $serialNumber: $value");
    } catch (e) {
      logger.e("[CacheManager] Error retrieving cache: $e");
      _data = {}; // Clear data on error
      lastSerialNumber = serialNumber; // Still update serial number
      return true; // Indicate that a new SN was processed (even if error)
    }
    _cache = value ?? "";

    // Always update lastSerialNumber when processing a new SN
    lastSerialNumber = serialNumber;

    if (_cache.isEmpty) {
      _data = {}; // No cached data found, initialize to empty
      logger.d("[CacheManager] No cached data found for <$serialNumber>");
      return true; // Indicate that a new SN was processed (even if no data)
    }

    try {
      final allCaches = jsonDecode(_cache);
      if (allCaches is Map<String, dynamic> &&
          allCaches.containsKey(serialNumber)) {
        _data = allCaches[serialNumber];
        logger.d(
            "[CacheManager] Loaded cache for <$serialNumber> : ${data.toString()}");
        return true; // Data successfully loaded for this SN
      } else {
        _data = {}; // No specific cache for this SN, or invalid format
        logger.d(
            "[CacheManager] No specific cache found for <$serialNumber> or invalid format.");
        return true; // Indicate that a new SN was processed (even if no data)
      }
    } catch (e) {
      logger.e("[CacheManager] Error decoding cache: $e");
      _data = {}; // Clear data on error
      return true; // Indicate that a new SN was processed (even if error)
    }
  }

  Future<void> saveCache(String serialNumber) async {
    logger.d("[CacheManager] Save cache for $serialNumber");
    if (serialNumber.isEmpty) {
      return;
    }

    try {
      // Ensure _cache is up-to-date before proceeding
      _cache = await cacheManager.get() ?? "";
      logger.d(
          "[CacheManager] Prepare for saving cache for $serialNumber, _cache: $_cache");
      Map<String, dynamic> cacheModel;
      if (_cache.isEmpty) {
        cacheModel = {};
      } else {
        cacheModel = jsonDecode(_cache);
      }

      // If the serial number doesn't exist in the cache, initialize it
      if (cacheModel[serialNumber] == null) {
        cacheModel[serialNumber] = {};
      }

      // Update the specific serial number's data with current 'data'
      data.forEach((key, value) {
        cacheModel[serialNumber][key] = value;
      });

      _cache = jsonEncode(cacheModel);
      await cacheManager.set(_cache);
    } catch (e) {
      logger.e("[CacheManager] Error saving cache: $e");
      // Optionally, handle the error further, e.g., notify a monitoring system
    }
  }

  Future<Map<String, dynamic>?> getCache(String? serialNumber) async {
    String sn = serialNumber ?? lastSerialNumber;
    final tempCache = await cacheManager.get();
    if (tempCache == null || tempCache.isEmpty) {
      logger.d('[CacheManager] no cache from $serialNumber');
      return null;
    }
    logger.d("[CacheManager] get cache of $serialNumber");
    return jsonDecode(tempCache)[sn];
  }

  String? getAllCaches() {
    cacheManager.get().then((value) {
      _cache = value ?? "";
    });
    return _cache;
  }

  bool didCacheExpire(String action, [int? expirationOverride]) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final cachedAt = data[action]["cachedAt"];
    final expiration = expirationOverride ?? defaultCacheExpiration;
    final expired = now - cachedAt >= expiration;
    logger.d(
        '[CacheManager] didCacheExpire for $action: now=$now, cachedAt=$cachedAt, expiration=$expiration, expired=$expired');
    if (data[action] == null ||
        data[action]["cachedAt"] == null ||
        DateTime.now().millisecondsSinceEpoch - data[action]["cachedAt"] >=
            (expirationOverride ?? defaultCacheExpiration)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> handleJNAPCached(Map<String, dynamic> record, String action,
      [String? serialNumber]) async {
    final dataResult = {
      "target": action,
      "cachedAt": DateTime.now().millisecondsSinceEpoch,
    };
    dataResult["data"] = record;
    data[action] = dataResult;
    final sn = serialNumber ?? lastSerialNumber;
    if (sn.isNotEmpty) {
      await saveCache(sn);
    }
  }

  bool checkCacheDataValid(String action, [int? expirationOverride]) {
    final result = data.containsKey(action) &&
        data[action] != null &&
        !didCacheExpire(action, expirationOverride);
    logger.d('[CacheManager] checkCacheDataValid for $action: $result');
    return result;
  }

  @visibleForTesting
  clearAllCache() {
    _data = {};
    _cache = "";
    lastSerialNumber = "";
    cacheManager.set("{}");
  }

  @visibleForTesting
  void releaseInstance() {
    _instance = null;
  }
}
