import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favorite_controller.dart';
import '../service/api_services.dart';
import '../shared/utils.dart';
import '../widget/icon_text.dart';
import 'detail_screen.dart';
import 'loading_screen.dart';
import 'no_connection.dart';

class FavoriteScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.find();

  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      init: favoriteController,
      builder: (favoriteController) {
        return Obx(
          () {
            if (!favoriteController.isConnectInternet.value) {
              return const NoConnection();
            } else if (favoriteController.isLoading.value) {
              return const LoadingScreen();
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Favorite Restaurants'),
              ),
              body: favoriteController.favoriteIds.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: favoriteController.favoriteIds.length,
                      itemBuilder: (context, index) {
                        String restaurantId =
                            favoriteController.favoriteIds[index];
                        final restaurantDetail =
                            favoriteController.restaurantDetails[restaurantId];

                        if (restaurantDetail == null) {
                          return const SizedBox();
                        }

                        return GestureDetector(
                          onTap: () {
                            Get.to(DetailScreen(restaurantId: restaurantId));
                          },
                          child: SizedBox(
                            height: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 15, left: 20),
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${ApiService().imageUrl}/${restaurantDetail.restaurant.pictureId}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 15, right: 15),
                                    width: MediaQuery.of(context).size.width *
                                        0.57,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      color: grey,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                restaurantDetail
                                                    .restaurant.name,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await favoriteController
                                                      .toggleFavorite(
                                                          restaurantDetail
                                                              .restaurant.id);
                                                  favoriteController
                                                      .showFavoriteSnackbar(
                                                    () => context,
                                                    favoriteController
                                                        .isFavorite(
                                                            restaurantDetail
                                                                .restaurant.id),
                                                  );
                                                },
                                                icon: Obx(
                                                  () => Icon(
                                                    favoriteController
                                                            .isFavorite(
                                                                restaurantDetail
                                                                    .restaurant
                                                                    .id)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconText(
                                            restaurantDetail:
                                                restaurantDetail.restaurant,
                                            colorIcon: green,
                                            text1: restaurantDetail
                                                .restaurant.city,
                                            icon: Icons.location_city,
                                            iconSize: 16,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconText(
                                                restaurantDetail:
                                                    restaurantDetail.restaurant,
                                                icon: Icons.star,
                                                text1:
                                                    '${restaurantDetail.restaurant.rating}',
                                                colorIcon: yellow,
                                                iconSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ),
                                              IconText(
                                                restaurantDetail:
                                                    restaurantDetail.restaurant,
                                                icon: Icons.fastfood,
                                                text1:
                                                    '${restaurantDetail.restaurant.menus.foods.length}',
                                                colorIcon: red,
                                                text2: 'Foods',
                                                iconSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              IconText(
                                                restaurantDetail:
                                                    restaurantDetail.restaurant,
                                                icon: Icons.local_drink,
                                                text1:
                                                    '${restaurantDetail.restaurant.menus.drinks.length}',
                                                colorIcon: red,
                                                text2: 'Drinks',
                                                iconSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Tidak ada favorit'),
                    ),
            );
          },
        );
      },
    );
  }
}
