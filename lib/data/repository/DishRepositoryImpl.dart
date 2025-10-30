import '../../domain/entity/dish.dart';
import '../../domain/repositories/dish_repository.dart';
import '../datasources/dish_local_datasource.dart';

class DishRepositoryImpl implements DishRepository {
  final DishLocalDataSource localDataSource;

  DishRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Dish>> getDishesByRestaurant(String restaurantId) async {
    return await localDataSource.getDishes(restaurantId);
  }

  @override
  Future<List<Dish>> getDishes() async {
    return await localDataSource.getDishes('');
  }
}
