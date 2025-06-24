import 'dart:io';

import 'package:jnap/jnap.dart';
import 'package:test/test.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

///
/// These tests are test real JNAP requests
///
///
void main() {
  HttpOverrides.global = MyHttpOverrides();

  group('local JNAP', () {
    test('test JNAP send', () async {
      Jnap.init(
        baseUrl: 'https://10.201.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46YWRtaW4=',
        authType: AuthType.basic,
      );
      await Jnap.instance.send(action: GetDeviceInfo.instance);
    });

    test('test JNAP transaction', () async {
      Jnap.init(
        baseUrl: 'https://10.201.1.1',
        path: '/JNAP/',
        extraHeaders: {},
        auth: 'YWRtaW46YWRtaW4=',
        authType: AuthType.basic,
      );
      await Jnap.instance.transaction(
        transactionBuilder: JNAPTransactionBuilder(
          commands: [
            MapEntry(GetDeviceInfo.instance, {}),
            MapEntry(GetWANStatus.instance, {}),
          ],
        ),
      );
    });
  });

  group('remote JNAP', () {
    test('test JNAP send', () async {
      const sessionId = 'FB2246D2-2429-4278-85C9-C5B1CD2E1D73';
      Jnap.init(
        baseUrl: 'https://qa.cloud1.linksyssmartwifi.com',
        path:
            '/cloud/v1/guardians/remote-assistances/sessions/$sessionId/actions/jnap/',
        extraHeaders: {
          'X-Linksys-Client-Type-Id': 'BB426FA7-16A9-5C1C-55AF-63A4167B26AD'
        },
        auth:
            'AGENT0879559D914540F18B4DD61485F6C6410854E66E6F03447481EC27B9525',
        authType: AuthType.token,
      );
      await Jnap.instance.send(action: GetDevices.instance);
    });

    test('test JNAP transaction', () async {
      const sessionId = 'FB2246D2-2429-4278-85C9-C5B1CD2E1D73';
      Jnap.init(
        baseUrl: 'https://qa.cloud1.linksyssmartwifi.com',
        path:
            '/cloud/v1/guardians/remote-assistances/sessions/$sessionId/actions/jnap/',
        extraHeaders: {
          'X-Linksys-Client-Type-Id': 'BB426FA7-16A9-5C1C-55AF-63A4167B26AD'
        },
        auth:
            'AGENT0879559D914540F18B4DD61485F6C6410854E66E6F03447481EC27B9525',
        authType: AuthType.token,
      );
      await Jnap.instance.transaction(
        transactionBuilder: JNAPTransactionBuilder(
          commands: [
            MapEntry(GetDevices.instance, {}),
            MapEntry(GetWANStatus.instance, {}),
          ],
        ),
      );
    });
  });
}
