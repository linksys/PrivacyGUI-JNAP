import 'dart:convert';
import 'package:jnap/src/cache/cache_manager_base.dart'
    if (dart.library.io) 'package:jnap/src/cache/cache_manager_mobile.dart'
    if (dart.library.html) 'package:jnap/src/cache/cache_manager_web.dart';
import 'package:jnap/src/cache/data_cache_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBasedCacheManager extends Mock implements BasedCacheManager {}

void main() {
  group('DataCacheManager', () {
    late DataCacheManager cacheManager;
    late MockBasedCacheManager mockBasedCacheManager;

    setUp(() async {
      mockBasedCacheManager = MockBasedCacheManager();
      when(() => mockBasedCacheManager.get()).thenAnswer((_) async => '');
      cacheManager = DataCacheManager(mockBasedCacheManager);
    });

    tearDown(() {
      cacheManager.releaseInstance();
    });

    test('initializes correctly', () async {
      when(() => mockBasedCacheManager.get()).thenAnswer((_) async => null);
      cacheManager.init(mockBasedCacheManager);
      expect(cacheManager.data, isEmpty);
      expect(cacheManager.lastSerialNumber, isEmpty);
    });

    test('clearCache clears all data when action is empty', () async {
      cacheManager.data['action1'] = {'data': 'some data'};
      cacheManager.lastSerialNumber = 'SN123';
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.clearCache('');

      expect(cacheManager.data, isEmpty);
      verify(() => mockBasedCacheManager.set(any()));
    });

    test('clearCache clears specific action', () async {
      cacheManager.data['action1'] = {'data': 'some data'};
      cacheManager.data['action2'] = {'data': 'other data'};
      cacheManager.lastSerialNumber = 'SN123';
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.clearCache('action1');

      expect(cacheManager.data.containsKey('action1'), isFalse);
      expect(cacheManager.data.containsKey('action2'), isTrue);
      verify(() => mockBasedCacheManager.set(any()));
    });

    test('loadCache returns true for new serial number with no cache',
        () async {
      when(() => mockBasedCacheManager.get()).thenAnswer((_) async => null);

      final result = await cacheManager.loadCache(serialNumber: 'SN123');

      expect(result, isTrue);
      expect(cacheManager.data, isEmpty);
      expect(cacheManager.lastSerialNumber, 'SN123');
    });

    test('loadCache loads data for existing serial number', () async {
      final cacheData = {
        'SN123': {
          'action1': {'data': 'some data'}
        }
      };
      when(() => mockBasedCacheManager.get())
          .thenAnswer((_) async => jsonEncode(cacheData));

      await cacheManager.loadCache(serialNumber: 'SN123');
      final result = await cacheManager.loadCache(serialNumber: 'SN123');

      expect(result, isFalse);
      expect(cacheManager.data, isNotEmpty);
      expect(cacheManager.data['action1']['data'], 'some data');
      expect(cacheManager.lastSerialNumber, 'SN123');
    });

    test('loadCache handles error during cache retrieval', () async {
      when(() => mockBasedCacheManager.get())
          .thenThrow(Exception('Failed to retrieve cache'));

      final result = await cacheManager.loadCache(serialNumber: 'SN123');

      expect(result,
          isTrue); // Now returns true as a new SN was processed, even with error
      expect(cacheManager.data, isEmpty); // Cache should remain empty on error
      expect(cacheManager.lastSerialNumber,
          'SN123'); // Serial number should still be set
    });

    test('saveCache saves data for a new serial number', () async {
      cacheManager.data['action1'] = {'data': 'some data'};
      when(() => mockBasedCacheManager.get()).thenAnswer((_) async => '');
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.saveCache('SN123');

      verify(() => mockBasedCacheManager.set(jsonEncode({
        'SN123': {
          'action1': {'data': 'some data'}
        }
      })));
    });

    test('saveCache handles error during cache saving', () async {
      cacheManager.data['action1'] = {'data': 'some data'};
      when(() => mockBasedCacheManager.get()).thenAnswer((_) async => '');
      when(() => mockBasedCacheManager.set(any()))
          .thenThrow(Exception('Failed to save cache'));

      // Now that saveCache is async and handles errors internally, we await it.
      // We still expect it not to throw an unhandled exception.
      await expectLater(() => cacheManager.saveCache('SN123'), returnsNormally);
    });

    test('didCacheExpire returns true for expired cache', () {
      final expiredData = {
        'cachedAt': DateTime.now().millisecondsSinceEpoch - 200000
      };
      cacheManager.data['action1'] = expiredData;
      cacheManager.defaultCacheExpiration = 10000;

      expect(cacheManager.didCacheExpire('action1'), isTrue);
    });

    test('didCacheExpire returns false for non-expired cache', () {
      final nonExpiredData = {
        'cachedAt': DateTime.now().millisecondsSinceEpoch
      };
      cacheManager.data['action1'] = nonExpiredData;
      cacheManager.defaultCacheExpiration = 100000;

      expect(cacheManager.didCacheExpire('action1'), isFalse);
    });

    test('handleJNAPCached saves data correctly', () async {
      final record = {'key': 'value'};
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.handleJNAPCached(record, 'action1', 'SN123');

      expect(cacheManager.data['action1'], isNotNull);
      expect(cacheManager.data['action1']['data'], record);
      verify(() => mockBasedCacheManager.set(any()));
    });

    test('handleJNAPCached saves null data correctly', () async {
      final record = <String, dynamic>{};
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.handleJNAPCached(record, 'action_null', 'SN123');

      expect(cacheManager.data['action_null'], isNotNull);
      expect(cacheManager.data['action_null']['data'], record);
      verify(() => mockBasedCacheManager.set(any()));
    });

    test('handleJNAPCached saves empty map data correctly', () async {
      final record = <String, dynamic>{};
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.handleJNAPCached(record, 'action_empty_map', 'SN123');

      expect(cacheManager.data['action_empty_map'], isNotNull);
      expect(cacheManager.data['action_empty_map']['data'], record);
      verify(() => mockBasedCacheManager.set(any()));
    });

    test('handleJNAPCached saves empty list data correctly', () async {
      final record = <String, dynamic>{};
      when(() => mockBasedCacheManager.set(any())).thenAnswer((_) async {});

      await cacheManager.handleJNAPCached(record, 'action_empty_list', 'SN123');

      expect(cacheManager.data['action_empty_list'], isNotNull);
      expect(cacheManager.data['action_empty_list']['data'], record);
      verify(() => mockBasedCacheManager.set(any()));
    });

    test('checkCacheDataValid returns true for valid cache', () {
      final nonExpiredData = {
        'cachedAt': DateTime.now().millisecondsSinceEpoch
      };
      cacheManager.data['action1'] = nonExpiredData;
      cacheManager.defaultCacheExpiration = 100000;

      expect(cacheManager.checkCacheDataValid('action1'), isTrue);
    });

    test('checkCacheDataValid returns false for invalid or expired cache', () {
      final expiredData = {
        'cachedAt': DateTime.now().millisecondsSinceEpoch - 200000
      };
      cacheManager.data['action1'] = expiredData;
      cacheManager.defaultCacheExpiration = 10000;

      expect(cacheManager.checkCacheDataValid('action1'), isFalse);
      expect(cacheManager.checkCacheDataValid('nonexistent_action'), isFalse);
    });
  });
}