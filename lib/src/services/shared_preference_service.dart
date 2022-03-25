import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String sharedPreferenceDarkThemeKey = 'DARKTHEME';

  static Future<bool> setDarkTheme({required bool to}) async {
    return _sharedPreferences.setBool(sharedPreferenceDarkThemeKey, to);
  }

  static bool getDarkTheme() {
    return _sharedPreferences.getBool(sharedPreferenceDarkThemeKey) ?? true;
  }
}
