import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entity/restaurant.dart';

abstract class RestaurantLocalDataSource {
  Future<List<Restaurant>> getRestaurants();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  @override
  Future<List<Restaurant>> getRestaurants() async {
    final jsonString = await rootBundle.loadString('assets/restaurants.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Restaurant.fromJson(e)).toList();
  }
}

