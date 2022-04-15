import "package:calorie_tracker_app/src/services/database.dart";
import "package:calorie_tracker_app/src/utils/constants.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';

void main() {
  DatabaseService databaseService;

  group('testing DatabaseService', () {
    test(
        "Given that we instantiate a DatabaseService instance"
        "When we fetch all foodTrack instances from the Firestore database"
        "Then retrieved List should not be empty", () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      databaseService =
          DatabaseService(uid: DATABASE_UID, currentDate: DateTime.now());

      List<dynamic> getAllFoodTrackData =
          await databaseService.getAllFoodTrackData();

      print(getAllFoodTrackData);
      expect(getAllFoodTrackData.length > 0, true);
    });

    test(
        "Given that we instantiate a DatabaseService instance"
        "When we fetch all foodTrack instances from the Firestore database and instantiate a FoodTrackTask instance using the first element from that List"
        "Then the FoodTrackTask instance should contain should valid fields",
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      databaseService =
          DatabaseService(uid: DATABASE_UID, currentDate: DateTime.now());

      List<dynamic> getAllFoodTrackData =
          await databaseService.getAllFoodTrackData();

      dynamic firstFoodTrack = getAllFoodTrackData[0];
      FoodTrackTask foodTrack = FoodTrackTask(
          food_name: firstFoodTrack["food_name"],
          calories: firstFoodTrack["calories"],
          carbs: firstFoodTrack["carbs"],
          protein: firstFoodTrack["protein"],
          fat: firstFoodTrack["fat"],
          mealTime: firstFoodTrack['mealTime'],
          createdOn: firstFoodTrack['createdOn'].toDate(),
          grams: firstFoodTrack["grams"]);

      expect(foodTrack.food_name.isEmpty, false);
      expect(foodTrack.calories.isNaN, false);
      expect(foodTrack.carbs.isNaN, false);
      expect(foodTrack.protein.isNaN, false);
      expect(foodTrack.fat.isNaN, false);
      expect(foodTrack.mealTime.isEmpty, false);
      expect(foodTrack.createdOn.isAfter(DateTime.now()), false);
      expect(foodTrack.grams.isNaN, false);
    });
  });
}
