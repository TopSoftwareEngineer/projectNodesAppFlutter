import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class SharedPreferencesUtil {

  /// Method to init Shared preferences async, ONLY CALL THIS ONE TIME
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static int? getInt(String key) {
    return prefs.getInt(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static String? getString(String key)  {
    return prefs.getString(key);
  }

  static Future<bool> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<bool> removeItem(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<bool> removeAllItem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
