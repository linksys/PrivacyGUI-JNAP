import 'dart:convert';
import 'package:test/test.dart';
import 'package:jnap/src/models/jnap_data/back_haul_info.dart';

void main() {
  group('WirelessConnectionInfo', () {
    const wirelessConnectionInfo = WirelessConnectionInfo(
      radioID: 'radio1',
      channel: 1,
      apRSSI: -50,
      stationRSSI: -60,
      apBSSID: '00:11:22:33:44:55',
      stationBSSID: 'AA:BB:CC:DD:EE:FF',
      txRate: 100,
      rxRate: 200,
      isMultiLinkOperation: true,
    );

    final Map<String, dynamic> wirelessConnectionInfoMap = {
      'radioID': 'radio1',
      'channel': 1,
      'apRSSI': -50,
      'stationRSSI': -60,
      'apBSSID': '00:11:22:33:44:55',
      'stationBSSID': 'AA:BB:CC:DD:EE:FF',
      'txRate': 100,
      'rxRate': 200,
      'isMultiLinkOperation': true,
    };

    test('toMap returns a valid map', () {
      expect(wirelessConnectionInfo.toMap(), wirelessConnectionInfoMap);
    });

    test('fromMap creates a valid object', () {
      expect(WirelessConnectionInfo.fromMap(wirelessConnectionInfoMap), wirelessConnectionInfo);
    });

    test('toJson returns a valid JSON string', () {
      expect(wirelessConnectionInfo.toJson(), json.encode(wirelessConnectionInfoMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(WirelessConnectionInfo.fromJson(json.encode(wirelessConnectionInfoMap)), wirelessConnectionInfo);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedInfo = wirelessConnectionInfo.copyWith(
        channel: 2,
        txRate: () => 150,
      );
      expect(updatedInfo.channel, 2);
      expect(updatedInfo.txRate, 150);
      expect(updatedInfo.radioID, wirelessConnectionInfo.radioID);
    });

    test('props are correct', () {
      final info1 = WirelessConnectionInfo(
        radioID: 'radio1',
        channel: 1,
        apRSSI: -50,
        stationRSSI: -60,
        apBSSID: '00:11:22:33:44:55',
        stationBSSID: 'AA:BB:CC:DD:EE:FF',
        txRate: 100,
        rxRate: 200,
        isMultiLinkOperation: true,
      );
      final info2 = WirelessConnectionInfo(
        radioID: 'radio1',
        channel: 1,
        apRSSI: -50,
        stationRSSI: -60,
        apBSSID: '00:11:22:33:44:55',
        stationBSSID: 'AA:BB:CC:DD:EE:FF',
        txRate: 100,
        rxRate: 200,
        isMultiLinkOperation: true,
      );
      final info3 = WirelessConnectionInfo(
        radioID: 'radio2',
        channel: 1,
        apRSSI: -50,
        stationRSSI: -60,
        apBSSID: '00:11:22:33:44:55',
        stationBSSID: 'AA:BB:CC:DD:EE:FF',
        txRate: 100,
        rxRate: 200,
        isMultiLinkOperation: true,
      );

      expect(info1, info2);
      expect(info1.props, info2.props);
      expect(info1 == info3, false);
      expect(info1.props == info3.props, false);
    });
  });

  group('BackHaulInfoData', () {
    const wirelessConnectionInfo = WirelessConnectionInfo(
      radioID: 'radio1',
      channel: 1,
      apRSSI: -50,
      stationRSSI: -60,
      apBSSID: '00:11:22:33:44:55',
      stationBSSID: 'AA:BB:CC:DD:EE:FF',
      txRate: 100,
      rxRate: 200,
      isMultiLinkOperation: true,
    );

    const backHaulInfoData = BackHaulInfoData(
      deviceUUID: 'uuid123',
      ipAddress: '192.168.1.1',
      parentIPAddress: '192.168.1.254',
      connectionType: 'Wireless',
      wirelessConnectionInfo: wirelessConnectionInfo,
      speedMbps: '1000',
      timestamp: '2023-01-01T12:00:00Z',
    );

    final Map<String, dynamic> backHaulInfoDataMap = {
      'deviceUUID': 'uuid123',
      'ipAddress': '192.168.1.1',
      'parentIPAddress': '192.168.1.254',
      'connectionType': 'Wireless',
      'wirelessConnectionInfo': wirelessConnectionInfo.toMap(),
      'speedMbps': '1000',
      'timestamp': '2023-01-01T12:00:00Z',
    };

    test('toMap returns a valid map', () {
      expect(backHaulInfoData.toMap(), backHaulInfoDataMap);
    });

    test('fromMap creates a valid object', () {
      expect(BackHaulInfoData.fromMap(backHaulInfoDataMap), backHaulInfoData);
    });

    test('toJson returns a valid JSON string', () {
      expect(backHaulInfoData.toJson(), json.encode(backHaulInfoDataMap));
    });

    test('fromJson creates a valid object from JSON string', () {
      expect(BackHaulInfoData.fromJson(json.encode(backHaulInfoDataMap)), backHaulInfoData);
    });

    test('copyWith returns a new object with updated values', () {
      final updatedData = backHaulInfoData.copyWith(
        ipAddress: '192.168.1.2',
        speedMbps: '500',
      );
      expect(updatedData.ipAddress, '192.168.1.2');
      expect(updatedData.speedMbps, '500');
      expect(updatedData.deviceUUID, backHaulInfoData.deviceUUID);
    });

    test('props are correct', () {
      final data1 = BackHaulInfoData(
        deviceUUID: 'uuid123',
        ipAddress: '192.168.1.1',
        parentIPAddress: '192.168.1.254',
        connectionType: 'Wireless',
        wirelessConnectionInfo: wirelessConnectionInfo,
        speedMbps: '1000',
        timestamp: '2023-01-01T12:00:00Z',
      );
      final data2 = BackHaulInfoData(
        deviceUUID: 'uuid123',
        ipAddress: '192.168.1.1',
        parentIPAddress: '192.168.1.254',
        connectionType: 'Wireless',
        wirelessConnectionInfo: wirelessConnectionInfo,
        speedMbps: '1000',
        timestamp: '2023-01-01T12:00:00Z',
      );
      final data3 = BackHaulInfoData(
        deviceUUID: 'uuid456',
        ipAddress: '192.168.1.1',
        parentIPAddress: '192.168.1.254',
        connectionType: 'Wireless',
        wirelessConnectionInfo: wirelessConnectionInfo,
        speedMbps: '1000',
        timestamp: '2023-01-01T12:00:00Z',
      );

      expect(data1, data2);
      expect(data1.props, data2.props);
      expect(data1 == data3, false);
      expect(data1.props == data3.props, false);
    });
  });
}
