import '../../../domain/entity/restaurant.dart';

abstract class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  RestaurantLoaded(this.restaurants);
}

class RestaurantEmpty extends RestaurantState {}

class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError(this.message);
}
