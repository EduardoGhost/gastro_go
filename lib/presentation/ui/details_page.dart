import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/dish_local_datasource.dart';
import '../../data/repository/DishRepositoryImpl.dart';
import '../../domain/entity/restaurant.dart';
import '../bloc/dishes/dish_bloc.dart';
import '../widgets/dish_card.dart';

class DetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final dishRepository = DishRepositoryImpl(localDataSource: DishLocalDataSourceImpl());

    return BlocProvider(
      create: (_) => DishBloc(repository: dishRepository)..add(LoadDishesByRestaurant(restaurant.id)),
      child: Scaffold(
        appBar: AppBar(title: Text(restaurant.name)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Infos do Restaurante
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('${restaurant.category} • ⭐ ${restaurant.rating} • ${restaurant.distanceKm.toStringAsFixed(1)} km'),
                  const SizedBox(height: 12),
                  // Botão de favoritar restaurante
                  ElevatedButton.icon(
                    onPressed: () {
                      // implementar favoritar restaurante
                    },
                    icon: const Icon(Icons.favorite_border),
                    label: const Text('Favoritar Restaurante'),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Listagem de pratos
            Expanded(
              child: BlocBuilder<DishBloc, DishState>(
                builder: (context, state) {
                  if (state is DishLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DishLoaded) {
                    final dishes = state.dishes;
                    return ListView.builder(
                      itemCount: dishes.length,
                      itemBuilder: (context, index) {
                        final d = dishes[index];
                        return DishCard(
                          name: d.name,
                          price: d.price,
                          vegan: d.vegan,
                        );
                      },
                    );
                  } else if (state is DishError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
