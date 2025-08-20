import 'dart:js_interop';
import 'dart:js_interop_unsafe';

// Import the main library, which exports all necessary components.
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jnap/jnap.dart';
import 'package:jnap/utils.dart';

// Top-level function for init
void _init(JSObject options) {
  final dartOptions = options.dartify() as Map;
  final authTypeStr = dartOptions['authType'] as String? ?? 'basic';
  final authType = authTypeStr == 'token' ? AuthType.token : AuthType.basic;

  Jnap.init(
    baseUrl: dartOptions['baseUrl'] as String,
    path: dartOptions['path'] as String? ?? '/JNAP/',
    extraHeaders:
        (dartOptions['extraHeaders'] as Map? ?? {}).cast<String, String>(),
    auth: dartOptions['auth'] as String,
    authType: authType,
  );

  _betterActions(JSArray());
}

// Top-level function for updateAuth
void _updateAuth(JSObject options) {
  final dartOptions = options.dartify() as Map;
  final authTypeStr = dartOptions['authType'] as String?;
  final authType = authTypeStr == null
      ? null
      : (authTypeStr == 'token' ? AuthType.token : AuthType.basic);

  Jnap.updateAuth(
    auth: dartOptions['auth'] as String?,
    authType: authType,
  );
}

// Top-level function for updateUrl
void _updateUrl(JSObject options) {
  final dartOptions = options.dartify() as Map;
  Jnap.updateUrl(
    baseUrl: dartOptions['baseUrl'] as String,
    path: dartOptions['path'] as String?,
  );
}

// Top-level function for send
Future<JSObject> _send(String action, JSObject request) async {
  final requestData = (request.dartify() as Map).cast<String, dynamic>();

  final jnapAction = JNAPAction.getVersionedActionJS(action);
  if (jnapAction == null) {
    throw Exception('Action not found: $action');
  }
  final result =
      await Jnap.instance.send(action: jnapAction, data: requestData);
  return result.toMap().jsify() as JSObject;
}

// Top-level function for transaction
Future<JSObject> _transaction(JSArray commands) async {
  final builder = JNAPTransactionBuilder();
  final commandList = commands.dartify() as List;

  for (final command in commandList) {
    final cmdMap = command.dartify() as Map;
    final action = JNAPAction.getVersionedActionJS(cmdMap['action'] as String);
    if (action == null) {
      throw Exception('Action not found: ${cmdMap['action']}');
    }
    final request = (cmdMap['request'] as Map? ?? {}).cast<String, dynamic>();
    builder.add(action, data: request);
  }

  final result = await Jnap.instance.transaction(transactionBuilder: builder);
  return result.toMap().jsify() as JSObject;
}

// Top-level function for betterActions
void _betterActions(JSArray services) {
  final serviceList = JNAPServiceList();
  final dartServices = (services.dartify() as List).cast<String>();
  serviceList.betterActions(dartServices);

  // expose to JS
  final jnapApi = globalContext['jnap'] as JSObject;

  // collect all actions and transform to versioned action and expose to JS
  final versionedActions =
      JNAPAction.all.map((action) => (action.id, action.command)).toList();

  // Transform versioned actions to JSObject
  final actions = JSObject();
  for (final action in versionedActions) {
    actions[action.$1] = action.$2.toJS;
  }
  jnapApi['actions'] = actions;

  // collect all service with the latest version and expose to JS
  final jnapServices = serviceList.services
      .map((service) => (service.name, service.latestVersion))
      .toList();
  final servicesObj = JSObject();
  final serviceSupportedObj = JSObject();
  for (final service in jnapServices) {
    servicesObj[service.$1] = service.$2.toJS;
  }

  for (final service in serviceList.services) {
    for (final supportedService in service.supportedServices) {
      serviceSupportedObj[supportedService.name] =
          service.isSupportService(supportedService.name).toJS;
    }
  }
  jnapApi['services'] = servicesObj;
  jnapApi['serviceSupported'] = serviceSupportedObj;
}

// Top-level function for get propor Actions with versions
String _getActionsWithVersions(String action) {
  return JNAPAction.getVersionedActionJS(action)?.command ?? '';
}

String _decrypt(String encryptedString) {
  final key = 'adminPassword'.padRight(32, '-'); // 32
  final iv = 'admin'.padRight(16, '-'); // 16
  return decryptAES(encryptedString, key, iv);
}

Future<bool> _pollForRouterReconnected(String serialNumber) {
  return SideEffectHandler(cachedSerialNumber: serialNumber).pollForRouterReconnected();
}

Future<bool> _pollForRouterFullyBootedUp(String serialNumber) {
  return SideEffectHandler(cachedSerialNumber: serialNumber).pollForRouterFullyBootedUp();
}

void setupJnAPI() {
  // Create a new JS Object to act as our API namespace
  // js_util.newObject<JSObject>() is replaced by JSObject() constructor
  final jnapApi = JSObject();

  // Attach the Dart functions to the JS object, wrapping them with allowInterop
  // js_util.allowInterop is replaced by Function.toJS
  // js_util.setProperty is replaced by the []= operator (preferred) or .setProperty extension method

  // For functions that return void or simple Dart types (like String, int, bool)
  // and take JSAny arguments, you can often directly use .toJS on the function reference.
  jnapApi['init'] = _init.toJS;
  jnapApi['version'] = '1.0.2'.toJS;
  jnapApi['updateAuth'] = _updateAuth.toJS;
  jnapApi['updateUrl'] = _updateUrl.toJS;

  // For functions with specific Dart type arguments (like String, JSObject)
  // and/or return specific JSAny types (like JSObject), you need a wrapper function.
  // The wrapper function converts Dart types to JSAny for JS consumption.
  jnapApi['send'] =
      ((String action, JSObject request) => _send(action, request).toJS).toJS;
  jnapApi['transaction'] =
      ((JSArray commands) => _transaction(commands).toJS).toJS;

  jnapApi['betterActions'] = _betterActions.toJS;
  jnapApi['getActionsWithVersions'] = _getActionsWithVersions.toJS;
  jnapApi['decrypt'] = _decrypt.toJS;
  jnapApi['pollForRouterReconnected'] = _pollForRouterReconnected.toJS;
  jnapApi['pollForRouterFullyBootedUp'] = _pollForRouterFullyBootedUp.toJS;

  // Expose the 'jnap' object on the global scope (window)
  // js_util.globalThis is replaced by globalContext property from dart:js_interop
  globalContext['jnap'] = jnapApi;
  print('JNAP API exposed to JavaScript global scope.');
}

void main() {
  // // Create a new JS Object to act as our API namespace
  // final jnapApi = js_util.newObject<JSObject>();

  // // Attach the Dart functions to the JS object, wrapping them with allowInterop
  // js_util.setProperty(jnapApi, 'init', js_util.allowInterop(_init));
  // js_util.setProperty(jnapApi, 'updateAuth', js_util.allowInterop(_updateAuth));
  // js_util.setProperty(
  //     jnapApi,
  //     'send',
  //     js_util.allowInterop(
  //         (String action, JSObject request) => _send(action, request).toJS));
  // js_util.setProperty(jnapApi, 'transaction',
  //     js_util.allowInterop((JSArray commands) => _transaction(commands).toJS));
  // js_util.setProperty(
  //     jnapApi, 'betterActions', js_util.allowInterop(_betterActions));
  // js_util.setProperty(jnapApi, 'getActionsWithVersions',
  //     js_util.allowInterop(_getActionsWithVersions));

  // // Expose the 'jnap' object on the global scope (window)
  // js_util.setProperty(js_util.globalThis, 'jnap', jnapApi);
  setupJnAPI();
}
