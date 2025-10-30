import '../../domain/entity/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_local_datasource.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantLocalDataSource localDataSource;

  RestaurantRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      return await localDataSource.getRestaurants();
    } catch (e) {
      throw Exception('Erro ao buscar restaurantes: $e');
    }
  }
}
