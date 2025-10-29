import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final double distanceKm;
  final String imageUrl;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(category, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(rating.toStringAsFixed(1)),
                    const SizedBox(width: 16),
                    const Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                    const SizedBox(width: 4),
                    Text('${distanceKm.toStringAsFixed(1)} km'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
