import 'package:intl/intl.dart';

enum LogLevel { info, warning, error }

class Logger {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  static void log(
    String message, {
    LogLevel level = LogLevel.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final timestamp = _dateFormat.format(DateTime.now());
    final levelString = level.toString().split('.').last.toUpperCase();

    final logMessage = '[$timestamp] [$levelString] $message';

    if (error != null) {
      print('$logMessage\nError: $error');
    } else {
      print(logMessage);
    }

    if (stackTrace != null) {
      print('Stack Trace: $stackTrace');
    }
  }

  static void info(String message) {
    log(message, level: LogLevel.info);
  }

  static void warning(String message) {
    log(message, level: LogLevel.warning);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: LogLevel.error, error: error, stackTrace: stackTrace);
  }
}
