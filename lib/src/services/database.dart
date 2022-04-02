import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final DateTime currentDate;
  DatabaseService({required this.uid, required this.currentDate});

  final DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final DateTime weekStart = DateTime(2020, 09, 07);
  // collection reference
  final CollectionReference foodTrackCollection =
      FirebaseFirestore.instance.collection('foodTracks');

  Future addFoodTrackEntry(FoodTrackTask food) async {
    return await foodTrackCollection
        .doc(food.createdOn.millisecondsSinceEpoch.toString())
        .set({
      'food_name': food.food_name,
      'calories': food.calories,
      'carbs': food.carbs,
      'fat': food.fat,
      'protein': food.protein,
      'mealTime': food.mealTime,
      'createdOn': food.createdOn,
      'grams': food.grams
    });
  }

  Future deleteFoodTrackEntry(FoodTrackTask deleteEntry) async {
    return await foodTrackCollection
        .doc(deleteEntry.createdOn.millisecondsSinceEpoch.toString())
        .delete();
  }

  List<FoodTrackTask> _foodTrackListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodTrackTask(
        id: doc.id,
        food_name: doc['food_name'] ?? '',
        calories: doc['calories'] ?? 0,
        carbs: doc['carbs'] ?? 0,
        fat: doc['fat'] ?? 0,
        protein: doc['protein'] ?? 0,
        mealTime: doc['mealTime'] ?? "",
        createdOn: doc['createdOn'].toDate() ?? DateTime.now(),
        grams: doc['grams'] ?? 0,
      );
    }).toList();
  }

  Stream<List<FoodTrackTask>> get foodTracks {
    return foodTrackCollection.snapshots().map(_foodTrackListFromSnapshot);
  }

  Future<List<dynamic>> getAllFoodTrackData() async {
    QuerySnapshot snapshot = await foodTrackCollection.get();
    List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();
    return result;
  }

  Future<String> getFoodTrackData(String uid) async {
    DocumentSnapshot snapshot = await foodTrackCollection.doc(uid).get();
    return snapshot.toString();
  }

  Future<FoodTrackTask> loadFoodTrackEntryToDatabase() async {
    try {
      Future.delayed(Duration(seconds: 2));
      return FoodTrackTask(
          food_name: "Oatmeal",
          calories: 20,
          carbs: 20,
          protein: 20,
          fat: 20,
          mealTime: "Lunch",
          createdOn: DateTime.now(),
          grams: 20);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
