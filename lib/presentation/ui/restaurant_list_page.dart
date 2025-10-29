import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/restaurant_local_datasource.dart';
import '../../data/repository/RestaurantRepositoryImpl.dart';
import '../bloc/restaurants/restaurant_bloc.dart';
import '../bloc/restaurants/restaurant_event.dart';
import '../bloc/restaurants/restaurant_state.dart';
import '../widgets/category_dialog.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/sort_dialog.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  String _searchQuery = '';
  String _selectedCategory = '';
  String _selectedSort = '';

  @override
  Widget build(BuildContext context) {
    final repository = RestaurantRepositoryImpl(
      localDataSource: RestaurantLocalDataSourceImpl(),
    );

    return BlocProvider(
      create: (_) =>
      RestaurantBloc(repository: repository)..add(LoadRestaurants()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Gastro Go - Restaurantes')),
            body: Column(
              children: [
                // Campo de busca de restaurantes
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Buscar restaurante...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      _searchQuery = value;
                      _applyFilters(context);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => SortDialog(
                              selectedSort: _selectedSort,
                              onSortSelected: (sort) {
                                setState(() => _selectedSort = sort);
                                context.read<RestaurantBloc>().add(SortRestaurants(sort));
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.sort),
                        label: const Text('Ordenar'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => CategoryDialog(
                              selectedCategory: _selectedCategory,
                              onCategorySelected: (cat) {
                                setState(() => _selectedCategory = cat);
                                _applyFilters(context);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.category),
                        label: const Text('Filtrar'),
                      ),
                    ],
                  ),
                ),


                // Listagem de restaurantes
                Expanded(
                  child: BlocBuilder<RestaurantBloc, RestaurantState>(
                    builder: (context, state) {
                      if (state is RestaurantLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (state is RestaurantLoaded) {
                        final restaurants = state.restaurants;
                        if (restaurants.isEmpty) {
                          return const Center(
                              child: Text('Nenhum restaurante encontrado'));
                        }
                        return ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            final r = restaurants[index];
                            return RestaurantCard(
                              name: r.name,
                              category: r.category,
                              rating: r.rating,
                              distanceKm: r.distanceKm,
                            );
                          },
                        );
                      } else if (state is RestaurantError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _applyFilters(BuildContext context) {
    final bloc = context.read<RestaurantBloc>();
    bloc.add(SearchRestaurants(_searchQuery));
    if (_selectedCategory.isNotEmpty) {
      bloc.add(FilterByCategory(_selectedCategory));
    }
  }

}
