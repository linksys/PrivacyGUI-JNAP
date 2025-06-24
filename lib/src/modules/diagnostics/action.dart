import 'package:jnap/src/modules/diagnostics/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/diagnostics/ExecSysCommand
/// http://linksys.com/jnap/diagnostics/GetPingStatus
/// http://linksys.com/jnap/diagnostics/GetSysinfoData
/// http://linksys.com/jnap/diagnostics/GetSystemStats
/// http://linksys.com/jnap/diagnostics/GetSystemStats2
/// http://linksys.com/jnap/diagnostics/GetTracerouteStatus
/// http://linksys.com/jnap/diagnostics/RestorePreviousFirmware
/// http://linksys.com/jnap/diagnostics/SendSysinfoEmail
/// http://linksys.com/jnap/diagnostics/StartPing
/// http://linksys.com/jnap/diagnostics/StartTraceroute
/// http://linksys.com/jnap/diagnostics/StopPing
/// http://linksys.com/jnap/diagnostics/StopTraceroute
///

sealed class DiagnosticsAction extends JNAPAction {
  DiagnosticsAction({
    required super.name,
    required super.varients,
  }) : super(service: diagnosticsService);

  static List<DiagnosticsAction> get all => [
        ExecSysCommand.instance,
        GetPingStatus.instance,
        GetSysinfoData.instance,
        GetSystemStats.instance,
        GetTracerouteStatus.instance,
        RestorePreviousFirmware.instance,
        SendSysinfoEmail.instance,
        StartPing.instance,
        StartTraceroute.instance,
        StopPing.instance,
        StopTraceroute.instance,
      ];
}

/// http://linksys.com/jnap/diagnostics/ExecSysCommand
class ExecSysCommand extends DiagnosticsAction {
  static final ExecSysCommand instance = ExecSysCommand._();
  ExecSysCommand._()
      : super(
          name: 'ExecSysCommand',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/GetPingStatus
class GetPingStatus extends DiagnosticsAction {
  static final GetPingStatus instance = GetPingStatus._();
  GetPingStatus._()
      : super(
          name: 'GetPingStatus',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/GetSysinfoData
class GetSysinfoData extends DiagnosticsAction {
  static final GetSysinfoData instance = GetSysinfoData._();
  GetSysinfoData._()
      : super(
          name: 'GetSysinfoData',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/GetSystemStats
/// http://linksys.com/jnap/diagnostics/GetSystemStats2
class GetSystemStats extends DiagnosticsAction {
  static final GetSystemStats instance = GetSystemStats._();
  GetSystemStats._()
      : super(
          name: 'GetSystemStats',
          varients: [
            VersionVarients(1, 1),
            VersionVarients(2, 10),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/GetTracerouteStatus
class GetTracerouteStatus extends DiagnosticsAction {
  static final GetTracerouteStatus instance = GetTracerouteStatus._();
  GetTracerouteStatus._()
      : super(
          name: 'GetTracerouteStatus',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/RestorePreviousFirmware
class RestorePreviousFirmware extends DiagnosticsAction {
  static final RestorePreviousFirmware instance =
      RestorePreviousFirmware._();
  RestorePreviousFirmware._()
      : super(
          name: 'RestorePreviousFirmware',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/SendSysinfoEmail
class SendSysinfoEmail extends DiagnosticsAction {
  static final SendSysinfoEmail instance = SendSysinfoEmail._();
  SendSysinfoEmail._()
      : super(
          name: 'SendSysinfoEmail',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/StartPing
class StartPing extends DiagnosticsAction {
  static final StartPing instance = StartPing._();
  StartPing._()
      : super(
          name: 'StartPing',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/StartTraceroute
class StartTraceroute extends DiagnosticsAction {
  static final StartTraceroute instance = StartTraceroute._();
  StartTraceroute._()
      : super(
          name: 'StartTraceroute',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/StopPing
class StopPing extends DiagnosticsAction {
  static final StopPing instance = StopPing._();
  StopPing._()
      : super(
          name: 'StopPing',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}

/// http://linksys.com/jnap/diagnostics/StopTraceroute
class StopTraceroute extends DiagnosticsAction {
  static final StopTraceroute instance = StopTraceroute._();
  StopTraceroute._()
      : super(
          name: 'StopTraceroute',
          varients: [
            VersionVarients(1, 1),
          ],
        );
}
