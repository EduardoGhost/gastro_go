abstract class DishEvent {}

class LoadDishes extends DishEvent {
  final String restaurantId;
  LoadDishes(this.restaurantId);
}
