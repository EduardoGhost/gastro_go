import 'package:bloc/bloc.dart';
import '../../../domain/repositories/dish_repository.dart';
import 'dish_event.dart';
import 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final DishRepository repository;

  DishBloc({required this.repository}) : super(DishLoading()) {
    on<LoadDishes>((event, emit) async {
      emit(DishLoading());
      try {
        final dishes = await repository.getDishes(event.restaurantId);
        if (dishes.isEmpty) {
          emit(DishEmpty());
        } else {
          emit(DishLoaded(dishes));
        }
      } catch (e) {
        emit(DishError('Erro ao carregar pratos: $e'));
      }
    });
  }
}
