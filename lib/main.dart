import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/restaurant_controller.dart';
import 'screen/no_connection.dart';
import 'screen/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantController restaurantController = Get.put(RestaurantController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(
        () {
          if (!restaurantController.isConnectInternet.value) {
            restaurantController.listenConnectivity();
            return const NoConnection();
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
