import "package:calorie_tracker_app/src/page/day-view/day-view.dart";
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calorie_tracker_app/src/services/database.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';

class MockDatabase extends Mock implements DatabaseService {}

void main() {
  FoodTrackList foodTrackList;
  MockDatabase _mockDatabase = MockDatabase();

  test("Mock fetching foodTrack instance from database", () async {
    foodTrackList = FoodTrackList(datePicked: DateTime.now());
    when(_mockDatabase.loadFoodTrackEntryToDatabase()).thenAnswer(
        (realInvocation) => Future.value(FoodTrackTask(
            food_name: "Oatmeal",
            calories: 20,
            carbs: 20,
            protein: 20,
            fat: 20,
            mealTime: "Lunch",
            createdOn: DateTime.now(),
            grams: 20)));
    await foodTrackList.loadFromMockDatabase();
    expect(foodTrackList.curFoodTracks.length, 1);
  });
}
