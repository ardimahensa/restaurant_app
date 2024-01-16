import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:typing_animation/typing_animation.dart';

import '../controller/search_controller.dart';
import '../service/api_services.dart';
import '../shared/utils.dart';
import '../widget/icon_text.dart';
import '../widget/not_found.dart';
import 'detail_screen.dart';
import 'no_connection.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchRestoController searchController =
      Get.put(SearchRestoController());
  final TextEditingController searchEtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchRestoController>(
      init: searchController,
      initState: (_) {
        searchController.listenConnectivity();
      },
      builder: (ctx) {
        return PopScope(
          canPop: true,
          onPopInvoked: (_) {
            Get.delete<SearchRestoController>();
          },
          child: Obx(() {
            if (searchController.isConnectInternet.value) {
              return RefreshIndicator(
                onRefresh: () async {
                  searchController.searchRestaurant();
                },
                child: Scaffold(
                  body: SlideInDown(
                    duration: const Duration(milliseconds: 500),
                    from: 250,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              color: mainColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Search Restaurant',
                                    style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: white,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Get.delete<SearchRestoController>();
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_left,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: grey,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: TextField(
                                              controller: searchEtController,
                                              onChanged: (value) {
                                                searchController
                                                    .setKeyword(value);
                                                searchController
                                                    .searchRestaurant();
                                              },
                                              style: TextStyle(
                                                color: black,
                                                fontSize: 16.0,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'Cari yang kamu mau',
                                                labelStyle: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                ),
                                                hintStyle: TextStyle(
                                                  color: grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Icon(
                                            Icons.fastfood,
                                            color: red,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        searchResult(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const NoConnection();
            }
          }),
        );
      },
    );
  }

  Expanded searchResult() {
    return Expanded(
      child: searchController.searchListRestaurant.isEmpty
          ? searchController.keyword.isEmpty
              ? const Center(
                  child: Text('Ketik sesuatu'),
                )
              : const NotFound()
          : searchController.isLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Lottie.asset(
                        'assets/image/header_food.json',
                        width: 250,
                        height: 250,
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
                )
              : ListView.builder(
                  itemCount: searchController.searchListRestaurant.length,
                  itemBuilder: (context, index) {
                    var data = searchController.searchListRestaurant;
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => DetailScreen(
                            restaurantId: data[index].id,
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 15, left: 20),
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${ApiService().imageUrl}/${data[index].pictureId}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 15, right: 15),
                              width: MediaQuery.of(context).size.width * 0.57,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: grey,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data[index].name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    IconText(
                                      restaurant: data[index],
                                      colorIcon: green,
                                      text1: data[index].city,
                                      icon: Icons.location_city,
                                      iconSize: 16,
                                    ),
                                    const SizedBox(width: 12),
                                    IconText(
                                      restaurant: data[index],
                                      icon: Icons.star,
                                      text1: '${data[index].rating}',
                                      colorIcon: yellow,
                                      iconSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
