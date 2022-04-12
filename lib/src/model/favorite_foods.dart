import 'food.dart';
import 'package:flutter/material.dart';

class FavoriteFoods extends ChangeNotifier {
  final List<Food> _favoriteFoodItems = [];

  List<Food> get getFavoriteFoodItems => _favoriteFoodItems;
  // List<int> get items => _favoriteFoodItem;

  void add(Food food) {
    _favoriteFoodItems.add(food);
    notifyListeners();
  }

  void remove(Food food) {
    _favoriteFoodItems.remove(food);
    notifyListeners();
  }
}
