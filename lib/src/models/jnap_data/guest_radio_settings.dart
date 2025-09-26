// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../jsonable.dart';

// Only for 'GetGuestRadioSettings2'
class GuestRadioSettingsData extends Jsonable {
  final bool isGuestNetworkACaptivePortal;
  final bool isGuestNetworkEnabled;
  final List<GuestRadioInfo> radios;
  final int? maxSimultaneousGuests;
  final GuestPasswordRestriction? guestPasswordRestrictions;
  final int? maxSimultaneousGuestsLimit;

  @override
  List<Object?> get props {
    return [
      isGuestNetworkACaptivePortal,
      isGuestNetworkEnabled,
      radios,
      maxSimultaneousGuests,
      guestPasswordRestrictions,
      maxSimultaneousGuestsLimit,
    ];
  }

  const GuestRadioSettingsData({
    required this.isGuestNetworkACaptivePortal,
    required this.isGuestNetworkEnabled,
    required this.radios,
    this.maxSimultaneousGuests,
    this.guestPasswordRestrictions,
    this.maxSimultaneousGuestsLimit,
  });

  @override
  GuestRadioSettingsData copyWith({
    bool? isGuestNetworkACaptivePortal,
    bool? isGuestNetworkEnabled,
    List<GuestRadioInfo>? radios,
    int? maxSimultaneousGuests,
    GuestPasswordRestriction? guestPasswordRestrictions,
    int? maxSimultaneousGuestsLimit,
  }) {
    return GuestRadioSettingsData(
      isGuestNetworkACaptivePortal:
          isGuestNetworkACaptivePortal ?? this.isGuestNetworkACaptivePortal,
      isGuestNetworkEnabled:
          isGuestNetworkEnabled ?? this.isGuestNetworkEnabled,
      radios: radios ?? this.radios,
      maxSimultaneousGuests:
          maxSimultaneousGuests ?? this.maxSimultaneousGuests,
      guestPasswordRestrictions:
          guestPasswordRestrictions ?? this.guestPasswordRestrictions,
      maxSimultaneousGuestsLimit:
          maxSimultaneousGuestsLimit ?? this.maxSimultaneousGuestsLimit,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isGuestNetworkACaptivePortal': isGuestNetworkACaptivePortal,
      'isGuestNetworkEnabled': isGuestNetworkEnabled,
      'radios': radios.map((x) => x.toMap()).toList(),
      'maxSimultaneousGuests': maxSimultaneousGuests,
      'guestPasswordRestrictions': guestPasswordRestrictions?.toMap(),
      'maxSimultaneousGuestsLimit': maxSimultaneousGuestsLimit,
    }..removeWhere((key, value) => value == null);
  }

