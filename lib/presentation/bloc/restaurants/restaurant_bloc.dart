import 'package:bloc/bloc.dart';
import '../../../../domain/repositories/restaurant_repository.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository}) : super(RestaurantLoading()) {
    on<LoadRestaurants>((event, emit) async {
      emit(RestaurantLoading());
      try {
        final restaurants = await repository.getRestaurants();
        if (restaurants.isEmpty) {
          emit(RestaurantEmpty());
        } else {
          emit(RestaurantLoaded(restaurants));
        }
      } catch (e) {
        emit(RestaurantError('Erro ao carregar restaurantes: $e'));
      }
    });
  }
}
