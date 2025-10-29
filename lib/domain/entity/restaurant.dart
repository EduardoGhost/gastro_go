class Restaurant {
  final String id;
  final String name;
  final String category;
  final double rating;
  final double distanceKm;
  final String imageUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    required this.imageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json['id'],
    name: json['name'],
    category: json['category'],
    rating: (json['rating'] as num).toDouble(),
    distanceKm: (json['distance_km'] as num).toDouble(),
    imageUrl: json['image_url'],
  );
}
