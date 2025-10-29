class Dish {
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final bool vegan;
  final String imageUrl;

  Dish({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.vegan,
    required this.imageUrl,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
    id: json['id'],
    restaurantId: json['restaurant_id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
    vegan: json['vegan'],
    imageUrl: json['image_url'],
  );
}
