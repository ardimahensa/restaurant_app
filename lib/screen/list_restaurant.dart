import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favorite_controller.dart';
import '../models/restaurant_list.dart';
import '../service/api_services.dart';
import '../shared/utils.dart';
import '../widget/icon_text.dart';
import 'detail_screen.dart';

class ListRestaurantView extends StatelessWidget {
  ListRestaurantView({
    super.key,
    required this.restaurantList,
  });

  final List<RestaurantListItem> restaurantList;
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (favoriteController) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: restaurantList.length,
          itemBuilder: (context, index) {
            RestaurantListItem restaurants = restaurantList[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => DetailScreen(
                    restaurantId: restaurants.id,
                  ),
                );
              },
              child: SizedBox(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 15, left: 20),
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${ApiService().imageUrl}/${restaurants.pictureId}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
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
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      restaurants.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await favoriteController
                                          .toggleFavorite(restaurants.id);
                                      favoriteController.showFavoriteSnackbar(
                                        () => context,
                                        favoriteController
                                            .isFavorite(restaurants.id),
                                      );
                                    },
                                    icon: Obx(
                                      () => Icon(
                                        favoriteController
                                                .isFavorite(restaurants.id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconText(
                                restaurant: restaurants,
                                colorIcon: green,
                                text1: restaurants.city,
                                icon: Icons.location_city,
                                iconSize: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //asal kota restorant
                                  IconText(
                                    restaurant: restaurants,
                                    icon: Icons.star,
                                    text1: '${restaurants.rating}',
                                    colorIcon: yellow,
                                    iconSize:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  //jumlah makanan dari restorant
                                  IconText(
                                    restaurant: restaurants,
                                    icon: Icons.fastfood,
                                    text1: '${restaurants.foods}',
                                    colorIcon: red,
                                    text2: 'Foods',
                                    iconSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                  ),
                                  //jumlah minuman dari restorant
                                  IconText(
                                    restaurant: restaurants,
                                    icon: Icons.local_drink,
                                    text1: '${restaurants.drinks}',
                                    colorIcon: red,
                                    text2: 'Drinks',
                                    iconSize:
                                        MediaQuery.of(context).size.width *
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
        );
      },
    );
  }
}
