import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/wan_external.dart';

void main() {
  group('WanExternal', () {
    const wanExternal = WanExternal(
      publicWanIPv4: '1.1.1.1',
      publicWanIPv6: '2001:db8::1',
      privateWanIPv4: '192.168.1.1',
      privateWanIPv6: 'fe80::1',
    );

    final Map<String, dynamic> wanExternalMap = {
      'PublicWanIPv4': '1.1.1.1',
      'PublicWanIPv6': '2001:db8::1',
      'PrivateWanIPv4': '192.168.1.1',
      'PrivateWanIPv6': 'fe80::1',
    };

    test('toMap returns a valid map', () {
      expect(wanExternal.toMap(), wanExternalMap);
    });

    test('fromMap creates a valid object', () {
      expect(WanExternal.fromMap(wanExternalMap), wanExternal);
    });

    test('toJson returns a valid JSON string', () {
      expect(wanExternal.toJson(), json.encode(wanExternalMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WanExternal.fromJson(json.encode(wanExternalMap)), wanExternal);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedWanExternal = wanExternal.copyWith(
        publicWanIPv4: '2.2.2.2',
      );
      expect(updatedWanExternal.publicWanIPv4, '2.2.2.2');
      expect(updatedWanExternal.publicWanIPv6, wanExternal.publicWanIPv6);
    });

    test('props are correct', () {
      final we1 = WanExternal(publicWanIPv4: 'p41', publicWanIPv6: 'p61', privateWanIPv4: 'pr41', privateWanIPv6: 'pr61');
      final we2 = WanExternal(publicWanIPv4: 'p41', publicWanIPv6: 'p61', privateWanIPv4: 'pr41', privateWanIPv6: 'pr61');
      final we3 = WanExternal(publicWanIPv4: 'p42', publicWanIPv6: 'p62', privateWanIPv4: 'pr42', privateWanIPv6: 'pr62');
      expect(we1, we2);
      expect(we1.props, we2.props);
      expect(we1 == we3, false);
      expect(we1.props == we3.props, false);
    });
  });
}
