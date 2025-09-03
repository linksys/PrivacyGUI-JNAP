import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/polling_service.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'polling_service_test.mocks.dart';

List<JNAPService> mockServiceList = [
  airtimeFairnessService,
  autoOnboardingService,
  bluetoothService,
  coreService,
  ddnsService,
  deviceListService,
];

@GenerateMocks([Jnap, PollingCacheManager])
void main() {
  late MockJnap mockJnap;
  late MockPollingCacheManager mockPollingCacheManager;
  late ProviderContainer container;

  setUp(() {
    mockJnap = MockJnap();
    mockPollingCacheManager = MockPollingCacheManager();
    container = ProviderContainer(overrides: [
      cacheManagerProvider.overrideWithValue(mockPollingCacheManager),
    ]);
    JNAPServiceList(mockServiceList);
  });

  group('PollingService', () {
    test('fetchCacheData returns null when cache is incomplete', () {
      final ref = container.read(Provider((ref) => ref));
      final service = PollingService(ref, jnap: mockJnap);
      when(mockPollingCacheManager.fetchCacheData()).thenReturn({
        'GetNodesWirelessNetworkConnections': {'data': {}}
      });

      final result = service.fetchCacheData();

      expect(result, isNull);
    });

    test('fetchCacheData returns data when cache is complete', () {
      final ref = container.read(Provider((ref) => ref));
      final commands = PollingService(ref).buildCoreTransaction();
      final cache = Map.fromEntries(commands.map((e) => MapEntry(e.key.command,
          {'data': JNAPSuccess(result: 'OK', output: {}).toJson()})));

      when(mockPollingCacheManager.fetchCacheData()).thenReturn(cache);

      final service = PollingService(ref, jnap: mockJnap);
      final result = service.fetchCacheData();

      expect(result, isNotNull);
      expect(result?.length, commands.length);
    });

    test('doPolling calls jnap.transaction', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = PollingService(ref, jnap: mockJnap);
      when(mockJnap.transaction(
        transactionBuilder: anyNamed('transactionBuilder'),
        overrides: anyNamed('overrides'),
      )).thenAnswer(
          (_) async => JNAPTransactionSuccessWrap(result: 'OK', data: []));

      await service.doPolling();

      verify(mockJnap.transaction(
        transactionBuilder: anyNamed('transactionBuilder'),
        overrides: anyNamed('overrides'),
      )).called(1);
    });

    test('checkSmartMode calls jnap.send and returns mode', () async {
      when(mockJnap.send(
        action: GetDeviceMode.instance,
        overrides: anyNamed('overrides'),
      )).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: {'mode': 'Master'}));

      final ref = container.read(Provider((ref) => ref));
      final mode = await PollingService(ref, jnap: mockJnap).checkSmartMode();

      expect(mode, 'Master');
      verify(mockJnap.send(
        action: GetDeviceMode.instance,
        overrides: JNAPConfigOverrides(forceRemote: true),
      )).called(1);
    });

    test('buildCoreTransaction builds commands correctly for Master mode', () {
      final ref = container.read(Provider((ref) => ref));
      final commands = PollingService(ref, jnap: mockJnap).buildCoreTransaction(mode: 'Master');
      expect(commands.any((e) => e.key == GetBackhaulInfo.instance), isTrue);
    });

    test('buildCoreTransaction builds commands correctly for non-Master mode',
        () {
      final ref = container.read(Provider((ref) => ref));
      final commands = PollingService(ref, jnap: mockJnap).buildCoreTransaction(mode: 'Satellite');
      expect(commands.any((e) => e.key == GetBackhaulInfo.instance), isFalse);
    });
  });
}
