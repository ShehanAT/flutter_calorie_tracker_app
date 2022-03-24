import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String sharedPreferenceFirstLaunchKey = 'FIRSTLAUNCH';
  static String sharedPreferenceDarkThemeKey = 'DARKTHEME';

  static Future<bool> setFirstLaunch({required bool to}) async {
    return _sharedPreferences.setBool(sharedPreferenceFirstLaunchKey, to);
  }

  static Future<bool> setDarkTheme({required bool to}) async {
    return _sharedPreferences.setBool(sharedPreferenceDarkThemeKey, to);
  }

  static bool getFirstLaunch() {
    // The "??" operator means "if null".
    // This means: if '_sharedPreferences.getBool(sharedPreferenceFirstLaunchKey)' is null then return true, else return former value
    return _sharedPreferences.getBool(sharedPreferenceFirstLaunchKey) ?? true;
  }

  static bool getDarkTheme() {
    return _sharedPreferences.getBool(sharedPreferenceDarkThemeKey) ?? true;
  }
}
