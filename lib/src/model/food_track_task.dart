import 'package:json_annotation/json_annotation.dart';
import 'package:calorie_tracker_app/src/utils/uuid.dart';
import 'package:firebase_database/firebase_database.dart';

@JsonSerializable()
class FoodTrackTask {
  

  FoodTrackTask({
   
  });

  factory FoodTrackTask.fromSnapshot(DataSnapshot snap) => FoodTrackTask(
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
   
    };
  }

  FoodTrackTask.fromJson(Map<dynamic, dynamic> json)
      :;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
      
      };
}
