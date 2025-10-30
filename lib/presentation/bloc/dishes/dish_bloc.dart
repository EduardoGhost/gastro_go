import 'package:bloc/bloc.dart';
import '../../../domain/entity/dish.dart';
import '../../../domain/repositories/dish_repository.dart';

// events
abstract class DishEvent {}
class LoadDishesByRestaurant extends DishEvent {
  final String restaurantId;
  LoadDishesByRestaurant(this.restaurantId);
}

// states
abstract class DishState {}
class DishInitial extends DishState {}
class DishLoading extends DishState {}
class DishLoaded extends DishState {
  final List<Dish> dishes;
  DishLoaded(this.dishes);
}
class DishError extends DishState {
  final String message;
  DishError(this.message);
}

// bloc
class DishBloc extends Bloc<DishEvent, DishState> {
  final DishRepository repository;

  DishBloc({required this.repository}) : super(DishInitial()) {
    on<LoadDishesByRestaurant>((event, emit) async {
      emit(DishLoading());
      try {
        final dishes = await repository.getDishesByRestaurant(event.restaurantId);
        emit(DishLoaded(dishes));
      } catch (e) {
        emit(DishError('Erro ao carregar pratos'));
      }
    });
  }
}
