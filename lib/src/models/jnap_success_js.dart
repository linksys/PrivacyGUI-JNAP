import 'dart:js_interop';

import 'jnap_result.dart';

@JS()
@anonymous
extension type JNAPSuccessJS._(JSObject _) implements JSObject {
  external factory JNAPSuccessJS({
    JSString result,
    JSAny? output,
    JSArray? sideEffects,
  });

  external JSString get result;
  external JSAny? get output;
  external JSArray? get sideEffects;
}

JNAPSuccessJS jnapSuccessToJS(JNAPSuccess success) {
  return JNAPSuccessJS(
    result: success.result.toJS,
    output: success.output.jsify(),
    sideEffects: success.sideEffects?.map((e) => e.toJS).toList().toJS,
  );
}
