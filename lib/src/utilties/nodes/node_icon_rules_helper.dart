import 'package:collection/collection.dart';
import 'package:jnap/src/utilties/extension.dart';
import 'package:jnap/src/utilties/nodes/icon_device_category.dart';
import 'package:jnap/src/utilties/nodes/node_icon_rules.dart';

String routerIconTestByModel(
    {required String modelNumber, String? hardwareVersion}) {
  if (modelNumber.isEmpty) {
    return 'node';
  }
  final data = {
    'model': {
      'deviceType': 'Infrastructure',
      'manufacturer': 'Linksys',
      'modelNumber': modelNumber,
      'hardwareVersion': hardwareVersion ?? '1',
    }
  };
  final result = iconTest(data);
  return result == 'genericDevice' ? 'routerLn12' : result;
}

String routerIconTest(Map<String, dynamic> target) {
  return iconTest(target);
}

String deviceIconTest(Map<String, dynamic> target) {
  const regex =
      r'^.*((digitalMediaPlayer)|(phone)|(android)|(iphone)|(mobile)|(desktop)|(laptop)|(windows)|(mac)|(pc)|(tv)|(vacauum)|(plug)|(gameConsole)|(generic)|(appleHomepod)).*$';
  final test = iconTest(target);
  final check = RegExp(regex, caseSensitive: false)
      .firstMatch(test)
      ?.group(1)
      ?.toLowerCase();
  return switch (check) {
    'tv' => IconDeviceCategory.tv,
    'digitalmediaplayer' || 'applehomepod' => IconDeviceCategory.speaker,
    'plug' => IconDeviceCategory.plug,
    'vacauum' => IconDeviceCategory.vacuum,
    'gameconsole' => IconDeviceCategory.gameConsole,
    'phone' || 'android' || 'iphone' || 'mobile' => IconDeviceCategory.phone,
    'desktop' ||
    'laptop' ||
    'windows' ||
    'mac' ||
    'pc' =>
      IconDeviceCategory.computer,
    _ => IconDeviceCategory.unknown
  }
      .name;
}

///
/// Please use #deviceIconTest or routerIconTest instead
///
String iconTest(Map<String, dynamic> target) {
  final result = iconRules.firstWhereOrNull((iconRule) {
    List<bool> testResults = [];
    doAttributesTests(
        target, Map<String, dynamic>.from(iconRule['test']), testResults);
    return !testResults.contains(false);
  });
  if (result == null) {
    return mapIcons('genericDevice');
  }
  final iconClass = result['iconClass'];

  if (iconClass is Map<String, dynamic>) {
    final modelNumber = target.getValueByPath<String>(iconClass['lookup']);
    final capitalized = modelNumber?.toLowerCase().capitalize();
    final routerIcon = 'router$capitalized';
    return mapIcons(routerIcon, fallback: routerIcon);
  } else if (iconClass is String) {
    return mapIcons(iconClass, fallback: iconClass);
  }
  return mapIcons(result['iconClass'] as String? ?? 'genericDevice');
}

doAttributesTests(Map<String, dynamic> target, Map<String, dynamic> test,
    List<bool> results) {
  if (isPlainObject(test)) {
    test.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        doAttributesTests(
            target[key] is Map<String, dynamic> ? target[key] : {}, value, results);
      } else {
        final regex = RegExp('$value', caseSensitive: false);
        bool isMatch = regex.hasMatch(target[key]?.toString() ?? '');
        results.add(isMatch);
      }
    });
  } else {
    final result = !test.entries.any((element) {
      if (element.value == null) {
        return true;
      }
      final regex = RegExp('${element.value}', caseSensitive: false);
      bool isMatch = regex.hasMatch(target[element.key]?.toString() ?? '');
      return !isMatch;
    });
    results.add(result);
  }
}

bool isPlainObject(Map<String, dynamic> json) {
  return json.values.any((element) => element is Map<String, dynamic>);
}