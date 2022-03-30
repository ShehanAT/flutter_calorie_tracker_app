import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> init() async {}

  static String sharedPreferenceDarkThemeKey = 'DARKTHEME';

  static Future<bool> setDarkTheme({required bool to}) async {}

  static bool getDarkTheme() {}
}
