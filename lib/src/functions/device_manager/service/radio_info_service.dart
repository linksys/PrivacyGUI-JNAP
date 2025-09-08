import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/base_service.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:riverpod/riverpod.dart';

class RadioInfoService extends BaseService {
  final Ref _ref;

  RadioInfoService(this._ref) : super(_ref, [
    MapEntry(GetRadioInfo.instance, {}),
    MapEntry(GetGuestRadioSettings.instance, {}),
  ]);

  Map<String, RouterRadio> getRadioInfoMapFromCache() {
    final cache = fetchCacheData();
    final getRadioInfo = (cache?[GetRadioInfo.instance])?.output;
    final radioList = List.from(getRadioInfo?['radios'] ?? [])
        .map((e) => RouterRadio.fromMap(e))
        .toList();
    final radioMap =
        Map.fromEntries(radioList.map((e) => MapEntry(e.radioID, e)));
    return radioMap;
  }

  GuestRadioSettings? getGuestRadioSettingsFromCache() {
    final cache = fetchCacheData();
    final getGuestRadioSettings = (cache?[GetGuestRadioSettings.instance])?.output;
    return getGuestRadioSettings == null ? null : GuestRadioSettings.fromMap(getGuestRadioSettings);
  }
}