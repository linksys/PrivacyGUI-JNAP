import 'package:jnap/jnap.dart';
import 'package:jnap/src/functions/provider.dart';
import 'package:jnap/src/models/jnap_data/guest_radio_settings.dart';
import 'package:jnap/src/models/jnap_data/radio_info.dart';
import 'package:riverpod/riverpod.dart';

class RadioInfoService {
  final Ref _ref;

  RadioInfoService(this._ref);

  Future<JNAPSuccess> getRadioInfo() async {
    return await _ref.read(jnapProvider).send(action: GetRadioInfo.instance);
  }

  Future<JNAPSuccess> getGuestRadioSettings() async {
    return await _ref.read(jnapProvider).send(action: GetGuestRadioSettings.instance);
  }

  Future<Map<String, RouterRadio>> getRadioInfoMap() async {;
    final getRadioInfoData = (await getRadioInfo()).output;
    final radioList = List.from(getRadioInfoData['radios'] ?? [])
        .map((e) => RouterRadio.fromMap(e))
        .toList();
    final radioMap =
        Map.fromEntries(radioList.map((e) => MapEntry(e.radioID, e)));
    return radioMap;
  }

  Future<GuestRadioSettings?> getGuestRadioSettingsData() async {
    final getGuestRadioSettingsData = (await getGuestRadioSettings()).output;
    return getGuestRadioSettingsData.isEmpty ? null : GuestRadioSettings.fromMap(getGuestRadioSettingsData);
  }
}