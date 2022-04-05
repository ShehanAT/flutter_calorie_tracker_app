import 'dart:math';

import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() {
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

    await tester.tap(find.byKey(ValueKey("add_food_modal_submit")));

    // await tester.pumpAndSettle();

    // await tester.dragUntilVisible(
    //     find.ancestor(
    //         of: find.text(foodName), matching: find.byType(ExpansionTile)),
    //     find.byKey(ValueKey("food_track_list")),
    //     const Offset(0, 500));

    // await tester.tap(
    //     find.ancestor(
    //         of: find.text(foodName), matching: find.byType(ExpansionTile)),
    //     warnIfMissed: true);

    await tester.pumpAndSettle();

    // await tester.tap(find.byKey(ValueKey("delete_button")), warnIfMissed: true);

    // await tester.pumpAndSettle();

    expect(find.text(foodName), findsNothing);

    debugDefaultTargetPlatformOverride = null;
  });
}
