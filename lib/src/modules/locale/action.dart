import 'package:jnap/src/modules/locale/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/locale/GetLocalTime
/// http://linksys.com/jnap/locale/GetTimeSettings
/// http://linksys.com/jnap/locale/GetLocale
/// http://linksys.com/jnap/locale/SetLocale
/// http://linksys.com/jnap/locale/SetTimeSettings
///
class LocaleAction extends JNAPAction {
  LocaleAction({
    required super.name,
    required super.varients,
  }) : super(service: localeService);

  static List<LocaleAction> get all => [
        GetLocalTime.instance,
        GetTimeSettings.instance,
        GetLocale.instance,
        SetLocale.instance,
        SetTimeSettings.instance,
      ];
}

/// http://linksys.com/jnap/locale/GetLocalTime
class GetLocalTime extends LocaleAction {
  static final GetLocalTime instance = GetLocalTime._();
  GetLocalTime._()
      : super(name: 'GetLocalTime', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/locale/GetTimeSettings
class GetTimeSettings extends LocaleAction {
  static final GetTimeSettings instance = GetTimeSettings._();
  GetTimeSettings._()
      : super(name: 'GetTimeSettings', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/locale/GetLocale
class GetLocale extends LocaleAction {
  static final GetLocale instance = GetLocale._();
  GetLocale._()
      : super(name: 'GetLocale', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/locale/SetLocale
class SetLocale extends LocaleAction {
  static final SetLocale instance = SetLocale._();
  SetLocale._()
      : super(name: 'SetLocale', varients: [
          VersionVarients(1, 1),
        ]);
}

/// http://linksys.com/jnap/locale/SetTimeSettings
class SetTimeSettings extends LocaleAction {
  static final SetTimeSettings instance = SetTimeSettings._();
  SetTimeSettings._()
      : super(name: 'SetTimeSettings', varients: [
          VersionVarients(1, 1),
        ]);
}
