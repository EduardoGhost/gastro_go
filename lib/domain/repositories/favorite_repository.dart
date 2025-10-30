import '../entity/favorite.dart';

abstract class FavoritesRepository {
  Future<void> toggleFavorite(Favorite favorite);
  Future<bool> isFavorite(String id, bool isRestaurant);
  Future<List<Favorite>> getAllFavorites(bool isRestaurant);
}
