import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  final String name;
  final double price;
  final bool vegan;

  const DishCard({
    super.key,
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
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {

          },
        ),
      ),
    );
  }
}