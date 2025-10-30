import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final double distanceKm;
  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
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
      ),
    );
  }
}
