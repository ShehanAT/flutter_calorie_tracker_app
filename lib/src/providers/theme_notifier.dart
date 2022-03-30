import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';

class DarkThemeProvider with ChangeNotifier {
  // The 'with' keyword is similar to mixins in JavaScript, in that it is a way of reusing a class's fields/methods in a different class that is not a super class of the initial class.

  bool get darkTheme {}

  set dartTheme(bool value) {}
}
