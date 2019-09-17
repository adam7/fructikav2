class SqlInsertBuilder{
  static final foodInsert = """
    INSERT Into Food (id, description, food_group, food_group_image, favourite,
      protein, total_sugars, sucrose, glucose, fructose, lactose, maltose, dietary_fiber)
    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)""";

  static final foodSearchInsert = "INSERT Into FoodSearch (id,description) VALUES (?,?)";
}