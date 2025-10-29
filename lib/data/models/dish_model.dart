import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class DishModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  @JsonKey(name: 'restaurant_id')
  final String restaurantId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final bool vegan;

  @HiveField(5)
  @JsonKey(name: 'image_url')
  final String imageUrl;

  const DishModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.vegan,
    required this.imageUrl,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) =>
      _$DishModelFromJson(json);

  Map<String, dynamic> toJson() => _$DishModelToJson(this);
}
