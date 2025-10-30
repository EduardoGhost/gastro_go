import '../../../domain/entity/favorite.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final Favorite favorite;
  ToggleFavorite(this.favorite);
}
