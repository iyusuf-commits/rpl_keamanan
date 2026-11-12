import 'package:flutter/foundation.dart';

/// Class Logger untuk logging terstruktur. Log hanya tampil di mode debug.
class Logger {
  static void debug(String message) {
    if (kDebugMode) print('[DEBUG] $message');
  }

  static void info(String message) {
    if (kDebugMode) print('[INFO] $message');
  }

  static void warning(String message) {
    if (kDebugMode) print('[WARNING] $message');
  }

  static void error(String message) {
    if (kDebugMode) print('[ERROR] $message');
  }
}