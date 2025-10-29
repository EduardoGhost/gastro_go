import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entity/dish.dart';

abstract class DishLocalDataSource {
  Future<List<Dish>> getDishes(String restaurantId);
}

class DishLocalDataSourceImpl implements DishLocalDataSource {
  @override
  Future<List<Dish>> getDishes(String restaurantId) async {
    final jsonString = await rootBundle.loadString('assets/dishes.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((e) => Dish.fromJson(e))
        .where((dish) => dish.restaurantId == restaurantId)
        .toList();
  }
}
