import 'package:calorie_tracker_app/src/page/day-view/showDatePicker.dart';
import 'package:calorie_tracker_app/src/page/day-view/addFoodButton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

void main() {
  testWidgets("ShowDatePicker widget should render successfully",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    await tester.pumpWidget(ShowDatePicker());

    expect(find.byType(ShowDatePicker), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("AddFood button should open Add Food modal",
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    await tester.pumpWidget(AddFoodButtonWidget());
    await tester.tap(find.byKey(ValueKey("add_food_modal_button")),
        warnIfMissed: true);

    await tester.pumpAndSettle();

    expect(find.byKey(ValueKey("add_food_modal")), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });
}
