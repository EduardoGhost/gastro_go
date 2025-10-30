import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/favorite.dart';
import '../bloc/favorite/favorite_bloc.dart';
import '../bloc/favorite/favorite_event.dart';
import '../bloc/favorite/favorite_state.dart';

class DishCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final bool vegan;

  const DishCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.vegan,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(name),
        subtitle: Text('R\$ ${price.toStringAsFixed(2)} • ${vegan ? "Vegano" : "Não vegano"}'),
        trailing: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            final favs = state is FavoritesLoaded ? state.favorites : <String>{};
            final isFav = favs.contains(id);
            return IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
              onPressed: () {
                print('❤️ Favoritando prato: $id');
                context.read<FavoritesBloc>().add(
                    ToggleFavorite(Favorite(id: id, name: name, isRestaurant: false)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}