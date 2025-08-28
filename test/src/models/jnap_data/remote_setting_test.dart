import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/remote_setting.dart';

void main() {
  group('RemoteSetting', () {
    const remoteSetting = RemoteSetting(
      isEnabled: true,
    );

    final Map<String, dynamic> remoteSettingMap = {
      'isEnabled': true,
    };

    test('toMap returns a valid map', () {
      expect(remoteSetting.toMap(), remoteSettingMap);
    });

    test('fromMap creates a valid object', () {
      expect(RemoteSetting.fromMap(remoteSettingMap), remoteSetting);
    });

    test('toJson returns a valid JSON string', () {
      expect(remoteSetting.toJson(), json.encode(remoteSettingMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(RemoteSetting.fromJson(json.encode(remoteSettingMap)), remoteSetting);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedSetting = remoteSetting.copyWith(
        isEnabled: false,
      );
      expect(updatedSetting.isEnabled, false);
    });

    test('props are correct', () {
      final setting1 = RemoteSetting(isEnabled: true);
      final setting2 = RemoteSetting(isEnabled: true);
      final setting3 = RemoteSetting(isEnabled: false);
      expect(setting1, setting2);
      expect(setting1.props, setting2.props);
      expect(setting1 == setting3, false);
      expect(setting1.props == setting3.props, false);
    });
  });
}
