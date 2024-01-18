import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makan_bang/helper/notification_helper.dart';
import 'package:makan_bang/shared/utils.dart';

import 'controller/restaurant_controller.dart';
import 'screen/no_connection.dart';
import 'screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper().configureSelectNotificationSubject();
  await AndroidAlarmManager.initialize();
  await NotificationHelper().initNotifications();

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
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
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
