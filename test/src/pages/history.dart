import 'package:calorie_tracker_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
// import 'package:flutter_actions/main.dart';

void main() {
  testWidgets("Navigate to Day View Screen", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferencesService().init();
    await tester.pumpWidget(CalorieTrackerApp());

    final Finder historyButton = find.text("History Screen");
    await tester.tap(historyButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));

    expect(find.text("History Screen"), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
