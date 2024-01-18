import 'package:flutter_test/flutter_test.dart';
import 'package:makan_bang/models/restaurant_list.dart';

void main() {
  group('RestaurantList', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'error': false,
        'message': 'Success',
        'count': 2,
        'restaurants': [
          {
            'id': '1',
            'name': 'Restaurant 1',
            'description': 'Description 1',
            'pictureId': 'pic1',
            'city': 'City 1',
            'rating': 4.5,
          },
          {
            'id': '2',
            'name': 'Restaurant 2',
            'description': 'Description 2',
            'pictureId': 'pic2',
            'city': 'City 2',
            'rating': 3.8,
          },
        ],
      };

      // Act
      final result = RestaurantList.fromJson(json);

      // Assert
      expect(result.error, false);
      expect(result.message, 'Success');
      expect(result.count, 2);
      expect(result.restaurants.length, 2);
      expect(result.restaurants[0].name, 'Restaurant 1');
      expect(result.restaurants[1].name, 'Restaurant 2');
    });

    test('toJson should correctly convert to JSON', () {
      // Arrange
      final restaurantList = RestaurantList(
        error: false,
        message: 'Success',
        count: 2,
        restaurants: [
          RestaurantListItem(
            id: '1',
            name: 'Restaurant 1',
            description: 'Description 1',
            pictureId: 'pic1',
            city: 'City 1',
            rating: 4.5,
          ),
          RestaurantListItem(
            id: '2',
            name: 'Restaurant 2',
            description: 'Description 2',
            pictureId: 'pic2',
            city: 'City 2',
            rating: 3.8,
          ),
        ],
      );

      // Act
      final result = restaurantList.toJson();

      // Assert
      expect(result['error'], false);
      expect(result['message'], 'Success');
      expect(result['count'], 2);
      expect(result['restaurants'].length, 2);
      expect(result['restaurants'][0]['name'], 'Restaurant 1');
      expect(result['restaurants'][1]['name'], 'Restaurant 2');
    });
  });

  group('RestaurantListItem', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': '1',
        'name': 'Restaurant 1',
        'description': 'Description 1',
        'pictureId': 'pic1',
        'city': 'City 1',
        'rating': 4.5,
      };

      // Act
      final result = RestaurantListItem.fromJson(json);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Restaurant 1');
      expect(result.description, 'Description 1');
      expect(result.pictureId, 'pic1');
      expect(result.city, 'City 1');
      expect(result.rating, 4.5);
    });

    test('toJson should correctly convert to JSON', () {
      // Arrange
      final restaurantItem = RestaurantListItem(
        id: '1',
        name: 'Restaurant 1',
        description: 'Description 1',
        pictureId: 'pic1',
        city: 'City 1',
        rating: 4.5,
      );

      // Act
      final result = restaurantItem.toJson();

      // Assert
      expect(result['id'], '1');
      expect(result['name'], 'Restaurant 1');
      expect(result['description'], 'Description 1');
      expect(result['pictureId'], 'pic1');
      expect(result['city'], 'City 1');
      expect(result['rating'], 4.5);
    });
  });
}
