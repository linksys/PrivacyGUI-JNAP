
import 'package:collection/collection.dart';
import 'package:jnap/src/utilties/nodes/node_model_map.dart';

dynamic doVelopModelTests({
  required String modelNumber,
  required String hardwareVersion,
  required String paramName,
  String? paramAlt,
}) {
  var out = velopModelMap.firstWhereOrNull((rule) {
    final List<String>? hwVersions = rule['hardwareVersions'];
    return RegExp(rule['pattern'], caseSensitive: false)
            .hasMatch(modelNumber) &&
        ((hwVersions?.indexOf(hardwareVersion) ?? 0) > -1);
  })?[paramName];
  if (paramAlt != null && out == null) {
    out = paramAlt;
  }
  return out;
}

String? treatAsModes({
  required String modelNumber,
  required String hardwareVersion,
}) {
  return doVelopModelTests(
    modelNumber: modelNumber,
    hardwareVersion: hardwareVersion,
    paramName: 'model',
  );
}

String baseModel({
  required String modelNumber,
  required String hardwareVersion,
}) {
  return doVelopModelTests(
    modelNumber: modelNumber,
    hardwareVersion: hardwareVersion,
    paramName: 'baseModel',
  );
}

String seriesModel({
  required String modelNumber,
  required String hardwareVersion,
}) {
  return doVelopModelTests(
    modelNumber: modelNumber,
    hardwareVersion: hardwareVersion,
    paramName: 'seriesModel',
    paramAlt: '',
  );
}

bool isNodeModel({
  required String modelNumber,
  required String hardwareVersion,
}) {
  return treatAsModes(
        modelNumber: modelNumber,
        hardwareVersion: hardwareVersion,
      ) !=
      null;
}

bool isMeshRouter({
  required String modelNumber,
  required String hardwareVersion,
}) {
  return doVelopModelTests(
          modelNumber: modelNumber,
          hardwareVersion: hardwareVersion,
          paramName: 'isMeshRouter') ??
      false;
}

bool isCognitiveMeshRouter({
  required String modelNumber,
  required String hardwareVersion,
}) {
  return doVelopModelTests(
          modelNumber: modelNumber,
          hardwareVersion: hardwareVersion,
          paramName: 'isCognitiveMesh') ??
      false;
}

bool isHorizontalPorts({
  required String modelNumber,
  required String hardwareVersion,
}) =>
    doVelopModelTests(
        modelNumber: modelNumber,
        hardwareVersion: hardwareVersion,
        paramName: 'isHorizontalPorts') ??
    false;

bool isHidingRipRouting({
  required String modelNumber,
  required String hardwareVersion,
}) =>
    doVelopModelTests(
        modelNumber: modelNumber,
        hardwareVersion: hardwareVersion,
        paramName: 'isHidingRipRouting') ??
    false;
