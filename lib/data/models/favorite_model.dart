import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 2)
class Favorite {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final bool isRestaurant;

  const Favorite({
    required this.id,
    required this.isRestaurant,
  });
}
