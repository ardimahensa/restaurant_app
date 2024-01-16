import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../helper/connectivity_helper.dart';
import '../helper/top_restaurant_helper.dart';
import '../models/restaurant_list.dart';
import '../service/api_services.dart';
import '../shared/connection.dart';

class RestaurantController extends GetxController {
  List<RestaurantListItem> restaurantList = <RestaurantListItem>[];
  List<RestaurantListItem> top5RatingResto = <RestaurantListItem>[];
  bool isLoading = false;
  RxBool isConnectInternet = true.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Mengecek koneksi internet saat aplikasi pertama kali dibuka
    _checkConnection();
  }

  void switchLoading(bool state) {
    isLoading = state;
    update();
  }

  Future<void> _checkConnection() async {
    bool isConnected = await ConnectivityHelper.isConnected();
    isConnectInternet.value = isConnected;
  }

  Future<void> getRestoList() async {
    switchLoading(true);
    try {
      restaurantList.clear();
      var futureRestaurantList = await ApiService().getRestaurantList();
      restaurantList = futureRestaurantList.restaurants;
      for (var i = 0; i < restaurantList.length; i++) {
        var detailResto =
            await ApiService().getRestaurantDetail(restaurantList[i].id);
        restaurantList[i].drinks = detailResto.restaurant.menus.drinks.length;
        restaurantList[i].foods = detailResto.restaurant.menus.foods.length;
        restaurantList[i].reviews =
            detailResto.restaurant.customerReviews.length;
      }
      top5RatingResto = Top5RestaurantHelper.getTop5Restaurants(restaurantList);
      update();
    } catch (e) {
      debugPrint('error : $e');
    } finally {
      switchLoading(false);
    }
  }

  void listenConnectivity() {
    Connection.isConnectInternet().listen((event) {
      isConnectInternet.value = event;
    });
  }
}
