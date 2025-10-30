import 'package:hive/hive.dart';
import '../../domain/entity/favorite.dart';
import '../../domain/repositories/favorite_repository.dart';


class FavoritesRepositoryImpl implements FavoritesRepository {
  static const boxName = 'favorites';

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    final box = await Hive.openBox<String>(boxName);
    final key = '${favorite.isRestaurant ? 'r' : 'd'}_${favorite.id}';
    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      await box.put(key, favorite.id);
    }
  }

  @override
  Future<bool> isFavorite(String id, bool isRestaurant) async {
    final box = await Hive.openBox<String>(boxName);
    final key = '${isRestaurant ? 'r' : 'd'}_$id';
    return box.containsKey(key);
  }

  @override
  Future<List<Favorite>> getAllFavorites(bool isRestaurant) async {
    final box = await Hive.openBox<String>(boxName);
    return box.keys
        .where((k) => k.startsWith(isRestaurant ? 'r_' : 'd_'))
        .map((k) => Favorite(id: box.get(k)!, isRestaurant: isRestaurant, name: ''))
        .toList();
  }
}
