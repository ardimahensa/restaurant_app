import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/detail_controller.dart';
import '../controller/favorite_controller.dart';
import '../service/api_services.dart';
import '../shared/utils.dart';
import 'loading_screen.dart';
import 'no_connection.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.restaurantId});

  final String restaurantId;
  final DetailController detailController = Get.put(DetailController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: detailController,
      initState: (_) {
        detailController.getDetailRestaurant(restaurantId);
        detailController.listenConnectivity();
      },
      builder: (ctx) {
        return PopScope(
          canPop: true,
          onPopInvoked: (_) {
            Get.delete<DetailController>();
          },
          child: Obx(
            () => !ctx.isConnectInternet.value
                ? const NoConnection()
                : ctx.restaurantDetail == null
                    ? const LoadingScreen()
                    : RefreshIndicator(
                        onRefresh: () async {
                          detailController.getDetailRestaurant(restaurantId);
                        },
                        child: Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Get.delete<DetailController>();
                                Get.back();
                              },
                            ),
                          ),
                          body: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        color: grey,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            '${ApiService().imageUrl}/${ctx.restaurantDetail!.restaurant.pictureId}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: grey,
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            await favoriteController
                                                .toggleFavorite(ctx
                                                    .restaurantDetail!
                                                    .restaurant
                                                    .id);
                                            favoriteController
                                                .showFavoriteSnackbar(
                                              () => context,
                                              favoriteController.isFavorite(ctx
                                                  .restaurantDetail!
                                                  .restaurant
                                                  .id),
                                            );
                                          },
                                          icon: Obx(
                                            () => Icon(
                                              favoriteController
                                                      .isFavorite(restaurantId)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        ctx.restaurantDetail?.restaurant.name ??
                                            '',
                                        style: GoogleFonts.roboto(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_city,
                                            color: green,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            ctx.restaurantDetail?.restaurant
                                                    .city ??
                                                '',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: yellow,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            "${ctx.restaurantDetail?.restaurant.rating ?? ''}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Tentang Restorant Ini:",
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        ctx.restaurantDetail?.restaurant
                                                .description ??
                                            '',
                                        style:
                                            GoogleFonts.roboto(fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1),
                                Text(
                                  "Kategori:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: [
                                    for (var category in ctx.restaurantDetail!
                                        .restaurant.categories)
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: grey,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(category.name),
                                      ),
                                  ],
                                ),
                                const Divider(thickness: 1),
                                Text(
                                  "Menu Makanan:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: [
                                    for (var food in ctx.restaurantDetail!
                                        .restaurant.menus.foods)
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: red,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          food.name,
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  "Menu Minuman:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: [
                                    for (var drink in ctx.restaurantDetail!
                                        .restaurant.menus.drinks)
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: yellow,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(drink.name),
                                      ),
                                  ],
                                ),
                                const Divider(thickness: 1),
                                Text(
                                  "Review Resto:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  children: [
                                    for (var review in ctx.restaurantDetail!
                                        .restaurant.customerReviews)
                                      ListTile(
                                        tileColor: grey,
                                        title: Text(review.name),
                                        subtitle: Text(
                                          review.review,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          review.date,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                          floatingActionButton: ElevatedButton(
                            onPressed: () {
                              _showReviewDialog(context);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add),
                                Text('Tambah Review'),
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final nameController = TextEditingController();
        final reviewController = TextEditingController();
        return AlertDialog(
          title: const Text("Tambahkan Review"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengguna',
                  hintText: 'Masukkan nama pengguna',
                ),
              ),
              TextField(
                controller: reviewController,
                decoration: const InputDecoration(
                  labelText: 'Ulasan',
                  hintText: 'Masukkan ulasan Anda',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      reviewController.text.isNotEmpty) {
                    detailController
                        .addReview(
                      restaurantId,
                      nameController.text,
                      reviewController.text,
                    )
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                        nameController.clear();
                        reviewController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Gagal menambahkan review'),
                          ),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nama dan komentar tidak boleh kosong'),
                      ),
                    );
                  }
                },
                child: const Text('Tambahkan Ulasan'),
              ),
            ],
          ),
        );
      },
    );
  }
}
