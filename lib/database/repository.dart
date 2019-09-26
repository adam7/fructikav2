import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';
import 'package:fructika/utilities/shared_preferences_helper.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class Repository{
  Future<Database> database;
  updateFoodGroup(FoodGroup foodGroup);
  getFavouriteFoods();
  updateFood(Food food); 
  Future<List<FoodGroup>> getAllFoodGroups(); 
  Future<List<Food>> searchFoods(String searchText, PreferencesHelper preferencesHelper);
}