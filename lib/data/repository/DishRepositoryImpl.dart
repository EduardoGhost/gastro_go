import '../../domain/entity/dish.dart';
import '../../domain/repositories/dish_repository.dart';
import '../datasources/dish_local_datasource.dart';

class DishRepositoryImpl implements DishRepository {
  final DishLocalDataSource localDataSource;

  DishRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Dish>> getDishes(String restaurantId) async {
    try {
      return await localDataSource.getDishes(restaurantId);
    } catch (e) {
      throw Exception('Erro ao buscar pratos: $e');
    }
  }
}
