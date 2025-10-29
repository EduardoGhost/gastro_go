import 'package:bloc/bloc.dart';
import '../../../../domain/repositories/restaurant_repository.dart';
import '../../../domain/entity/restaurant.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;
  List<Restaurant> _allRestaurants = [];

  RestaurantBloc({required this.repository}) : super(RestaurantInitial()) {
    // Carregar restaurantes
    on<LoadRestaurants>((event, emit) async {
      emit(RestaurantLoading());
      try {
        final restaurants = await repository.getRestaurants();
        _allRestaurants = restaurants;
        emit(RestaurantLoaded(restaurants));
      } catch (e) {
        emit(RestaurantError('Erro ao carregar restaurantes'));
      }
    });

    // Buscar por nome
    on<SearchRestaurants>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = _allRestaurants
          .where((r) => r.name.toLowerCase().contains(query))
          .toList();
      emit(RestaurantLoaded(filtered));
    });

    // Filtragem por categoria
    on<FilterByCategory>((event, emit) {
      final category = event.category;
      final filtered = category.isEmpty
          ? _allRestaurants
          : _allRestaurants
          .where((r) => r.category.toLowerCase() == category.toLowerCase())
          .toList();
      emit(RestaurantLoaded(filtered));
    });
    // ordenação por avalição ou distancia
    on<SortRestaurants>((event, emit) {
      List<Restaurant> sorted = List.from(_allRestaurants);

      if (event.sortBy == 'rating') {
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (event.sortBy == 'distance') {
        sorted.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      }

      emit(RestaurantLoaded(sorted));
    });

  }
}
