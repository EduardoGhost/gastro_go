// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishModelAdapter extends TypeAdapter<DishModel> {
  @override
  final int typeId = 1;

  @override
  DishModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DishModel(
      id: fields[0] as String,
      restaurantId: fields[1] as String,
      name: fields[2] as String,
      price: fields[3] as double,
      vegan: fields[4] as bool,
      imageUrl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DishModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.restaurantId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.vegan)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishModel _$DishModelFromJson(Map<String, dynamic> json) => DishModel(
      id: json['id'] as String,
      restaurantId: json['restaurant_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      vegan: json['vegan'] as bool,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$DishModelToJson(DishModel instance) => <String, dynamic>{
      'id': instance.id,
      'restaurant_id': instance.restaurantId,
      'name': instance.name,
      'price': instance.price,
      'vegan': instance.vegan,
      'image_url': instance.imageUrl,
    };
