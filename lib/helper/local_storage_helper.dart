import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<void> saveFavorites(List<String> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favorites);
  }

  static Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  static Future<bool?> getDailyReminderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dailyReminderStatus');
  }

  static Future<void> saveDailyReminderStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dailyReminderStatus', value);
  }
}
