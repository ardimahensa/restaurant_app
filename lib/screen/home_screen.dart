// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../service/restaurant.dart';
import '../utils.dart';
import '../widget/grid_view.dart';
import '../widget/list_view.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RestaurantList _restaurantList = RestaurantList(restaurants: []);
  late ScrollController _scrollController;
  bool _isScrolled = false;
  bool _isGridViewCart = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    _localApiRestaurant();
  }

  Future<void> _localApiRestaurant() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/local_restaurant.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        _restaurantList = RestaurantList.fromJson(jsonData);
      });
    } catch (error) {
      Center(
        child: Lottie.asset('assets/image/cheff.json', height: 200, width: 200),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _isScrolled = _scrollController.hasClients &&
          _scrollController.offset > (100.0 - kToolbarHeight);
    });
  }

  void _onSearchPressed() {
    Navigator.pushNamed(context, '/searchScreen');
  }

  void _toggleView() {
    setState(() {
      _isGridViewCart = !_isGridViewCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            title: _isScrolled
                ? null
                : Center(
                    child: SizedBox(
                      height: kToolbarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.food_bank, color: white),
                          Text(
                            "MAKAN BANG",
                            style: titleText.copyWith(
                              fontSize: 24,
                              color: white,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                                _isGridViewCart ? Icons.list : Icons.grid_on,
                                color: white),
                            onPressed: _toggleView,
                          ),
                        ],
                      ),
                    ),
                  ),
            backgroundColor: _isScrolled ? redDark : redLight,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isScrolled
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/image/sandwich.json',
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 7,
                              ),
                              Lottie.asset(
                                'assets/image/header_food.json',
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 7,
                              ),
                            ],
                          ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.width / 9,
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: greyLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        onTap: _onSearchPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.search,
                              color: greyDark,
                            ),
                            const SizedBox(width: 8.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                'Cari yang kamu mau',
                                style: subTitleText.copyWith(
                                  fontSize: 12,
                                  color: black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Icon(
                              Icons.fastfood,
                              color: redDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isGridViewCart
              ? GridData(restaurants: _restaurantList.restaurants)
              : ListData(restaurants: _restaurantList.restaurants),
        ],
      ),
    );
  }
}

class ListData extends StatelessWidget {
  final List<Restaurant> restaurants;

  const ListData({required this.restaurants, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final restaurant = restaurants[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detailScreen',
                  arguments: restaurant);
            },
            child: ListViewCart(restaurant: restaurant),
          );
        },
        childCount: restaurants.length,
      ),
    );
  }
}

class GridData extends StatelessWidget {
  final List<Restaurant> restaurants;

  const GridData({required this.restaurants, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final restaurant = restaurants[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detailScreen',
                  arguments: restaurant);
            },
            child: GridViewCart(restaurant: restaurant),
          );
        },
        childCount: restaurants.length,
      ),
    );
  }
}
