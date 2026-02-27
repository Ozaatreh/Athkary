import 'package:shared_preferences/shared_preferences.dart';

class TasbeehStorageService {
  static const String _counterPrefix = "tasbeeh_counter_";
  static const String _notificationPrefix = "tasbeeh_notification_";

  static Future<void> saveCounter(int index, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("$_counterPrefix$index", value);
  }

  static Future<int> loadCounter(int index) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("$_counterPrefix$index") ?? 0;
  }

  static Future<void> resetCounter(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("$_counterPrefix$index", 0);
  }

  static Future<void> saveNotificationState(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("$_notificationPrefix$index", value);
  }

  static Future<bool> loadNotificationState(int index) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("$_notificationPrefix$index") ?? false;
  }
}