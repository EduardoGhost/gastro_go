import '../../../domain/entity/dish.dart';

abstract class DishState {}

class DishLoading extends DishState {}

class DishLoaded extends DishState {
  final List<Dish> dishes;
  DishLoaded(this.dishes);
}

class DishEmpty extends DishState {}

class DishError extends DishState {
  final String message;
  DishError(this.message);
}
