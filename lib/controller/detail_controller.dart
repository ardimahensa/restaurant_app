import 'package:get/get.dart';

import '../models/restaurant_detail.dart';
import '../service/api_services.dart';
import '../shared/connection.dart';

class DetailController extends GetxController {
  RestaurantDetail? restaurantDetail;
  RxBool isConnectInternet = true.obs;

  void getDetailRestaurant(String id) async {
    restaurantDetail = null;
    restaurantDetail = await ApiService().getRestaurantDetail(id);
    update();
  }

  void listenConnectivity() {
    Connection.isConnectInternet().listen((event) {
      isConnectInternet.value = event;
    });
  }

  Future<bool> addReview(String id, String name, String review) {
    ApiService().addReview(id, name, review).then((value) {
      getDetailRestaurant(id);
      return true;
    }).catchError((e) {
      return false;
    });
    return Future.value(true);
  }
}
