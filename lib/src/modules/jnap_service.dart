import 'package:collection/collection.dart';

///
/// latestVersion = 0 means not supported this service
/// Service path, default is the same as service
/// {prefix}{path}/{name}{version}
/// example: http://linksys.com/jnap/core/Core
///
class JNAPService {
  static final String prefix = 'http://linksys.com/jnap/';

  final String name;
  final String path;
  final List<JNAPServiceSupported> supportedServices;
  int _latestVersion = 0;
  int get latestVersion => _latestVersion;

  JNAPService({
    required this.name,
    required this.path,
    this.supportedServices = const [],
  });

  void updateVersion(int version) {
    _latestVersion = version;
  }

  String get servicePath => '$prefix$path';
  String get fullServiceName => '$servicePath$name';
  String get latestServiceName =>
      '$fullServiceName${_latestVersion == 1 ? '' : _latestVersion}';

  bool isSupportService(String name) {
    final supportCheck =
        supportedServices.firstWhereOrNull((element) => element.name == name);
    return supportCheck?.isSupported(_latestVersion) ?? false;
  }
}

class JNAPServiceSupported {
  final String name;
  final int supportedVersion;

  JNAPServiceSupported({
    required this.name,
    required this.supportedVersion,
  });

  bool isSupported(int version) {
    return version >= supportedVersion;
  }
}
