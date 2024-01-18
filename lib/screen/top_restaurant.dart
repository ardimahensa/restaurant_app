import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makan_bang/controller/restaurant_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/favorite_controller.dart';
import '../models/restaurant_list.dart';
import '../service/api_services.dart';
import '../shared/utils.dart';
import '../widget/icon_text.dart';
import '../widget/rating.dart';
import 'detail_screen.dart';

class Top5Resto extends StatelessWidget {
  final CarouselController carouselController = CarouselController();
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final RestaurantController restaurantController =
      Get.put(RestaurantController());
  final List<RestaurantListItem> top5Restaurants;

  Top5Resto({super.key, required this.top5Restaurants});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: top5Restaurants.length,
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              height: 320,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              aspectRatio: 2.0,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                restaurantController.currentIndex.value = index;
              },
            ),
            carouselController: carouselController,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              RestaurantListItem restaurants = top5Restaurants[index];

              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => DetailScreen(
                      restaurantId: restaurants.id,
                    ),
                  );
                },
                child: SizedBox(
                  height: 320,
                  child: Stack(
                    children: [
                      Container(
                        height: 220,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '${ApiService().imageUrl}/${restaurants.pictureId}'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 130,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: white,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 15, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //nama restorant dari api
                                Text(
                                  restaurants.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StarRating(
                                      rating: restaurants.rating.toInt(),
                                      restaurant: restaurants,
                                    ),
                                    IconText(
                                      restaurant: restaurants,
                                      icon: Icons.chat,
                                      text1:
                                          '${top5Restaurants[index].reviews}',
                                      colorIcon: blue,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //asal kota restorant
                                      IconText(
                                        restaurant: restaurants,
                                        icon: Icons.location_city,
                                        text1: restaurants.city,
                                        colorIcon: green,
                                      ),
                                      const SizedBox(width: 12),
                                      //jumlah makanan dari restorant
                                      IconText(
                                        restaurant: restaurants,
                                        icon: Icons.fastfood,
                                        text1:
                                            '${top5Restaurants[index].foods}',
                                        colorIcon: red,
                                        text2: 'Foods',
                                      ),
                                      const SizedBox(width: 12),
                                      //jumlah minuman dari restorant
                                      IconText(
                                        restaurant: restaurants,
                                        icon: Icons.local_drink,
                                        text1:
                                            '${top5Restaurants[index].drinks}',
                                        colorIcon: red,
                                        text2: 'Drinks',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Card(
                            child: Obx(
                              () => IconButton(
                                onPressed: () async {
                                  await favoriteController
                                      .toggleFavorite(restaurants.id);
                                  favoriteController.showFavoriteSnackbar(
                                    () => context,
                                    favoriteController
                                        .isFavorite(restaurants.id),
                                  );
                                },
                                icon: Icon(
                                  favoriteController.isFavorite(restaurants.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Obx(
            () => AnimatedSmoothIndicator(
              activeIndex: restaurantController.currentIndex.value,
              count: top5Restaurants.length,
              effect: ExpandingDotsEffect(
                activeDotColor: purple,
                dotColor: Colors.grey,
                dotHeight: 15,
                dotWidth: 15,
                spacing: 10,
              ),
              onDotClicked: (index) {
                carouselController.animateToPage(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
