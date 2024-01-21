import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/detail_controller.dart';
import '../controller/favorite_controller.dart';
import '../service/api_services.dart';
import '../shared/utils.dart';
import '../widget/loading.dart';
import '../widget/no_connection.dart';

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
                    ? const Loading()
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
                                imageResto(context, ctx),
                                const SizedBox(height: 16.0),
                                infoResto(context, ctx),
                                const SizedBox(height: 16.0),
                                aboutResto(context, ctx),
                                const Divider(thickness: 1),
                                Text(
                                  "Kategori:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                kategoriResto(ctx),
                                const Divider(thickness: 1),
                                Text(
                                  "Menu Makanan:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                menuMakanan(ctx),
                                const SizedBox(height: 16.0),
                                Text(
                                  "Menu Minuman:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                menuMinuman(ctx),
                                const Divider(thickness: 1),
                                Text(
                                  "Review Resto:",
                                  style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                reviewResto(ctx),
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

  Column reviewResto(DetailController ctx) {
    return Column(
      children: [
        for (var review in ctx.restaurantDetail!.restaurant.customerReviews)
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
    );
  }

  Wrap menuMinuman(DetailController ctx) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (var drink in ctx.restaurantDetail!.restaurant.menus.drinks)
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: yellow,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(drink.name),
          ),
      ],
    );
  }

  Wrap menuMakanan(DetailController ctx) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (var food in ctx.restaurantDetail!.restaurant.menus.foods)
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: red,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              food.name,
              style: TextStyle(color: white),
            ),
          ),
      ],
    );
  }

  Wrap kategoriResto(DetailController ctx) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (var category in ctx.restaurantDetail!.restaurant.categories)
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(category.name),
          ),
      ],
    );
  }

  Container aboutResto(BuildContext context, DetailController ctx) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            "Tentang Restorant Ini:",
            style:
                GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            ctx.restaurantDetail?.restaurant.description ?? '',
            style: GoogleFonts.roboto(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container infoResto(BuildContext context, DetailController ctx) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            ctx.restaurantDetail?.restaurant.name ?? '',
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
                ctx.restaurantDetail?.restaurant.city ?? '',
                style: GoogleFonts.roboto(fontSize: 16.0),
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
                style: GoogleFonts.roboto(fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack imageResto(BuildContext context, DetailController ctx) {
    return Stack(
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
              borderRadius: BorderRadius.circular(10),
              color: grey,
            ),
            child: IconButton(
              onPressed: () async {
                await favoriteController
                    .toggleFavorite(ctx.restaurantDetail!.restaurant.id);
                favoriteController.showFavoriteSnackbar(
                  () => context,
                  favoriteController
                      .isFavorite(ctx.restaurantDetail!.restaurant.id),
                );
              },
              icon: Obx(
                () => Icon(
                  favoriteController.isFavorite(restaurantId)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showReviewDialog(BuildContext context) {
    final nameController = TextEditingController();
    final reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tambahkan Review"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
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
                    final detailController = Get.find<DetailController>();
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
                          detailController.showSuccessSnackbar();
                        }
                      });
                    } else {
                      detailController.showFieldEmptyErrorSnackbar();
                    }
                  },
                  child: const Text('Tambahkan Ulasan'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
