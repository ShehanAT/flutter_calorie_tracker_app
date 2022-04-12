import "package:calorie_tracker_app/src/model/food_track_task.dart";
import "package:flutter_test/flutter_test.dart";

main() {
  group("foodTrackTask is not null", () {
    test("food_name is not null", () {
      FoodTrackTask foodTrackTask = FoodTrackTask(
          food_name: "chickpeas",
          calories: 0,
          carbs: 0,
          protein: 0,
          fat: 0,
          mealTime: "breakfast",
          createdOn: DateTime.now(),
          grams: 0);
      expect(foodTrackTask.food_name, equals("chickpeas"));
    });
  });
}
