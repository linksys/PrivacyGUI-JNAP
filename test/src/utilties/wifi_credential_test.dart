import 'package:jnap/src/utilties/wifi_credential.dart';
import 'package:test/test.dart';

void main() {
  group('WiFiCredential', () {
    test('constructor creates a WiFiCredential object', () {
      const credential = WiFiCredential(
        ssid: 'MyWiFi',
        password: 'myPassword',
        type: SecurityType.wpa,
        isHidden: false,
      );

      expect(credential.ssid, 'MyWiFi');
      expect(credential.password, 'myPassword');
      expect(credential.type, SecurityType.wpa);
      expect(credential.isHidden, isFalse);
    });

    group('parse', () {
      test('should parse a full WiFi credential string', () {
        const raw = 'WIFI:S:MyWiFi;P:myPassword;T:WPA;H:false;;';
        final credential = WiFiCredential.parse(raw);

        expect(credential.ssid, 'MyWiFi');
        expect(credential.password, 'myPassword');
        expect(credential.type, SecurityType.wpa);
        expect(credential.isHidden, isFalse);
      });

      test('should parse a WiFi credential string with WEP security', () {
        const raw = 'WIFI:S:AnotherWiFi;P:anotherPassword;T:WEP;H:true;;';
        final credential = WiFiCredential.parse(raw);

        expect(credential.ssid, 'AnotherWiFi');
        expect(credential.password, 'anotherPassword');
        expect(credential.type, SecurityType.wep);
        expect(credential.isHidden, isTrue);
      });

      test('should parse a WiFi credential string with NONE security', () {
        const raw = 'WIFI:S:OpenWiFi;P:;T:NONE;H:false;;';
        final credential = WiFiCredential.parse(raw);

        expect(credential.ssid, 'OpenWiFi');
        expect(credential.password, '');
        expect(credential.type, SecurityType.none);
        expect(credential.isHidden, isFalse);
      });

      test('should handle missing fields gracefully', () {
        const raw = 'WIFI:S:PartialWiFi;H:true;;';
        final credential = WiFiCredential.parse(raw);

        expect(credential.ssid, 'PartialWiFi');
        expect(credential.password, ''); // Default value
        expect(credential.type, SecurityType.none); // Default value
        expect(credential.isHidden, isTrue);
      });

      test('should handle empty string', () {
        const raw = '';
        final credential = WiFiCredential.parse(raw);

        expect(credential.ssid, '');
        expect(credential.password, '');
        expect(credential.type, SecurityType.none);
        expect(credential.isHidden, isFalse);
      });

      test('should handle unknown security type', () {
        const raw = 'WIFI:S:UnknownType;P:pass;T:UNKNOWN;H:false;;';
        final credential = WiFiCredential.parse(raw);

        expect(credential.ssid, 'UnknownType');
        expect(credential.password, 'pass');
        expect(credential.type, SecurityType.none); // Falls back to none
        expect(credential.isHidden, isFalse);
      });
    });

    group('copyWith', () {
      const original = WiFiCredential(
        ssid: 'OriginalSSID',
        password: 'originalPass',
        type: SecurityType.wpa,
        isHidden: false,
      );

      test('should copy with new SSID', () {
        final updated = original.copyWith(ssid: 'NewSSID');
        expect(updated.ssid, 'NewSSID');
        expect(updated.password, original.password);
        expect(updated.type, original.type);
        expect(updated.isHidden, original.isHidden);
      });

      test('should copy with new password', () {
        final updated = original.copyWith(password: 'newPass');
        expect(updated.ssid, original.ssid);
        expect(updated.password, 'newPass');
        expect(updated.type, original.type);
        expect(updated.isHidden, original.isHidden);
      });

      test('should copy with new security type', () {
        final updated = original.copyWith(type: SecurityType.wep);
        expect(updated.ssid, original.ssid);
        expect(updated.password, original.password);
        expect(updated.type, SecurityType.wep);
        expect(updated.isHidden, original.isHidden);
      });

      test('should copy with new hidden status', () {
        final updated = original.copyWith(isHidden: true);
        expect(updated.ssid, original.ssid);
        expect(updated.password, original.password);
        expect(updated.type, original.type);
        expect(updated.isHidden, isTrue);
      });

      test('should return identical object if no changes', () {
        final updated = original.copyWith();
        expect(updated.ssid, original.ssid);
        expect(updated.password, original.password);
        expect(updated.type, original.type);
        expect(updated.isHidden, original.isHidden);
      });
    });

    group('generate', () {
      test('should generate a full WiFi credential string', () {
        const credential = WiFiCredential(
          ssid: 'MyWiFi',
          password: 'myPassword',
          type: SecurityType.wpa,
          isHidden: false,
        );
        expect(credential.generate(), 'WIFI:S:MyWiFi;P:myPassword;T:WPA;H:false;;');
      });

      test('should generate a WiFi credential string with WEP security', () {
        const credential = WiFiCredential(
          ssid: 'AnotherWiFi',
          password: 'anotherPassword',
          type: SecurityType.wep,
          isHidden: true,
        );
        expect(credential.generate(), 'WIFI:S:AnotherWiFi;P:anotherPassword;T:WEP;H:true;;');
      });

      test('should generate a WiFi credential string with NONE security', () {
        const credential = WiFiCredential(
          ssid: 'OpenWiFi',
          password: '',
          type: SecurityType.none,
          isHidden: false,
        );
        expect(credential.generate(), 'WIFI:S:OpenWiFi;P:;T:NONE;H:false;;');
      });

      test('should handle empty SSID', () {
        const credential = WiFiCredential(
          ssid: '',
          password: 'pass',
          type: SecurityType.wpa,
          isHidden: false,
        );
        expect(credential.generate(), 'WIFI:S:;P:pass;T:WPA;H:false;;');
      });
    });
  });
}
