// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../service/restaurant.dart';
import '../utils.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/searchScreen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Restaurant> allRestaurants = [];
  List<Restaurant> searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/local_restaurant.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      setState(() {
        allRestaurants = RestaurantList.fromJson(jsonData).restaurants;
      });
    } catch (error) {
      Lottie.asset('assets/image/cheff.json', height: 200, width: 200);
    }
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = allRestaurants
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
                restaurant.city.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        searchResults.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyLight,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.width / 9,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: greyLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.search,
                    color: greyDark,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      onChanged: _performSearch,
                      onSubmitted: _performSearch,
                      style: TextStyle(
                        color: black,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari yang kamu mau',
                        labelStyle: subTitleText.copyWith(
                          fontSize: 12,
                        ),
                        hintStyle: TextStyle(
                          color: greyLight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.fastfood,
                    color: redLight,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Lottie.asset('assets/image/not_found.json',
            height: 200, width: 200),
      );
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final restaurant = searchResults[index];
          return Column(
            children: [
              ListTile(
                leading: SizedBox(
                  width: 100,
                  height: 80,
                  child: Image.network(
                    restaurant.pictureId,
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  restaurant.name,
                  style: titleText.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text(
                  restaurant.city,
                  style: subTitleText.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 13),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: yellow),
                    Text('${restaurant.rating}'),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/detailScreen',
                      arguments: restaurant);
                },
              ),
              const Divider(
                thickness: 1,
              )
            ],
          );
        },
      );
    }
  }
}
