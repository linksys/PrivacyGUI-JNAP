
import 'package:jnap/logger.dart';
import 'package:jnap/src/config.dart';

class BenchMarkLogger {
  final String name;
  final bool recordOnly;
  late DateTime _start;
  late DateTime _end;

  BenchMarkLogger({
    required this.name,
    this.recordOnly = false,
  });

  void start() {
    _start = DateTime.now();
    if (!Config.isRelease && !recordOnly) {
      logger.d('[BenchMark] - $name: start at <$_start>');
    }
  }

  ///
  /// @return milliseconds
  ///
  int end() {
    _end = DateTime.now();
    int delta = _calcuteDeltaTime();
    if (!Config.isRelease && !recordOnly) {
      logger.d(
          '[BenchMark] - $name: end at <$_end>, delta time is <$delta>');
    }
    return delta;
  }

  int _calcuteDeltaTime() {
    return _end.millisecondsSinceEpoch - _start.millisecondsSinceEpoch;
  }
}
