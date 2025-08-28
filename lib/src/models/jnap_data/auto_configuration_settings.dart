import 'dart:convert';

import '../jsonable.dart';
import 'package:jnap/src/models/types.dart';

/// AutoConfigurationMethod Enum
/// PreConfigured
/// AutoParent
enum AutoConfigurationMethod {
  preConfigured,
  autoParent,
  ;

  String toValue() {
    return switch (this) {
      AutoConfigurationMethod.preConfigured => 'PreConfigured',
      AutoConfigurationMethod.autoParent => 'AutoParent',
    };
  }

  static AutoConfigurationMethod? fromValue(String? value) {
    return switch (value) {
      'PreConfigured' => AutoConfigurationMethod.preConfigured,
      'AutoParent' => AutoConfigurationMethod.autoParent,
      _ => null,
    };
  }
}

///
///  {
///    "isAutoConfigurationSupported": true,
///    "autoConfigurationMethod": "PreConfigured",
///    "userAcknowledgedAutoConfiguration": false
///  }
///
class AutoConfigurationSettings extends Jsonable {
  final bool? isAutoConfigurationSupported;
  final AutoConfigurationMethod? autoConfigurationMethod;
  final bool? userAcknowledgedAutoConfiguration;

  const AutoConfigurationSettings({
    this.isAutoConfigurationSupported,
    this.autoConfigurationMethod = AutoConfigurationMethod.preConfigured,
    this.userAcknowledgedAutoConfiguration,
  });

  @override
  AutoConfigurationSettings copyWith({
    ValueGetter<bool?>? isAutoConfigurationSupported,
    ValueGetter<AutoConfigurationMethod?>? autoConfigurationMethod,
    ValueGetter<bool?>? userAcknowledgedAutoConfiguration,
  }) {
    return AutoConfigurationSettings(
      isAutoConfigurationSupported: isAutoConfigurationSupported != null
          ? isAutoConfigurationSupported()
          : this.isAutoConfigurationSupported,
      autoConfigurationMethod: autoConfigurationMethod != null
          ? autoConfigurationMethod()
          : this.autoConfigurationMethod,
      userAcknowledgedAutoConfiguration:
          userAcknowledgedAutoConfiguration != null
              ? userAcknowledgedAutoConfiguration()
              : this.userAcknowledgedAutoConfiguration,
    );
  }

  factory AutoConfigurationSettings.fromMap(Map<String, dynamic> map) {
    return AutoConfigurationSettings(
      isAutoConfigurationSupported:
          map['isAutoConfigurationSupported'] as bool?,
      autoConfigurationMethod: AutoConfigurationMethod.fromValue(
          map['autoConfigurationMethod'] as String?),
      userAcknowledgedAutoConfiguration:
          map['userAcknowledgedAutoConfiguration'] as bool?,
    );
  }

  factory AutoConfigurationSettings.fromJson(String source) =>
      AutoConfigurationSettings.fromMap(jsonDecode(source));

  @override
  Map<String, dynamic> toMap() {
    return {
      'isAutoConfigurationSupported': isAutoConfigurationSupported,
      'autoConfigurationMethod': autoConfigurationMethod?.toValue(),
      'userAcknowledgedAutoConfiguration': userAcknowledgedAutoConfiguration,
    };
  }

  @override
  String toString() {
    return 'AutoConfigurationSettings(isAutoConfigurationSupported: $isAutoConfigurationSupported, autoConfigurationMethod: $autoConfigurationMethod, userAcknowledgedAutoConfiguration: $userAcknowledgedAutoConfiguration)';
  }

  @override
  List<Object?> get props => [
        isAutoConfigurationSupported,
        autoConfigurationMethod,
        userAcknowledgedAutoConfiguration,
      ];
}
