import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:makan_bang/models/restaurant_list.dart';

import '../models/restaurant_detail.dart';

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';
  final String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium';

  ///list restaurant
  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  ///detail restaurant
  Future<RestaurantDetail> getRestaurantDetail(String restaurantId) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$restaurantId'));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  ///serach restaurant
  Future<List<RestaurantListItem>> searchRestaurant(String keyword) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$keyword'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['restaurants'];
      return data.map((item) => RestaurantListItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  ///random restaurant
  Future<RestaurantListItem> getRandomRestaurant() async {
    final RestaurantList restaurantList = await getRestaurantList();
    final Random random = Random();
    final int randomIndex = random.nextInt(restaurantList.restaurants.length);
    return restaurantList.restaurants[randomIndex];
  }

  ///tambah review
  Future<Map<String, dynamic>> addReview(
      String id, String name, String review) async {
    final Map<String, dynamic> requestData = {
      'id': id,
      'name': name,
      'review': review,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add review');
    }
  }
}
