import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calorie_tracker_app/src/model/food_model.dart';

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

  Future newFoodTrackData(String name, double calories, double carbs,
      double fat, double protein, String mealTime, double grams) async {
    return await foodTrackCollection
        .doc(uid)
        .collection('foodTracks')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'food_name': name,
      'calories': calories,
      'carbs': carbs,
      'fat': fat,
      'protein': protein,
      'mealTime': mealTime,
      'created_on': DateTime.now(),
      'grams': grams,
    });
  }

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
    print(deleteEntry.toString());
    return await foodTrackCollection
        .doc(deleteEntry.createdOn.millisecondsSinceEpoch.toString())
        .delete();
  }

  Future<void> deleteScan(String productID) async {
    await foodTrackCollection
        .doc(uid)
        .collection('foodTracks')
        .doc(productID)
        .delete();
  }

  List<FoodTrackTask> _scanListFromSnapshot(QuerySnapshot snapshot) {
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
    return foodTrackCollection.snapshots().map(_scanListFromSnapshot);
  }

  Future<List<dynamic>> getAllFoodTrackData() async {
    QuerySnapshot snapshot = await foodTrackCollection.get();
    List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();
    return result;
  }

  Future<String> getFoodTrackData(String uid) async {
    DocumentSnapshot snapshot = await foodTrackCollection.doc(uid).get();
    print("getFoodTrackData" + snapshot.toString());
    return snapshot.toString();
  }
}
