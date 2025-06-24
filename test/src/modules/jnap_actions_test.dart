import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:jnap/src/modules/modules.dart';

import '../../data/service_list.dart';

class TestJNAPService implements JNAPService {
  @override
  final String name;
  @override
  final String path;
  @override
  final List<JNAPServiceSupported> supportedServices;
  int _latestVersion;

  @override
  int get latestVersion => _latestVersion;

  TestJNAPService({
    required this.path,
    required this.name,
    int latestVersion = 1,
    this.supportedServices = const [],
  }) : _latestVersion = latestVersion;

  @override
  String get servicePath => '${JNAPService.prefix}$path';

  @override
  String get fullServiceName => '$servicePath$name';

  @override
  String get latestServiceName =>
      '$fullServiceName${_latestVersion == 1 ? '' : _latestVersion}';

  @override
  bool isSupportService(String service) {
    final supportCheck = supportedServices
        .firstWhereOrNull((element) => element.name == service);
    return supportCheck?.isSupported(_latestVersion) ?? false;
  }

  @override
  void updateVersion(int version) {
    _latestVersion = version;
  }
}

class TestJNAPAction extends JNAPAction {
  TestJNAPAction({
    required super.name,
    required super.service,
    super.varients,
  });
}

void main() {
  group('JNAPActions', () {
    test('should return empty string for version 1', () {
      final service = TestJNAPService(path: 'test/', name: 'service');
      final action = TestJNAPAction(
        name: 'TestAction',
        service: service,
        varients: [VersionVarients(1, 1)],
      );

      expect(action.latestVersion, '');
      expect(action.command, 'http://linksys.com/jnap/test/TestAction');
    });

    test('should return version string for version > 1', () {
      final service = TestJNAPService(path: 'test/', name: 'service');
      final action = TestJNAPAction(
        name: 'TestAction',
        service: service,
        varients: [VersionVarients(2, 1)],
      );

      expect(action.latestVersion, '2');
      expect(action.command, 'http://linksys.com/jnap/test/TestAction2');
    });

    test('should select correct version based on service version', () {
      final service =
          TestJNAPService(path: 'test/', name: 'service', latestVersion: 3);
      final action = TestJNAPAction(
        name: 'TestAction',
        service: service,
        varients: [
          VersionVarients(1, 1),
          VersionVarients(2, 2),
          VersionVarients(3, 3),
        ],
      );

      expect(action.latestVersion, '3');
    });

    test('should select highest available version <= service version', () {
      final service =
          TestJNAPService(path: 'test/', name: 'service', latestVersion: 2);
      final action = TestJNAPAction(
        name: 'TestAction',
        service: service,
        varients: [
          VersionVarients(1, 1), // Version 1, requires service version 1
          VersionVarients(2, 2), // Version 2, requires service version 2
          VersionVarients(
              3, 3), // Version 3, requires service version 3 (too high)
        ],
      );

      // Should select version 2 because it's the highest version that works with service version 2
      expect(action.latestVersion, '2');
    });

    test('should fall back to version 1 if no compatible version found', () {
      final service = TestJNAPService(path: 'test/', name: 'service');
      final action = TestJNAPAction(
        name: 'TestAction',
        service: service,
        varients: [
          VersionVarients(2, 2), // Requires service version 2
          VersionVarients(3, 3), // Requires service version 3
        ],
      );

      // Should fall back to version 1 (empty string) as no compatible version found
      expect(action.latestVersion, '');
      expect(action.command, 'http://linksys.com/jnap/test/TestAction');
    });

    test('should handle empty varients list', () {
      final service = TestJNAPService(path: 'test/', name: 'service');
      final action = TestJNAPAction(
        name: 'TestAction',
        service: service,
        varients: [],
      );

      // Should fall back to version 1 (empty string) when no varients provided
      expect(action.latestVersion, '');
      expect(action.command, 'http://linksys.com/jnap/test/TestAction');
    });

    ///
    /// Be aware, the service name should not duplicate
    ///
    group('JNAPServiceList.betterActions', () {
      setUp(() {
        JNAPServiceList.reset();
      });

      test('should update service versions based on provided service list', () {
        // Create a test service list with a mock service
        final serviceList = JNAPServiceList();

        // Create a test service and add it to the service list
        // The service path should match the format used in the test URLs
        final testService = TestJNAPService(path: 'test/', name: 'serviceAA');
        serviceList.services.add(testService);

        // Create a test action that uses our test service
        final action = TestJNAPAction(
          name: 'TestAction',
          service: testService,
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 2),
            VersionVarients(3, 3),
          ],
        );

        // Initially, the latest version should be 1 (empty string)
        expect(action.latestVersion, '');
        expect(action.command, 'http://linksys.com/jnap/test/TestAction');

        // Update the service version using betterActions
        // The URL format should be http://linksys.com/jnap/[service]/[ServiceName][Version]
        serviceList.betterActions([
          'http://linksys.com/jnap/test/serviceAA3',
        ]);

        // The action should now use version 3
        expect(action.latestVersion, '3');
        expect(action.command, 'http://linksys.com/jnap/test/TestAction3');
      });

      test('should handle multiple services and versions correctly', () {
        final serviceList = JNAPServiceList();

        // Create test services with paths that match the full service name
        final serviceA = TestJNAPService(path: 'test/', name: 'serviceA');
        final serviceB = TestJNAPService(path: 'test/', name: 'serviceB');
        serviceList.services.addAll([serviceA, serviceB]);

        // Create test actions
        final actionA1 = TestJNAPAction(
          name: 'Action',
          service: serviceA,
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 1),
            VersionVarients(12, 11), // Version 12
          ],
        );

        final actionB1 = TestJNAPAction(
          name: 'Action',
          service: serviceB,
          varients: [
            VersionVarients(1, 1),
            VersionVarients(11, 1), // Version 11
          ],
        );

        // Update versions using betterActions
        serviceList.betterActions([
          'http://linksys.com/jnap/test/serviceA11',
          'http://linksys.com/jnap/test/serviceB10',
        ]);


        // Verify versions were updated correctly
        expect(actionA1.latestVersion, '12');
        expect(actionA1.command, 'http://linksys.com/jnap/test/Action12');

        // Service B should be at version 11
        expect(actionB1.latestVersion, '11');
        expect(actionB1.command, 'http://linksys.com/jnap/test/Action11');
      });

      test('should not update version if service is not found', () {
        final serviceList = JNAPServiceList();
        final testService = TestJNAPService(path: 'test/', name: 'serviceC');
        serviceList.services.add(testService);

        final action = TestJNAPAction(
          name: 'TestAction',
          service: testService,
          varients: [VersionVarients(1, 1)],
        );

        // Try to update with a non-matching service URL
        serviceList.betterActions([
          'http://linksys.com/jnap/other/serviceC/TestAction2',
        ]);

        // Version should remain at 1 (empty string) since the service wasn't found
        expect(action.latestVersion, '');
        expect(action.command, 'http://linksys.com/jnap/test/TestAction');
      });

      test('should handle service paths with version numbers', () {
        final serviceList = JNAPServiceList();
        final testService = TestJNAPService(path: 'test/', name: 'serviceD');
        serviceList.services.add(testService);

        final action = TestJNAPAction(
          name: 'TestAction',
          service: testService,
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 1),
          ],
        );

        // Service path includes a version number
        serviceList.betterActions([
          'http://linksys.com/jnap/test/serviceD/TestAction2',
        ]);

        // Should update to version 2
        expect(action.latestVersion, '2');
        expect(action.command, 'http://linksys.com/jnap/test/TestAction2');
      });
    });

    group('Test with Real JNAP Actions, do betterActions with service list',
        () {
      setUp(() {
        JNAPServiceList.reset();
      });
      test(
          '[GetDevices] should update service versions based on provided service list',
          () {
        final serviceList = JNAPServiceList();

        // before update, the GetDevices default version is empty string
        expect(GetDevices.instance.latestVersion, '');

        // update service list
        serviceList.betterActions(testServiceList);

        // after update, the version should be updated
        expect(GetDevices.instance.latestVersion, '3');
        expect(GetDevices.instance.command,
            'http://linksys.com/jnap/devicelist/GetDevices3');
      });

      test(
          '[CheckAdminPassword] should update service versions based on provided service list',
          () {
        final serviceList = JNAPServiceList();

        // before update, the GetDevices default version is empty string
        expect(CheckAdminPassword.instance.latestVersion, '');

        // update service list
        serviceList.betterActions(testServiceList);

        // after update, the version should be updated
        expect(CheckAdminPassword.instance.latestVersion, '3');
        expect(CheckAdminPassword.instance.command,
            'http://linksys.com/jnap/core/CheckAdminPassword3');
      });
    });
  });
}
