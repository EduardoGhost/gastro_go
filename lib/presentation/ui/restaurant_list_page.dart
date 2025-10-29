import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/restaurant_local_datasource.dart';
import '../../data/repository/RestaurantRepositoryImpl.dart';
import '../bloc/restaurants/restaurant_bloc.dart';
import '../bloc/restaurants/restaurant_event.dart';
import '../bloc/restaurants/restaurant_state.dart';
import '../widgets/restaurant_card.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RestaurantRepositoryImpl(
      localDataSource: RestaurantLocalDataSourceImpl(),
    );

    return BlocProvider(
      create: (_) => RestaurantBloc(repository: repository)..add(LoadRestaurants()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gastro Go - Restaurantes'),
          centerTitle: true,
        ),
        body: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantError) {
              return Center(child: Text(state.message));
            } else if (state is RestaurantEmpty) {
              return const Center(child: Text('Nenhum restaurante encontrado.'));
            } else if (state is RestaurantLoaded) {
              final restaurants = state.restaurants;

              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return RestaurantCard(
                    name: restaurant.name,
                    category: restaurant.category,
                    rating: restaurant.rating,
                    distanceKm: restaurant.distanceKm,
                    imageUrl: restaurant.imageUrl,
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
