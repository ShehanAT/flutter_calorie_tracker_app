import 'dart:math';

import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() {
  testWidgets("Navigate to Day View Screen", (WidgetTester tester) async {
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

  testWidgets("Add Food modal opens when tapping Add Food button",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    IconButton settingsButton = IconButton(
      key: Key('add_food_modal_button'),
      icon: Icon(Icons.add_box),
      iconSize: 25,
      color: Colors.white,
      onPressed: () {},
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("add_food_modal_button")),
        warnIfMissed: true);

    await tester.pumpAndSettle();

    expect(find.byKey(ValueKey("add_food_modal")), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      "Add Food modal creates FoodTrack instance after submitting Add Food form",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder dayViewButton = find.text("Day View Screen");
    await tester.tap(dayViewButton, warnIfMissed: true);

    IconButton settingsButton = IconButton(
      key: Key('add_food_modal_button'),
      icon: Icon(Icons.add_box),
      iconSize: 25,
      color: Colors.white,
      onPressed: () {},
    );

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
        find.byKey(ValueKey("add_food_modal_fat_field")), "20");
    await tester.enterText(
        find.byKey(ValueKey("add_food_modal_grams_field")), "20");

    await tester.tap(find.byKey(ValueKey("add_food_modal_submit")));

    await tester.pumpAndSettle();

    expect(find.text("Cheese").at(0), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Pressing Left Arrow Button Changes Date to Yesterday",
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
      "Pressing Left Arrow Button Then Right Arrow Button Changes Date to Today",
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

  testWidgets("Pressing Food Tile Delete Button Removes Tile From List",
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
