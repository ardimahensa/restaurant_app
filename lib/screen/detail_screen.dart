import 'package:flutter/material.dart';

import '../service/restaurant.dart';
import '../utils.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detailScreen';

  final Restaurant restaurant;

  const DetailScreen({required this.restaurant, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: greyDark, borderRadius: BorderRadius.circular(10)),
              child: Image.network(
                restaurant.pictureId,
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: greyLight, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: titleText.copyWith(
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
                        restaurant.city,
                        style: infoText.copyWith(fontSize: 16.0),
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
                        "${restaurant.rating}",
                        style: infoText.copyWith(fontSize: 16.0),
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
                  color: greyLight, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text(
                    "Tentang Restorant Ini:",
                    style: subTitleText.copyWith(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    restaurant.description,
                    style: subTitleText.copyWith(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Text(
              "Menu Makanan:",
              style: subTitleText.copyWith(
                  fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (var food in restaurant.menus.foods)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: greyLight,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(food.name),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              "Menu Minuman:",
              style: subTitleText.copyWith(
                  fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (var drink in restaurant.menus.drinks)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: greyLight,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(drink.name),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
