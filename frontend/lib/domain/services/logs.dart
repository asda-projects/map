import 'package:logging/logging.dart';

class AppLogger {
  static Level _globalLoggerLevel = Level.ALL;

  // You can initialize with a specific level if needed
  AppLogger({Level loggerLevel = Level.ALL}) {
    _globalLoggerLevel = loggerLevel;
  }

  // Method to set the global logger level
  static void setGlobalLoggerLevel(Level level) {
    _globalLoggerLevel = level;
  }

  void debug(String message) {
    if (_globalLoggerLevel <= Level.ALL) {
      print(message);
    }
  }

  void info(String message) {
    if (_globalLoggerLevel <= Level.INFO) {
      print(message);
    }
  }

  void warning(String message) {
    if (_globalLoggerLevel <= Level.WARNING) {
      print(message);
    }
  }

  void severe(String message) {
    if (_globalLoggerLevel <= Level.SEVERE) {
      print(message);
    }
  }

  // Additional methods for other logging levels can be added here
}
