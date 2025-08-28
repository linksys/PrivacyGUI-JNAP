import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/timezone.dart';

void main() {
  group('SupportedTimezone', () {
    const supportedTimezone = SupportedTimezone(
      observesDST: true,
      timeZoneID: 'America/Los_Angeles',
      description: 'Pacific Time',
      utcOffsetMinutes: -480,
    );

    final Map<String, dynamic> supportedTimezoneMap = {
      'observesDST': true,
      'timeZoneID': 'America/Los_Angeles',
      'description': 'Pacific Time',
      'utcOffsetMinutes': -480,
    };

    test('toMap returns a valid map', () {
      expect(supportedTimezone.toMap(), supportedTimezoneMap);
    });

    test('fromMap creates a valid object', () {
      expect(SupportedTimezone.fromMap(supportedTimezoneMap), supportedTimezone);
    });

    test('toJson returns a valid JSON string', () {
      expect(supportedTimezone.toJson(), json.encode(supportedTimezoneMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(SupportedTimezone.fromJson(json.encode(supportedTimezoneMap)), supportedTimezone);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedTimezone = supportedTimezone.copyWith(
        observesDST: false,
        description: 'Mountain Time',
      );
      expect(updatedTimezone.observesDST, false);
      expect(updatedTimezone.description, 'Mountain Time');
      expect(updatedTimezone.timeZoneID, supportedTimezone.timeZoneID);
    });

    test('props are correct', () {
      final tz1 = SupportedTimezone(observesDST: true, timeZoneID: 'tz1', description: 'd1', utcOffsetMinutes: 1);
      final tz2 = SupportedTimezone(observesDST: true, timeZoneID: 'tz1', description: 'd1', utcOffsetMinutes: 1);
      final tz3 = SupportedTimezone(observesDST: false, timeZoneID: 'tz2', description: 'd2', utcOffsetMinutes: 2);
      expect(tz1, tz2);
      expect(tz1.props, tz2.props);
      expect(tz1 == tz3, false);
      expect(tz1.props == tz3.props, false);
    });
  });
}
