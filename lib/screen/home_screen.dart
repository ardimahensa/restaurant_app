// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:typing_animation/typing_animation.dart';

import '../controller/restaurant_controller.dart';
import 'list_restaurant.dart';
import 'no_connection.dart';
import 'search_screen.dart';
import 'top_restaurant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RestaurantController restaurantController =
      Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: restaurantController,
      initState: (_) {
        restaurantController.getRestoList();
        restaurantController.listenConnectivity();
      },
      builder: (ctx) {
        return Obx(
          () {
            if (!ctx.isConnectInternet.value) {
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
                        Get.to(() => SearchScreen());
                      },
                    ),
                  ],
                ),
                body: !ctx.isLoading
                    ? ListView(
                        children: [
                          Top5Resto(top5Restaurants: ctx.top5RatingResto),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              'Restaurant List',
                              style: GoogleFonts.roboto(fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListRestaurantView(
                            restaurantList: ctx.restaurantList,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              width: double.infinity),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4,
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              'assets/image/sandwich.json',
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.8,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: TypingAnimation(
                              text: 'Loading....',
                              textStyle: GoogleFonts.roboto(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
