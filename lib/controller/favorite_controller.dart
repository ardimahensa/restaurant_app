import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/local_storage_helper.dart';
import '../models/restaurant_detail.dart';
import '../service/api_services.dart';
import '../shared/connection.dart';
import 'package:http/http.dart' as http;

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
    favoriteIds.assignAll(await LocalStorageService.getFavorites());
  }

  Future<void> getFavoriteRestaurants() async {
    List<String> favoritesCopy = List.from(favoriteIds);

    for (String restaurantId in favoritesCopy) {
      await getRestaurantDetail(restaurantId);
    }
  }

  Future<void> toggleFavorite(String restaurantId) async {
    List<String> favoritesCopy = List.from(favoriteIds);

    if (favoritesCopy.contains(restaurantId)) {
      favoritesCopy.remove(restaurantId);
    } else {
      favoritesCopy.add(restaurantId);
    }

    await LocalStorageService.saveFavorites(favoritesCopy);
    favoriteIds.assignAll(favoritesCopy);
    update();
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
