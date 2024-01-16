class RestaurantList {
  List<Restaurant> restaurants;

  RestaurantList({
    required this.restaurants,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      restaurants: List<Restaurant>.from(
        json['restaurants'].map((x) => Restaurant.fromJson(x)),
      ),
    );
  }
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating']?.toDouble() ?? 0.0,
      menus: Menus.fromJson(json['menus']),
    );
  }
}

class Menus {
  List<Drink> foods;
  List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Drink>.from(json['foods'].map((x) => Drink.fromJson(x))),
      drinks: List<Drink>.from(json['drinks'].map((x) => Drink.fromJson(x))),
    );
  }
}

class Drink {
  String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
    );
  }
}
