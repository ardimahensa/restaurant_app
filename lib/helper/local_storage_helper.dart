import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveDailyReminderStatus(bool isScheduled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isScheduled', isScheduled);
  }

  static Future<bool> getDailyReminderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isScheduled') ?? false;
  }
}