  factory GuestRadioSettingsData.fromMap(Map<String, dynamic> map) {
    return GuestRadioSettingsData(
      isGuestNetworkACaptivePortal: map['isGuestNetworkACaptivePortal'] as bool,
      isGuestNetworkEnabled: map['isGuestNetworkEnabled'] as bool,
      radios: List<GuestRadioInfo>.from(
        (map['radios']).map<GuestRadioInfo>(
          (x) => GuestRadioInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
      maxSimultaneousGuests: map['maxSimultaneousGuests'] != null
          ? map['maxSimultaneousGuests'] as int
          : null,
      guestPasswordRestrictions: map['guestPasswordRestrictions'] != null
          ? GuestPasswordRestriction.fromMap(
              map['guestPasswordRestrictions'] as Map<String, dynamic>)
          : null,
      maxSimultaneousGuestsLimit: map['maxSimultaneousGuestsLimit'] != null
          ? map['maxSimultaneousGuestsLimit'] as int
          : null,
    );
  }

  factory GuestRadioSettingsData.fromJson(String source) =>
      GuestRadioSettingsData.fromMap(jsonDecode(source));
}

class SetGuestRadioSettingsData extends Jsonable {
  final bool isGuestNetworkEnabled;
  final List<GuestRadioInfo> radios;
  final int? maxSimultaneousGuests;

  const SetGuestRadioSettingsData({
    required this.isGuestNetworkEnabled,
    required this.radios,
    this.maxSimultaneousGuests,
  });

  factory SetGuestRadioSettingsData.fromGuestRadioSettings(
      GuestRadioSettingsData settings) {
    return SetGuestRadioSettingsData(
      isGuestNetworkEnabled: settings.isGuestNetworkEnabled,
      radios: settings.radios,
      maxSimultaneousGuests: settings.maxSimultaneousGuests,
    );
  }

  @override
  List<Object?> get props => [
        isGuestNetworkEnabled,
        radios,
        maxSimultaneousGuests,
      ];

  @override
  SetGuestRadioSettingsData copyWith({
    bool? isGuestNetworkEnabled,
    List<GuestRadioInfo>? radios,
    int? maxSimultaneousGuests,
  }) {
    return SetGuestRadioSettingsData(
      isGuestNetworkEnabled:
          isGuestNetworkEnabled ?? this.isGuestNetworkEnabled,
      radios: radios ?? this.radios,
      maxSimultaneousGuests:
          maxSimultaneousGuests ?? this.maxSimultaneousGuests,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isGuestNetworkEnabled': isGuestNetworkEnabled,
      'radios': radios.map((x) => x.toMap()).toList(),
      'maxSimultaneousGuests': maxSimultaneousGuests,
    }..removeWhere((key, value) => value == null);
  }

  factory SetGuestRadioSettingsData.fromMap(Map<String, dynamic> map) {
    return SetGuestRadioSettingsData(
      isGuestNetworkEnabled: map['isGuestNetworkEnabled'] as bool,
      radios: List<GuestRadioInfo>.from(
        (map['radios'] as List).map<GuestRadioInfo>(
          (x) => GuestRadioInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
      maxSimultaneousGuests: map['maxSimultaneousGuests'] != null
          ? map['maxSimultaneousGuests'] as int
          : null,
    );
  }

  factory SetGuestRadioSettingsData.fromJson(String source) =>
      SetGuestRadioSettingsData.fromMap(jsonDecode(source));
}

class GuestRadioInfo extends Jsonable {
  final String radioID;
  final bool isEnabled;
  final bool broadcastGuestSSID;
  final String guestSSID;
  final String? guestPassword;
  final String? guestWPAPassphrase;
  final bool? canEnableRadio;

  const GuestRadioInfo({
    required this.radioID,
    required this.isEnabled,
    required this.broadcastGuestSSID,
    required this.guestSSID,
    this.guestPassword,
    this.guestWPAPassphrase,
    this.canEnableRadio,
  });

  @override
  GuestRadioInfo copyWith({
    String? radioID,
    bool? isEnabled,
    bool? broadcastGuestSSID,
    String? guestSSID,
    String? guestPassword,
    String? guestWPAPassphrase,
    bool? canEnableRadio,
  }) {
    return GuestRadioInfo(
      radioID: radioID ?? this.radioID,
      isEnabled: isEnabled ?? this.isEnabled,
      broadcastGuestSSID: broadcastGuestSSID ?? this.broadcastGuestSSID,
      guestSSID: guestSSID ?? this.guestSSID,
      guestPassword: guestPassword ?? this.guestPassword,
      guestWPAPassphrase: guestWPAPassphrase ?? this.guestWPAPassphrase,
      canEnableRadio: canEnableRadio ?? this.canEnableRadio,
    );
  }

  @override
  List<Object?> get props {
    return [
      radioID,
      isEnabled,
      broadcastGuestSSID,
      guestSSID,
      guestPassword,
      guestWPAPassphrase,
      canEnableRadio,
    ];
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'radioID': radioID,
      'isEnabled': isEnabled,
      'broadcastGuestSSID': broadcastGuestSSID,
      'guestSSID': guestSSID,
      'guestPassword': guestPassword,
      'guestWPAPassphrase': guestWPAPassphrase,
      'canEnableRadio': canEnableRadio,
    }..removeWhere((key, value) => value == null);
  }

  factory GuestRadioInfo.fromMap(Map<String, dynamic> map) {
    return GuestRadioInfo(
      radioID: map['radioID'] as String,
      isEnabled: map['isEnabled'] as bool,
      broadcastGuestSSID: map['broadcastGuestSSID'] as bool,
      guestSSID: map['guestSSID'] as String,
      guestPassword:
          map['guestPassword'] != null ? map['guestPassword'] as String : null,
      guestWPAPassphrase: map['guestWPAPassphrase'] != null
          ? map['guestWPAPassphrase'] as String
          : null,
      canEnableRadio:
          map['canEnableRadio'] != null ? map['canEnableRadio'] as bool : null,
    );
  }

  factory GuestRadioInfo.fromJson(String source) =>
      GuestRadioInfo.fromMap(jsonDecode(source));
}

class GuestPasswordRestriction extends Jsonable {
  final int minLength;
  final int maxLength;
  final List<UnicodeRange> allowedCharacters;

  @override
  List<Object> get props => [
        minLength,
        maxLength,
        allowedCharacters,
      ];

  const GuestPasswordRestriction({
    required this.minLength,
    required this.maxLength,
    required this.allowedCharacters,
  });

  @override
  GuestPasswordRestriction copyWith({
    int? minLength,
    int? maxLength,
    List<UnicodeRange>? allowedCharacters,
  }) {
    return GuestPasswordRestriction(
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      allowedCharacters: allowedCharacters ?? this.allowedCharacters,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minLength': minLength,
      'maxLength': maxLength,
      'allowedCharacters': allowedCharacters.map((x) => x.toMap()).toList(),
    }..removeWhere((key, value) => value == null);
  }

  factory GuestPasswordRestriction.fromMap(Map<String, dynamic> map) {
    return GuestPasswordRestriction(
      minLength: map['minLength'] as int,
      maxLength: map['maxLength'] as int,
      allowedCharacters: List<UnicodeRange>.from(
        (map['allowedCharacters']).map<UnicodeRange>(
          (x) => UnicodeRange.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory GuestPasswordRestriction.fromJson(String source) =>
      GuestPasswordRestriction.fromMap(jsonDecode(source));
}

class UnicodeRange extends Jsonable {
  final int lowCodepoint;
  final int highCodepoint;

  @override
  List<Object> get props => [lowCodepoint, highCodepoint];

  const UnicodeRange({
    required this.lowCodepoint,
    required this.highCodepoint,
  });

  @override
  UnicodeRange copyWith({
    int? lowCodepoint,
    int? highCodepoint,
  }) {
    return UnicodeRange(
      lowCodepoint: lowCodepoint ?? this.lowCodepoint,
      highCodepoint: highCodepoint ?? this.highCodepoint,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lowCodepoint': lowCodepoint,
      'highCodepoint': highCodepoint,
    }..removeWhere((key, value) => value == null);
  }

  factory UnicodeRange.fromMap(Map<String, dynamic> map) {
    return UnicodeRange(
      lowCodepoint: map['lowCodepoint'] as int,
      highCodepoint: map['highCodepoint'] as int,
    );
  }

  factory UnicodeRange.fromJson(String source) =>
      UnicodeRange.fromMap(jsonDecode(source));
}