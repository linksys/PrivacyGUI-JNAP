import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/polling/interfaces.dart';
import 'package:jnap/src/functions/polling/polling_service.dart';
import 'package:jnap/src/functions/polling/providers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class MockJnap extends Mock implements Jnap {}

class MockPollingCacheManager extends Mock implements PollingCacheManager {}

class FakeJNAPAction extends Fake implements JNAPAction {}

class FakeJNAPConfigOverrides extends Fake implements JNAPConfigOverrides {}

class FakeJNAPTransactionBuilder extends Fake
    implements JNAPTransactionBuilder {}

List<JNAPService> mockServiceList = [
  airtimeFairnessService,
  autoOnboardingService,
  bluetoothService,
  coreService,
  ddnsService,
  deviceListService,
];

void main() {
  late MockJnap mockJnap;
  late MockPollingCacheManager mockPollingCacheManager;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeJNAPAction());
    registerFallbackValue(FakeJNAPConfigOverrides());
    registerFallbackValue(FakeJNAPTransactionBuilder());
  });

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
      when(() => mockPollingCacheManager.fetchCacheData()).thenReturn({
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

      when(() => mockPollingCacheManager.fetchCacheData()).thenReturn(cache);

      final service = PollingService(ref, jnap: mockJnap);
      final result = service.fetchCacheData();

      expect(result, isNotNull);
      expect(result?.length, commands.length);
    });

    test('doPolling calls jnap.transaction', () async {
      final ref = container.read(Provider((ref) => ref));
      final service = PollingService(ref, jnap: mockJnap);
      when(() => mockJnap.transaction(
        transactionBuilder: any(named: 'transactionBuilder'),
        overrides: any(named: 'overrides'),
      )).thenAnswer(
          (_) async => JNAPTransactionSuccessWrap(result: 'OK', data: []));

      await service.doPolling();

      verify(() => mockJnap.transaction(
        transactionBuilder: any(named: 'transactionBuilder'),
        overrides: any(named: 'overrides'),
      )).called(1);
    });

    test('checkSmartMode calls jnap.send and returns mode', () async {
      when(() => mockJnap.send(
        action: GetDeviceMode.instance,
        overrides: any(named: 'overrides'),
      )).thenAnswer(
          (_) async => JNAPSuccess(result: 'OK', output: {'mode': 'Master'}));

      final ref = container.read(Provider((ref) => ref));
      final mode = await PollingService(ref, jnap: mockJnap).checkSmartMode();

      expect(mode, 'Master');
      verify(() => mockJnap.send(
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