import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/dish_local_datasource.dart';
import '../../domain/entity/dish.dart';
import '../../domain/entity/restaurant.dart';
import '../bloc/favorite/favorite_bloc.dart';
import '../bloc/favorite/favorite_state.dart';
import '../../data/datasources/restaurant_local_datasource.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final RestaurantLocalDataSource _restaurantDataSource;
  late final DishLocalDataSource _dishDataSource;

  @override
  void initState() {
    super.initState();
    _restaurantDataSource = RestaurantLocalDataSourceImpl();
    _dishDataSource = DishLocalDataSourceImpl();
  }

  // Pegar os pratos favoritos
  Future<List<Dish>> _getFavoriteDishes(Set<String> favIds) async {
    final allDishes = await _dishDataSource.getAllDishes();
    final favDishIds = favIds.where((id) => id.startsWith('d')).toSet();
    return allDishes.where((d) => favDishIds.contains(d.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            final favIds = state.favorites;

            return FutureBuilder<List<Restaurant>>(
              future: _restaurantDataSource.getRestaurants(),
              builder: (context, restaurantSnapshot) {
                if (!restaurantSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allRestaurants = restaurantSnapshot.data!;
                final favRestaurants = allRestaurants
                    .where((r) => favIds.contains(r.id))
                    .toList();

                return FutureBuilder<List<Dish>>(
                  future: _getFavoriteDishes(favIds),
                  builder: (context, dishSnapshot) {
                    if (!dishSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final favDishes = dishSnapshot.data!;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Restaurantes favoritos',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          if (favRestaurants.isEmpty)
                            const Text('Nenhum restaurante favoritado ainda.'),
                          ...favRestaurants.map(
                                (r) => Card(
                              margin:
                              const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(r.name),
                                subtitle: Text(
                                    '${r.category} • ⭐ ${r.rating} • ${r.distanceKm.toStringAsFixed(1)} km'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Pratos favoritos',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          if (favDishes.isEmpty)
                            const Text('Nenhum prato favoritado ainda.'),
                          ...favDishes.map(
                                (d) => Card(
                              margin:
                              const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(d.name),
                                subtitle: Text(
                                    'R\$ ${d.price.toStringAsFixed(2)} • ${d.vegan ? "Vegano" : "Não vegano"}'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Erro ao carregar favoritos.'));
          }
        },
      ),
    );
  }
}





