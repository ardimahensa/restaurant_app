import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helper/favorite_database.dart';
import '../models/restaurant_detail.dart';
import '../service/api_services.dart';
import '../shared/connection.dart';

class FavoriteController extends GetxController {
  final Map<String, RestaurantDetail> restaurantDetails = {};
  RxBool isConnectInternet = true.obs;
  RxList<String> favoriteIds = <String>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(favoriteIds, (_) {
      getFavoriteRestaurants();
    });
    initFavorites();
  }

  void switchLoading(bool state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading.value = state;
      update();
    });
  }

  void listenConnectivity() {
    Connection.isConnectInternet().listen((event) {
      isConnectInternet.value = event;
    });
  }

  Future<void> getRestaurantDetail(String restaurantId) async {
    switchLoading(true);
    try {
      final client = http.Client();
      RestaurantDetail? detail =
          await ApiService().getRestaurantDetail(restaurantId, client);
      restaurantDetails[restaurantId] = detail;
      update();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      switchLoading(false);
    }
  }

  Future<void> initFavorites() async {
    try {
      final favorites = await FavoriteDatabaseHelper.getFavorites();
      favoriteIds.assignAll(favorites);
      update();
    } catch (e) {
      debugPrint('Error initializing favorites: $e');
    }
  }

  Future<void> getFavoriteRestaurants() async {
    List<String> favoritesCopy = List.from(favoriteIds);

    for (String restaurantId in favoritesCopy) {
      await getRestaurantDetail(restaurantId);
    }
  }

  Future<void> toggleFavorite(String restaurantId) async {
    try {
      final isCurrentlyFavorite = isFavorite(restaurantId);

      if (isCurrentlyFavorite) {
        await FavoriteDatabaseHelper.deleteFavorite(restaurantId);
      } else {
        await FavoriteDatabaseHelper.insertFavorite(restaurantId);
      }

      await initFavorites();
      update();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  bool isFavorite(String restaurantId) {
    return favoriteIds.contains(restaurantId);
  }

  void showFavoriteSnackbar(
      BuildContext Function() contextBuilder, bool isSuccess) {
    final context = contextBuilder();
    final snackBar = SnackBar(
      content: Text(
        isSuccess ? 'Added to favorites' : 'Removed from favorites',
        textAlign: TextAlign.center,
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
