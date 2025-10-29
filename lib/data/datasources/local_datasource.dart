import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gastro_go/data/models/restaurant_model.dart';
import 'package:gastro_go/data/models/dish_model.dart';

class LocalDataSource {

  Future<List<RestaurantModel>> loadRestaurants() async {
    try {
      final jsonString = await rootBundle.loadString('assets/restaurants.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => RestaurantModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar restaurantes: $e');
    }
  }

  Future<List<DishModel>> loadDishes() async {
    try {
      final jsonString = await rootBundle.loadString('assets/dishes.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => DishModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar pratos: $e');
    }
  }
}
