import 'package:fructika/models/food.dart';

class TestFoodData {
  static final imageName = "group_44723";
  
  static final favouriteFood = Food(
      description: "Orange",
      favourite: true,
      foodGroupImage: imageName,
      foodGroup: "Fruit");
  static final unFavouriteFood = Food(
      description: "Pear",
      favourite: false,
      foodGroupImage: imageName,
      foodGroup: "Fruit");
}
