import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:calorie_tracker_app/src/page/day-view/showDatePicker.dart';

void main() {
  testWidgets("Test that the ShowDatePicker widget is able to render",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    await tester.pumpWidget(ShowDatePicker());

    expect(find.byType(ShowDatePicker), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });
}
