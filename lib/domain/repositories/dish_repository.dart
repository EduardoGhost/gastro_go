import '../entity/dish.dart';

abstract class DishRepository {
  Future<List<Dish>> getDishes();
  Future<List<Dish>> getDishesByRestaurant(String restaurantId);
}