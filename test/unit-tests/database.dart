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
        "DatabaseService.getAllFoodTrackData() should return non-empty list of foodTrack instances",
        () async {
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
        "First element of the list returned by DatabaseService.getAllFoodTrackData() should contain the required values to create FoodTrackTask instance",
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
      expect(foodTrack.food_name, isA<String>());
      expect(foodTrack.calories, isA<num>());
      expect(foodTrack.carbs, isA<num>());
      expect(foodTrack.protein, isA<num>());
      expect(foodTrack.fat, isA<num>());
      expect(foodTrack.mealTime, isA<String>());
      expect(foodTrack.createdOn, isA<DateTime>());
      expect(foodTrack.grams, isA<num>());
    });
  });
}
