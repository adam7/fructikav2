import 'package:fructika/models/food.dart';
import 'package:fructika/models/food_group.dart';

abstract class DatabaseProvider{
  updateFood(Food food); 
  Future<List<FoodGroup>> getAllFoodGroups(); 
  Future<List<Food>> searchFoods(String searchText);
}