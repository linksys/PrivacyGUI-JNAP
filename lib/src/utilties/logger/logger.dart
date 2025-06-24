// ignore_for_file: avoid_print

import 'package:jnap/logger.dart';
import 'package:logger/logger.dart';

typedef LoggerHook = void Function(OutputEvent event);
class LoggerHooks {
  static final List<LoggerHook> _hooks = [];

  static void addHook(LoggerHook hook) {
    _hooks.add(hook);
  }

  static void removeHook(LoggerHook hook) {
    _hooks.remove(hook);
  }
}
/// A singleton logger class that provides a single instance of Logger throughout the app.
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late final Logger _logger;

  /// Private constructor
  AppLogger._internal() {
    _logger = Logger(
      filter: ProductionFilter(),
      printer: SimplePrinter(
        printTime: true,
        colors: false,
      ),
      output: _CustomOutput(),
    );
  }

  /// Returns the singleton instance of AppLogger
  static AppLogger get instance => _instance;

  /// Returns the underlying Logger instance
  Logger get logger => _logger;

}

class _CustomOutput extends LogOutput {
  @override
  void output(OutputEvent event) async {
    for (var line in event.lines) {
      // Print every log message on the console in debug mode
      if (!LoggerConfig.isRelease) {
        print(line);
      }
    }
    if (LoggerConfig.level.value >= event.level.value) {
      for (var hook in LoggerHooks._hooks) {
        hook(event);
      }
    }
  }
}

// Global logger instance for easy access
final logger = AppLogger.instance.logger;











