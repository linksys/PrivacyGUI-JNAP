import 'dart:io';

import 'package:test/test.dart';
import 'package:jnap/src/cache/cache_manager_mobile.dart'; // The class to test

void main() {
  group('BasedCacheManager (Mobile)', () {
    late BasedCacheManager cacheManager;
    late Directory tempDir;

    setUp(() async {
      // Create a temporary directory for each test
      tempDir = await Directory.systemTemp.createTemp('cache_test_');
      // Initialize CacheManager with the temporary directory
      cacheManager = BasedCacheManager(testCacheDir: tempDir);
    });

    tearDown(() async {
      // Clean up the temporary directory after each test
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('set() should write data to file', () async {
      final testValue = 'test_data_123';
      await cacheManager.set(testValue);

      // Verify the file content
      final file = File('${tempDir.path}/dataCache'); // Corrected cacheFileName
      expect(await file.exists(), isTrue);
      expect(await file.readAsString(), testValue);
    });

    test('get() should read data from file', () async {
      final testValue = 'another_test_data';
      final file = File('${tempDir.path}/dataCache');
      await file.writeAsString(testValue);

      final retrievedValue = await cacheManager.get();
      expect(retrievedValue, testValue);
    });

    test('get() should return null if file does not exist', () async {
      final retrievedValue = await cacheManager.get();
      expect(retrievedValue, isNull);
    });

    test('set() should overwrite existing data', () async {
      final initialValue = 'initial_data';
      await cacheManager.set(initialValue);

      final newValue = 'new_data';
      await cacheManager.set(newValue);

      final file = File('${tempDir.path}/dataCache');
      expect(await file.readAsString(), newValue);
    });
  });
}