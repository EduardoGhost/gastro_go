import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class RestaurantModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  @JsonKey(name: 'distance_km')
  final double distanceKm;

  @HiveField(5)
  @JsonKey(name: 'image_url')
  final String imageUrl;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    required this.imageUrl,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);


  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

