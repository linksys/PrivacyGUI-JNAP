import 'package:jnap/src/modules/core/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

///
///   http://linksys.com/jnap/core/Transaction
///   http://linksys.com/jnap/core/CheckAdminPassword
///   http://linksys.com/jnap/core/CheckAdminPassword2
///   http://linksys.com/jnap/core/CheckAdminPassword3
///   http://linksys.com/jnap/core/SetAdminPassword
///   http://linksys.com/jnap/core/SetAdminPassword2
///   http://linksys.com/jnap/core/SetAdminPassword3
///   http://linksys.com/jnap/core/GetAdminPasswordAuthStatus
///   http://linksys.com/jnap/core/GetAdminPasswordHint
///   http://linksys.com/jnap/core/GetDataUploadUserConsent
///   http://linksys.com/jnap/core/GetDeviceInfo
///   http://linksys.com/jnap/core/GetUnsecuredWiFiWarning
///   http://linksys.com/jnap/core/SetUnsecuredWiFiWarning
///   http://linksys.com/jnap/core/IsAdminPasswordDefault
///   http://linksys.com/jnap/core/IsServiceSupported
///   http://linksys.com/jnap/core/Reboot
///   http://linksys.com/jnap/core/Reboot2
///   http://linksys.com/jnap/core/FactoryReset
///   http://linksys.com/jnap/core/FactoryReset2
///

sealed class CoreAction extends JNAPAction {
  CoreAction({
    required super.name,
    required super.varients,
  }) : super(service: coreService);

  static List<CoreAction> get all => [
        Transaction.instance,
        CheckAdminPassword.instance,
        CoreSetAdminPassword.instance,
        GetAdminPasswordAuthStatus.instance,
        GetAdminPasswordHint.instance,
        IsAdminPasswordDefault.instance,
        GetDataUploadUserConsent.instance,
        GetDeviceInfo.instance,
        GetUnsecuredWiFiWarning.instance,
        SetUnsecuredWiFiWarning.instance,
        IsServiceSupported.instance,
        Reboot.instance,
        Reboot2.instance,
        FactoryReset.instance,
        FactoryReset2.instance,
        CorePnPSetAdminPassword.instance,
      ];
}

///   http://linksys.com/jnap/core/Transaction
class Transaction extends CoreAction {
  static final Transaction instance = Transaction._();
  Transaction._()
      : super(
          name: 'Transaction',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/CheckAdminPassword
///   http://linksys.com/jnap/core/CheckAdminPassword2
///   http://linksys.com/jnap/core/CheckAdminPassword3
class CheckAdminPassword extends CoreAction {
  static final CheckAdminPassword instance = CheckAdminPassword._();
  CheckAdminPassword._()
      : super(
          name: 'CheckAdminPassword',
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 2),
            VersionVarients(3, 7),
          ],
        );
}

///   http://linksys.com/jnap/core/SetAdminPassword
///   http://linksys.com/jnap/core/SetAdminPassword2
///   http://linksys.com/jnap/core/SetAdminPassword3
class CoreSetAdminPassword extends CoreAction {
  static final CoreSetAdminPassword instance = CoreSetAdminPassword._();
  CoreSetAdminPassword._()
      : super(
          name: 'SetAdminPassword',
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 2),
            VersionVarients(3, 7),
          ],
        );
}

///   http://linksys.com/jnap/core/SetAdminPassword2
class CorePnPSetAdminPassword extends CoreAction {
  static final CorePnPSetAdminPassword instance = CorePnPSetAdminPassword._();
  CorePnPSetAdminPassword._()
      : super(
          name: 'SetAdminPassword',
          varients: [
            VersionVarients(2, 2),
          ],
        );
}

///   http://linksys.com/jnap/core/GetAdminPasswordAuthStatus
class GetAdminPasswordAuthStatus extends CoreAction {
  static final GetAdminPasswordAuthStatus instance =
      GetAdminPasswordAuthStatus._();
  GetAdminPasswordAuthStatus._()
      : super(
          name: 'GetAdminPasswordAuthStatus',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/GetAdminPasswordHint
class GetAdminPasswordHint extends CoreAction {
  static final GetAdminPasswordHint instance = GetAdminPasswordHint._();
  GetAdminPasswordHint._()
      : super(
          name: 'GetAdminPasswordHint',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/GetDataUploadUserConsent
class GetDataUploadUserConsent extends CoreAction {
  static final GetDataUploadUserConsent instance = GetDataUploadUserConsent._();
  GetDataUploadUserConsent._()
      : super(
          name: 'GetDataUploadUserConsent',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/GetDeviceInfo
class GetDeviceInfo extends CoreAction {
  static final GetDeviceInfo instance = GetDeviceInfo._();
  GetDeviceInfo._()
      : super(
          name: 'GetDeviceInfo',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/GetUnsecuredWiFiWarning
class GetUnsecuredWiFiWarning extends CoreAction {
  static final GetUnsecuredWiFiWarning instance = GetUnsecuredWiFiWarning._();
  GetUnsecuredWiFiWarning._()
      : super(
          name: 'GetUnsecuredWiFiWarning',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/SetUnsecuredWiFiWarning
class SetUnsecuredWiFiWarning extends CoreAction {
  static final SetUnsecuredWiFiWarning instance = SetUnsecuredWiFiWarning._();
  SetUnsecuredWiFiWarning._()
      : super(
          name: 'SetUnsecuredWiFiWarning',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/IsAdminPasswordDefault
class IsAdminPasswordDefault extends CoreAction {
  static final IsAdminPasswordDefault instance = IsAdminPasswordDefault._();
  IsAdminPasswordDefault._()
      : super(
          name: 'IsAdminPasswordDefault',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/IsServiceSupported
class IsServiceSupported extends CoreAction {
  static final IsServiceSupported instance = IsServiceSupported._();
  IsServiceSupported._()
      : super(
          name: 'IsServiceSupported',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/Reboot
class Reboot extends CoreAction {
  static final Reboot instance = Reboot._();
  Reboot._()
      : super(
          name: 'Reboot',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/Reboot2
class Reboot2 extends CoreAction {
  static final Reboot2 instance = Reboot2._();
  Reboot2._()
      : super(
          name: 'Reboot2',
          varients: [
            VersionVarients(1, 8),
          ],
        );
}

///   http://linksys.com/jnap/core/FactoryReset
class FactoryReset extends CoreAction {
  static final FactoryReset instance = FactoryReset._();
  FactoryReset._()
      : super(
          name: 'FactoryReset',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

///   http://linksys.com/jnap/core/FactoryReset2
class FactoryReset2 extends CoreAction {
  static final FactoryReset2 instance = FactoryReset2._();
  FactoryReset2._()
      : super(
          name: 'FactoryReset2',
          varients: [
            VersionVarients(1, 9),
          ],
        );
}
