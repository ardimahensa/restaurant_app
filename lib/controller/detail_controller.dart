import 'package:get/get.dart';

import '../models/restaurant_detail.dart';
import '../service/api_services.dart';
import '../shared/connection.dart';
import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  RestaurantDetail? restaurantDetail;
  RxBool isConnectInternet = true.obs;
  RxString snackbarMessage = RxString('');

  void getDetailRestaurant(String id) async {
    final client = http.Client();
    restaurantDetail = null;
    restaurantDetail = await ApiService().getRestaurantDetail(id, client);
    update();
  }

  void listenConnectivity() {
    Connection.isConnectInternet().listen((event) {
      isConnectInternet.value = event;
    });
  }

  Future<bool> addReview(String id, String name, String review) async {
    try {
      await ApiService().addReview(id, name, review);
      getDetailRestaurant(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  void showSuccessSnackbar() {
    Get.snackbar(
      'Sukses',
      'Ulasan berhasil ditambahkan',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void showErrorSnackbar() {
    Get.snackbar(
      'Error',
      'Gagal menambahkan ulasan',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void showFieldEmptyErrorSnackbar() {
    Get.snackbar(
      'Error',
      'Nama dan komentar tidak boleh kosong',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
