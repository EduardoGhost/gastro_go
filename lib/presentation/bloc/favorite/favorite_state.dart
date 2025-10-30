abstract class FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final Set<String> favorites;
  FavoritesLoaded(this.favorites);
}
