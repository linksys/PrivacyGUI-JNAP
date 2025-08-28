import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/send_sysinfo_email.dart';

void main() {
  group('SendSysinfoEmail', () {
    const sendSysinfoEmail = SendSysinfoEmail(
      addressList: ['test1@example.com', 'test2@example.com'],
    );

    final Map<String, dynamic> sendSysinfoEmailMap = {
      'addressList': ['test1@example.com', 'test2@example.com'],
    };

    test('toMap returns a valid map', () {
      expect(sendSysinfoEmail.toMap(), sendSysinfoEmailMap);
    });

    test('fromMap creates a valid object', () {
      expect(SendSysinfoEmail.fromMap(sendSysinfoEmailMap), sendSysinfoEmail);
    });

    test('toJson returns a valid JSON string', () {
      expect(sendSysinfoEmail.toJson(), json.encode(sendSysinfoEmailMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SendSysinfoEmail.fromJson(json.encode(sendSysinfoEmailMap)), sendSysinfoEmail);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedEmail = sendSysinfoEmail.copyWith(
        addressList: ['test3@example.com'],
      );
      expect(updatedEmail.addressList, ['test3@example.com']);
    });

    test('props are correct', () {
      final email1 = SendSysinfoEmail(addressList: ['a1']);
      final email2 = SendSysinfoEmail(addressList: ['a1']);
      final email3 = SendSysinfoEmail(addressList: ['a2']);
      expect(email1, email2);
      expect(email1.props, email2.props);
      expect(email1 == email3, false);
      expect(email1.props == email3.props, false);
    });
  });
}
