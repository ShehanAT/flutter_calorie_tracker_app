import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() {
  testWidgets(
      "Given user opens the app"
      "When user taps the History Screen button"
      "Then the History Screen is shown", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder historyButton = find.text("History Screen");
    await tester.tap(historyButton, warnIfMissed: true);
    await tester.pumpAndSettle();

    expect(find.text("History Screen"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
