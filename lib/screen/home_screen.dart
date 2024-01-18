import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../controller/daily_reminder_controller.dart';
import '../controller/restaurant_controller.dart';
import '../helper/notification_helper.dart';
import '../shared/utils.dart';
import 'favorite.screen.dart';
import 'list_restaurant.dart';
import 'loading_screen.dart';
import 'no_connection.dart';
import 'search_screen.dart';
import 'top_restaurant.dart';

class HomeScreen extends StatelessWidget {
  final NotificationHelper notificationHelper = Get.put(NotificationHelper());
  final DailyController dailyController = Get.put(DailyController());
  final RestaurantController restaurantController =
      Get.put(RestaurantController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: restaurantController,
      initState: (_) {
        restaurantController.getRestoList();
        restaurantController.listenConnectivity();
      },
      builder: (restaurantController) {
        return Obx(
          () {
            if (!restaurantController.isConnectInternet.value) {
              return const NoConnection();
            }
            return RefreshIndicator(
              onRefresh: () async {
                restaurantController.getRestoList();
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: Lottie.asset(
                    'assets/image/header_food.json',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(
                    'Makan Bang',
                    style: GoogleFonts.roboto(),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        Get.to(
                          () => SearchScreen(),
                        );
                      },
                    ),
                    PopupMenuButton<bool>(
                      offset: const Offset(0, 50),
                      icon: const Icon(Icons.menu),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<bool>(
                            child: ListTile(
                              title: Obx(
                                () => Text(
                                  dailyController.isScheduled
                                      ? 'Notifikasi Aktif'
                                      : 'Notifikasi Tidak Aktif',
                                ),
                              ),
                              trailing: Obx(
                                () => Switch(
                                  value: dailyController.isScheduled,
                                  onChanged: (value) {
                                    dailyController.toggleDailyNotification();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
                body: !restaurantController.isLoading
                    ? ListView(
                        children: [
                          Top5Resto(
                              top5Restaurants:
                                  restaurantController.top5RatingResto),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Restaurant List',
                                  style: GoogleFonts.roboto(fontSize: 24),
                                ),
                                Card(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => FavoriteScreen(),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: red,
                                        ),
                                        const Text('Resto Favorite'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListRestaurantView(
                            restaurantList: restaurantController.restaurantList,
                          ),
                        ],
                      )
                    : const LoadingScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
