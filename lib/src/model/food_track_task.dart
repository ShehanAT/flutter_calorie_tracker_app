import 'package:json_annotation/json_annotation.dart';
import 'package:calorie_tracker_app/src/utils/uuid.dart';
import 'package:calorie_tracker_app/src/model/food_model.dart';
import 'package:firebase_database/firebase_database.dart';

@JsonSerializable()
class FoodTrackTask {
  String id;
  String food_name;
  num calories;
  num carbs;
  num fat;
  num protein;
  String mealTime;
  DateTime createdOn;
  num grams;

  FoodTrackTask({
    required this.food_name,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.mealTime,
    required this.createdOn,
    required this.grams,
    String? id,
  }) : this.id = id ?? Uuid().generateV4();

  factory FoodTrackTask.fromSnapshot(DataSnapshot snap) => FoodTrackTask(
      food_name: snap.child('food_name').value as String,
      calories: snap.child('calories') as int,
      carbs: snap.child('carbs').value as int,
      fat: snap.child('fat').value as int,
      protein: snap.child('protein').value as int,
      mealTime: snap.child('mealTime').value as String,
      grams: snap.child('grams').value as int,
      createdOn: snap.child('createdOn').value as DateTime);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mealTime': mealTime,
      'food_name': food_name,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'grams': grams,
      'createdOn': createdOn
    };
  }

  FoodTrackTask.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        mealTime = json['mealTime'],
        calories = json['calories'],
        createdOn = DateTime.parse(json['createdOn']),
        food_name = json['food_name'],
        carbs = json['carbs'],
        fat = json['fat'],
        protein = json['protein'],
        grams = json['grams'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': id,
        'mealTime': mealTime,
        'createdOn': createdOn.toString(),
        'food_name': food_name,
        'calories': calories,
        'carbs': carbs,
        'fat': fat,
        'protein': protein,
        'grams': grams,
      };
}
