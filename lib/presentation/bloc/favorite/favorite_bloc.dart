import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final Box box;

  FavoritesBloc({required this.box}) : super(FavoritesLoading()) {
    on<LoadFavorites>((event, emit) {
      final stored = List<String>.from(box.get('favorites', defaultValue: <String>[]));

      stored.removeWhere((id) => id.trim().isEmpty);
      box.put('favorites', stored);

      emit(FavoritesLoaded(Set<String>.from(stored)));
    });

    on<ToggleFavorite>((event, emit) {
      final currentState = state;
      if (currentState is FavoritesLoaded) {
        final current = Set<String>.from(currentState.favorites);

        if (current.contains(event.favorite.id)) {
          print('Removendo favorito: ${event.favorite.id}');
          current.remove(event.favorite.id);
        } else {
          print('Adicionando favorito: ${event.favorite.id}');
          current.add(event.favorite.id);
        }

        emit(FavoritesLoaded(current));
        box.put('favorites', current.toList());
        print('Favoritos salvos no Banco: ${box.get('favorites')}');
      }
    });
  }
}
