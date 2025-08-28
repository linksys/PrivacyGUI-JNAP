import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/ping_status.dart';

void main() {
  group('PingStatus', () {
    const pingStatus = PingStatus(
      isRunning: true,
      pingLog: 'Pinging 8.8.8.8 with 32 bytes of data:\nReply from 8.8.8.8: bytes=32 time=10ms TTL=117',
    );

    final Map<String, dynamic> pingStatusMap = {
      'isRunning': true,
      'pingLog': 'Pinging 8.8.8.8 with 32 bytes of data:\nReply from 8.8.8.8: bytes=32 time=10ms TTL=117',
    };

    test('toMap returns a valid map', () {
      expect(pingStatus.toMap(), pingStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(PingStatus.fromMap(pingStatusMap), pingStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(pingStatus.toJson(), json.encode(pingStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(PingStatus.fromJson(json.encode(pingStatusMap)), pingStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = pingStatus.copyWith(
        isRunning: false,
      );
      expect(updatedStatus.isRunning, false);
      expect(updatedStatus.pingLog, pingStatus.pingLog);
    });

    test('props are correct', () {
      final status1 = PingStatus(isRunning: true, pingLog: 'log1');
      final status2 = PingStatus(isRunning: true, pingLog: 'log1');
      final status3 = PingStatus(isRunning: false, pingLog: 'log2');
      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });
}
