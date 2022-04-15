import 'package:calorie_tracker_app/src/model/favorite_foods.dart';
import 'package:calorie_tracker_app/src/model/food.dart';
import 'package:test/test.dart';

void main() {
  group("Testing Model classes", () {
    var favoriteFoods = FavoriteFoods();

    test(
        "Given that we instantiate a FavoriteFoods instance"
        "When new Food instances are added to it"
        "Then the FavoriteFoods instance's _favoriteFoodItems List should contain that Food instance",
        () {
      var newFood = Food(id: 1, food_name: "Sandwich");

      favoriteFoods.add(newFood);

      expect(favoriteFoods.getFavoriteFoodItems.contains(newFood), true);
    });

    test(
        "Given that we instantiate a FavoriteFoods instance"
        "When Food instances are deleted from its _favoriteFoodItems List"
        "Then the FavoriteFoods instance's _favoriteFoodItems List should contain not contain that Food instance",
        () {
      var newFood = Food(id: 2, food_name: "Pasta");

      favoriteFoods.add(newFood);

      expect(favoriteFoods.getFavoriteFoodItems.contains(newFood), true);

      favoriteFoods.remove(newFood);

      expect(favoriteFoods.getFavoriteFoodItems.contains(newFood), false);
    });
  });
}
