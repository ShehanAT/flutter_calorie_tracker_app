import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addFoodTrackEntry(FoodTrackTask food) async {}

  Future deleteFoodTrackEntry(FoodTrackTask deleteEntry) async {}

  List<FoodTrackTask> _scanListFromSnapshot(QuerySnapshot snapshot) {}

  Stream<List<FoodTrackTask>> get foodTracks {}

  Future<List<dynamic>> getAllFoodTrackData() async {}

  Future<String> getFoodTrackData(String uid) async {}
}
