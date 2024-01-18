class RestaurantList {
  final bool? error;
  final String? message;
  final int? count;
  final List<RestaurantListItem> restaurants;

  RestaurantList({
    this.error,
    this.message,
    this.count,
    required this.restaurants,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      restaurants: (json['restaurants'] as List)
          .map((restaurantJson) => RestaurantListItem.fromJson(restaurantJson))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantListItem {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  int? drinks;
  int? foods;
  int? reviews;

  RestaurantListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.drinks,
    this.foods,
    this.reviews,
  });

  factory RestaurantListItem.fromJson(Map<String, dynamic> json) {
    return RestaurantListItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
