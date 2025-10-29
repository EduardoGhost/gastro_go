import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/restaurant_local_datasource.dart';
import '../../data/repository/RestaurantRepositoryImpl.dart';
import '../bloc/restaurants/restaurant_bloc.dart';
import '../bloc/restaurants/restaurant_event.dart';
import '../bloc/restaurants/restaurant_state.dart';
import '../widgets/category_filter.dart';
import '../widgets/restaurant_card.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  String _searchQuery = '';
  String _selectedCategory = '';

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
                // Campo de busca
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

                // Botão de filtro
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showCategoryFilter(context);
                      },
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filtrar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 36),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),

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

  void _showCategoryFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CategoryFilter(
        selectedCategory: _selectedCategory,
        onCategorySelected: (cat) {
          setState(() => _selectedCategory = cat);
          _applyFilters(context);
        },
      ),
    );
  }
}
