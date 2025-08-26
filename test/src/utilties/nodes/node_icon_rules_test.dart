import 'package:test/test.dart';
import 'package:jnap/src/utilties/nodes/icon_device_category.dart';
import 'package:jnap/src/utilties/nodes/node_icon_rules_helper.dart';

void main() {
  group('Node Icon Rules Helper', () {
    group('routerIconTestByModel', () {
      test('should return "routerWhw03" for "whw03"', () {
        expect(routerIconTestByModel(modelNumber: 'whw03'), 'routerWhw03');
      });

      test(
          'should return "routerEa6350v4" for "ea6350" with hardware version "4"',
          () {
        expect(
            routerIconTestByModel(
                modelNumber: 'ea6350', hardwareVersion: '4'),
            'routerEa6350v4');
      });

      test('should return "routerEa7500v3" for model with OR condition like "ea7250"', () {
        expect(routerIconTestByModel(modelNumber: 'ea7250'), 'routerEa7500v3');
      });

       test('should return "routerMr7350" for model with "starts with" condition like "mr7340"', () {
        expect(routerIconTestByModel(modelNumber: 'mr7340'), 'routerMr7350');
      });

      test('should return "routerLn12" for an unknown model', () {
        expect(
            routerIconTestByModel(modelNumber: 'unknown_model'), 'routerLn12');
      });

      test('should return "node" for an empty model', () {
        expect(routerIconTestByModel(modelNumber: ''), 'node');
      });
    });

    group('deviceIconTest', () {
      test('should return "computer" for a Mac computer', () {
        final target = {
          'model': {
            'manufacturer': 'Apple',
            'deviceType': 'Computer',
          },
        };
        expect(deviceIconTest(target), IconDeviceCategory.computer.name);
      });

      test('should return "computer" for a Windows PC identified by OS', () {
        final target = {
          'unit': {
            'operatingSystem': 'Windows',
          },
           'model': {
            'deviceType': 'Computer',
          },
        };
        expect(deviceIconTest(target), IconDeviceCategory.computer.name);
      });

      test('should return "phone" for an iPhone', () {
        final target = {
          'model': {
            'deviceType': 'Mobile',
            'modelNumber': 'iPhone',
          },
        };
        expect(deviceIconTest(target), IconDeviceCategory.phone.name);
      });

      test('should return "tv" for a Google TV', () {
        final target = {
          'friendlyName': 'My GoogleTV',
        };
        expect(deviceIconTest(target), IconDeviceCategory.tv.name);
      });

      test('should return "gameConsole" for a PS5', () {
        final target = {
          'friendlyName': 'My PS5',
        };
        expect(deviceIconTest(target), IconDeviceCategory.gameConsole.name);
      });

       test('should return "speaker" for an Apple HomePod', () {
        final target = {
           'model': {
            'manufacturer': 'Apple',
            'deviceType': 'DigitalAssistant',
            'modelNumber': 'HomePod',
          },
        };
        expect(deviceIconTest(target), IconDeviceCategory.speaker.name);
      });

      test('should return "plug" for a smart plug', () {
        final target = {
          'friendlyName': 'living room plug',
        };
        expect(deviceIconTest(target), IconDeviceCategory.plug.name);
      });

      test('should return "vacuum" for a vacuum', () {
        final target = {
          'friendlyName': 'robot vacuum',
        };
        expect(deviceIconTest(target), IconDeviceCategory.vacuum.name);
      });

      test('should return "unknown" for a generic device', () {
        final target = {
          'friendlyName': 'Some generic device',
        };
        expect(deviceIconTest(target), IconDeviceCategory.unknown.name);
      });
    });

    group('iconTest', () {
      test('should return "routerEa6350v4" for Linksys EA6350v4', () {
        final target = {
          'model': {
            'hardwareVersion': '4',
            'manufacturer': 'Linksys',
            'modelNumber': 'ea6350',
            'deviceType': 'Infrastructure',
          },
        };
        expect(iconTest(target), 'routerEa6350v4');
      });

      test('should return "laptopMac" for a MacBook', () {
        final target = {
          'deviceName': 'MacBook',
        };
        expect(iconTest(target), 'laptopMac');
      });

      test('should return "desktopPc" for a Windows computer', () {
        final target = {
          'unit': {
            'operatingSystem': 'Windows',
          },
        };
        expect(iconTest(target), 'desktopPc');
      });

      test('should handle lookup correctly', () {
        final target = {
          'model': {
            'manufacturer': 'Linksys',
            'modelNumber': 'eax2000',
            'deviceType': 'Infrastructure',
          },
        };
        expect(iconTest(target), 'routerEax2000');
      });

      test('should return "genericDevice" for an empty target', () {
        final target = <String, dynamic>{};
        expect(iconTest(target), 'genericDevice');
      });
    });
  });
}
