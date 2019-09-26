class SqlSelectBuilder {
  static String _buildSearchSelectQuery(bool platformIsIos) {
    final select = """
      SELECT Food.id AS id, Food.description AS description, Food.food_group AS food_group, Food.food_group_image AS food_group_image, 
      favourite, protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber""";

    return platformIsIos ? select : select + ", matchinfo";
  }

  static String _buildSearchFromQuery(bool platformIsIos) {
    final join = platformIsIos
        ? "JOIN (SELECT id, rank FROM FoodSearch WHERE FoodSearch MATCH ?) USING(id)"
        : "JOIN (SELECT id, matchinfo(FoodSearch) as matchinfo FROM FoodSearch WHERE FoodSearch MATCH ?) USING(id)";

    return """
      FROM Food 
        $join 
        INNER JOIN FoodGroup ON Food.food_group = FoodGroup.name 
      WHERE FoodGroup.enabled = 1""";
  }

  static String buildSearchQuery(bool platformIsIos, bool includeUnknownFructose) {
    String query = _buildSearchSelectQuery(platformIsIos) + _buildSearchFromQuery(platformIsIos);

    if(!includeUnknownFructose){
      query += " AND fructose IS NOT NULL";
    }

    if (platformIsIos) {
      query += " ORDER BY rank";
    }

    return query;
  }

  static String get foodCountQuery{
    return "SELECT COUNT(*) FROM Food";
  }
}
