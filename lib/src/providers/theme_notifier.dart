import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';

class DarkThemeProvider with ChangeNotifier {
  bool get darkTheme {
    return SharedPreferencesService.getDarkTheme();
  }

  set dartTheme(bool value) {
    SharedPreferencesService.setDarkTheme(to: value);
    notifyListeners();
  }
}
