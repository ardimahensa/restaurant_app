import 'package:get/get.dart';

import '../models/restaurant_list.dart';
import '../service/api_services.dart';
import '../shared/connection.dart';

class SearchRestoController extends GetxController {
  List<RestaurantListItem> searchListRestaurant = <RestaurantListItem>[];
  RxBool isConnectInternet = true.obs;
  RxBool isLoading = false.obs;
  String keyword = '';

  void setKeyword(String keyword) {
    this.keyword = keyword;
    update();
  }

  Future<void> searchRestaurant() async {
    try {
      isLoading.value = true;
      searchListRestaurant.clear();
      searchListRestaurant = await ApiService().searchRestaurant(keyword);
      update();
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      isLoading.value = false;
    }
  }

  void listenConnectivity() {
    Connection.isConnectInternet().listen((event) {
      isConnectInternet.value = event;
    });
  }
}
