import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/traceroute_status.dart';

void main() {
  group('TracerouteStatus', () {
    const tracerouteStatus = TracerouteStatus(
      isRunning: true,
      tracerouteLog: 'traceroute to google.com (142.250.190.142), 30 hops max, 60 byte packets',
    );

    final Map<String, dynamic> tracerouteStatusMap = {
      'isRunning': true,
      'tracerouteLog': 'traceroute to google.com (142.250.190.142), 30 hops max, 60 byte packets',
    };

    test('toMap returns a valid map', () {
      expect(tracerouteStatus.toMap(), tracerouteStatusMap);
    });

    test('fromMap creates a valid object', () {
      expect(TracerouteStatus.fromMap(tracerouteStatusMap), tracerouteStatus);
    });

    test('toJson returns a valid JSON string', () {
      expect(tracerouteStatus.toJson(), json.encode(tracerouteStatusMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(TracerouteStatus.fromJson(json.encode(tracerouteStatusMap)), tracerouteStatus);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedStatus = tracerouteStatus.copyWith(
        isRunning: false,
      );
      expect(updatedStatus.isRunning, false);
      expect(updatedStatus.tracerouteLog, tracerouteStatus.tracerouteLog);
    });

    test('props are correct', () {
      final status1 = TracerouteStatus(isRunning: true, tracerouteLog: 'log1');
      final status2 = TracerouteStatus(isRunning: true, tracerouteLog: 'log1');
      final status3 = TracerouteStatus(isRunning: false, tracerouteLog: 'log2');
      expect(status1, status2);
      expect(status1.props, status2.props);
      expect(status1 == status3, false);
      expect(status1.props == status3.props, false);
    });
  });
}
