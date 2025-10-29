abstract class RestaurantEvent {}

class LoadRestaurants extends RestaurantEvent {}

class SearchRestaurants extends RestaurantEvent {
  final String query;
  SearchRestaurants(this.query);
}

class FilterByCategory extends RestaurantEvent {
  final String category;
  FilterByCategory(this.category);
}

