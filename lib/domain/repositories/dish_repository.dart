import '../entity/dish.dart';

abstract class DishRepository {
  Future<List<Dish>> getDishes(String restaurantId);
}