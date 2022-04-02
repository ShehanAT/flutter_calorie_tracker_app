import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  testWidgets("Find homepage title", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());
    expect(find.text("Flutter Calorie Tracker App"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Find homepage subtitle", (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());
    expect(find.text("Welcome To Calorie Tracker App!"), findsOneWidget);
  });

  testWidgets("Find Day View Button", (WidgetTester tester) async {
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

  testWidgets("Find History Screen Button", (WidgetTester tester) async {
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

  testWidgets("Find Setting Screen Button", (WidgetTester tester) async {
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
