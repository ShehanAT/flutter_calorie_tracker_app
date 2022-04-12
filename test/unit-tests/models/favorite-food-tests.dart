import 'package:calorie_tracker_app/src/model/favorite_foods.dart';
import 'package:calorie_tracker_app/src/model/food.dart';
import 'package:test/test.dart';

void main() {
  group("Testing Model classes", () {
    var favoriteFoods = FavoriteFoods();

    test("A new Food instance should be added to Favorite Foods array", () {
      var newFood = Food(id: 1, food_name: "Sandwich");

      favoriteFoods.add(newFood);

      expect(favoriteFoods.getFavoriteFoodItems.contains(newFood), true);
    });

    test(
        "A specified Food instance should be deleted from Favorite Foods array",
        () {
      var newFood = Food(id: 2, food_name: "Pasta");

      favoriteFoods.add(newFood);

      expect(favoriteFoods.getFavoriteFoodItems.contains(newFood), true);

      favoriteFoods.remove(newFood);

      expect(favoriteFoods.getFavoriteFoodItems.contains(newFood), false);
    });
  });
}
