import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  testWidgets(
      "Given the user opens the app"
      "When the user is shown the homepage"
      "Then the user is shown the homepage title", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());
    expect(find.text("Flutter Calorie Tracker App"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given the user opens the app"
      "When the user is shown the homepage"
      "Then the user is shown the homepage subtitle",
      (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());
    expect(find.text("Welcome To Calorie Tracker App!"), findsOneWidget);
  });

  testWidgets(
      "Given the user opens the app"
      "When the user is shown the homepage"
      "Then the user is shown the Day View button",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    ButtonStyleButton dayViewButton =
        ElevatedButton(onPressed: () {}, child: Text("Day View Screen"));

    expect(find.text("Day View Screen"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given the user opens the app"
      "When the user is shown the homepage"
      "Then the user is shown the History button", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    ButtonStyleButton dayViewButton =
        ElevatedButton(onPressed: () {}, child: Text("History Screen"));

    expect(find.text("History Screen"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given the user opens the app"
      "When the user is shown the homepage"
      "Then the user is shown the Setting button", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    ButtonStyleButton dayViewButton =
        ElevatedButton(onPressed: () {}, child: Text("Settings Screen"));

    expect(find.text("Settings Screen"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
