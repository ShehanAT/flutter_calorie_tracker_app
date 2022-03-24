import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:calorie_tracker_app/src/utils/uuid.dart';

@JsonSerializable()
class Food {
  String id;
  String name;
  late String color;
  String calories;
  String carbs;
  String fat;
  String protein;

  Food(
    this.name,
    this.calories,
    this.carbs,
    this.fat,
    this.protein, {
    String? color,
    String? id,
  }) : this.id = id ?? Uuid().generateV4();

  Food.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        calories = json['calories'],
        carbs = json['carbs'],
        fat = json['fat'],
        protein = json['protein'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': id,
        'name': name,
        'calories': calories,
        'carbs': carbs,
        'fat': fat,
        'protein': protein
      };

  @override
  String toString() {
    return "name: " +
        name +
        ', ' +
        "calories: " +
        calories +
        ", carbs: " +
        carbs +
        ", fat: " +
        fat +
        ", protein: " +
        protein;
  }
}
