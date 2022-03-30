import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:calorie_tracker_app/src/page/day-view/day-view.dart';
import 'package:calorie_tracker_app/src/page/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'src/page/history/history_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:calorie_tracker_app/src/providers/theme_notifier.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:calorie_tracker_app/helpers/theme.dart';
import 'package:calorie_tracker_app/routes/router.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesService().init();
  runApp(CalorieTrackerApp());
}

class CalorieTrackerApp extends StatefulWidget {
  @override
  _CalorieTrackerAppState createState() => _CalorieTrackerAppState();
}

class _CalorieTrackerAppState extends State<CalorieTrackerApp> {
  @override
  Widget build(BuildContext context) {}

  void hideKeyboard(BuildContext context) {}
}

class Homepage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {}

  @override
  State<StatefulWidget> createState() {}
}

class _Homepage extends State<Homepage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {}
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {}
}
