import '../models/restaurant_list.dart';

class Top5RestaurantHelper {
  static List<RestaurantListItem> getTop5Restaurants(
      List<RestaurantListItem> restaurants) {
    restaurants.sort((a, b) => b.rating.compareTo(a.rating));
    return restaurants.take(5).toList();
  }
}
