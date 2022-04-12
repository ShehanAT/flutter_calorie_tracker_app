import 'dart:math';

import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:calorie_tracker_app/src/page/day-view/showDatePicker.dart';

void main() {
  testWidgets(
      "Given user opens the app"
      "When user taps the Day View Screen button"
      "Then Day View Screen is shown", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);
    await tester.pumpAndSettle();

    expect(find.text("Today"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given user opens the Day View screen"
      "When user taps the Add Food button"
      "Then Add Food modal opens", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("add_food_modal_button")),
        warnIfMissed: true);

    await tester.pumpAndSettle();

    expect(find.byKey(ValueKey("add_food_modal")), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given user opens the Day View Screen"
      "When user submits the Add Food modal form"
      "Then a new FoodTrack instance is created", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("add_food_modal_button")),
        warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_food_name_field")), "Cheese");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_calorie_field")), "500");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_carbs_field")), "15");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_protein_field")), "25");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_fat_field")), "20");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_grams_field")), "20");

    await tester.tap(find.byKey(ValueKey("add_food_modal_submit")));

    await tester.pumpAndSettle();

    expect(find.text("Cheese").at(0), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given user opens the Day View screen"
      "When the user taps the Left Arrow Button"
      "Then DatePicker's value changes to Yesterday",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("left_arrow_button")),
        warnIfMissed: true);
    await tester.pumpAndSettle();

    expect(find.text("Yesterday"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given user opens the Day View screen"
      "When the user taps the Left Arrow Button then Right Arrow Button"
      "Then DatePicker's value changes from Yesterday to Today",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("left_arrow_button")),
        warnIfMissed: true);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("right_arrow_button")),
        warnIfMissed: true);
    await tester.pumpAndSettle();

    expect(find.text("Today"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Given user opens the Day View Screen"
      "When the user taps a Food Tile Delete Button"
      "Then that Food Tile is removed from the Food Track List",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("add_food_modal_button")),
        warnIfMissed: true);

    await tester.pumpAndSettle();

    Random random = new Random();
    int randomNumber = random.nextInt(100);
    String foodName = "Cheese" + randomNumber.toString();

    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_food_name_field")), foodName);
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_calorie_field")), "500");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_carbs_field")), "15");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_protein_field")), "25");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_fat_field")), "20");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_grams_field")), "20");

    await tester.tap(find.byKey(ValueKey("add_food_modal_submit")));

    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
        find.ancestor(
            of: find.text(foodName), matching: find.byType(ExpansionTile)),
        find.byKey(ValueKey("food_track_list")),
        const Offset(0, 500));

    await tester.tap(
        find.ancestor(
            of: find.text(foodName), matching: find.byType(ExpansionTile)),
        warnIfMissed: true);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("delete_button")), warnIfMissed: true);

    await tester.pumpAndSettle();

    expect(find.text(foodName), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });
}
