class SqlCreateBuilder {
  static final _createFoodSearchFts4 =
      "CREATE VIRTUAL TABLE FoodSearch using fts4(tokenize=porter, id TEXT, description TEXT, notindexed=id)";

  static final _createFoodSearchFts5 =
      "CREATE VIRTUAL TABLE FoodSearch using fts5(id UNINDEXED, description)";

  static String buildCreateFoodSearch(bool platformIsIos) {
    return platformIsIos ? _createFoodSearchFts5 : _createFoodSearchFts4;
  }

  static final createFood = """
      CREATE TABLE Food (id TEXT PRIMARY KEY, description TEXT, food_group TEXT, food_group_image TEXT, 
        protein REAL, total_sugars REAL, sucrose REAL, glucose REAL, fructose REAL, lactose REAL, 
        maltose REAL, dietary_fiber REAL, favourite BIT)""";

  static final createFoodGroup =
      "CREATE TABLE FoodGroup (id INTEGER PRIMARY KEY, name TEXT, image TEXT, enabled BIT)";
}
