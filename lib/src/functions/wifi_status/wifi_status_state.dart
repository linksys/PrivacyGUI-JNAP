import 'dart:convert';
import 'package:equatable/equatable.dart';

class WifiStatusState extends Equatable {
  final String band;
  final bool isGuest;
  final bool isEnabled;
  final String deviceCount;
  final String ssid;
  final String password;
  final List<String> radios;
  final bool canBeDisabled;
  final String qrData;

  const WifiStatusState({
    required this.band,
    required this.isGuest,
    required this.isEnabled,
    required this.deviceCount,
    required this.ssid,
    required this.password,
    required this.radios,
    required this.canBeDisabled,
    required this.qrData,
  });

  factory WifiStatusState.empty() => WifiStatusState(
        band: '',
        isGuest: false,
        isEnabled: false,
        deviceCount: '',
        ssid: '',
        password: '',
        radios: [],
        canBeDisabled: false,
        qrData: '',
      );

  WifiStatusState copyWith({
    String? band,
    bool? isGuest,
    bool? isEnabled,
    String? deviceCount,
    String? ssid,
    String? password,
    List<String>? radios,
    bool? canBeDisabled,
    String? qrData,
  }) {
    return WifiStatusState(
      band: band ?? this.band,
      isGuest: isGuest ?? this.isGuest,
      isEnabled: isEnabled ?? this.isEnabled,
      deviceCount: deviceCount ?? this.deviceCount,
      ssid: ssid ?? this.ssid,
      password: password ?? this.password,
      radios: radios ?? this.radios,
      canBeDisabled: canBeDisabled ?? this.canBeDisabled,
      qrData: qrData ?? this.qrData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'band': band,
      'isGuest': isGuest,
      'isEnabled': isEnabled,
      'deviceCount': deviceCount,
      'ssid': ssid,
      'password': password,
      'radios': radios,
      'canBeDisabled': canBeDisabled,
      'qrData': qrData,
    };
  }

  factory WifiStatusState.fromMap(Map<String, dynamic> map) {
    return WifiStatusState(
      band: map['band'] as String,
      isGuest: map['isGuest'] as bool,
      isEnabled: map['isEnabled'] as bool,
      deviceCount: map['deviceCount'] as String,
      ssid: map['ssid'] as String,
      password: map['password'] as String,
      radios: List<String>.from(map['radios'] as List<String>),
      canBeDisabled: map['canBeDisabled'] as bool,
      qrData: map['qrData'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WifiStatusState.fromJson(String source) =>
      WifiStatusState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      band,
      isGuest,
      isEnabled,
      deviceCount,
      ssid,
      password,
      radios,
      canBeDisabled,
      qrData,
    ];
  }
}