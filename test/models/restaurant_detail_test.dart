import 'package:flutter_test/flutter_test.dart';
import 'package:makan_bang/models/restaurant_detail.dart';

void main() {
  group('RestaurantDetail', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'error': false,
        'message': 'Success',
        'restaurant': {
          'id': '1',
          'name': 'Restaurant 1',
          'description': 'Description 1',
          'city': 'City 1',
          'address': 'Address 1',
          'pictureId': 'pic1',
          'categories': [
            {'name': 'Category 1'}
          ],
          'menus': {
            'foods': [
              {'name': 'Food 1'}
            ],
            'drinks': [
              {'name': 'Drink 1'}
            ]
          },
          'rating': 4.5,
          'customerReviews': [
            {'name': 'Reviewer 1', 'review': 'Good', 'date': '2022-01-18'}
          ],
        },
      };

      // Act
      final result = RestaurantDetail.fromJson(json);

      // Assert
      expect(result.error, false);
      expect(result.message, 'Success');
      expect(result.restaurant.id, '1');
      expect(result.restaurant.name, 'Restaurant 1');
      expect(result.restaurant.description, 'Description 1');
      expect(result.restaurant.city, 'City 1');
      expect(result.restaurant.address, 'Address 1');
      expect(result.restaurant.pictureId, 'pic1');
      expect(result.restaurant.categories.length, 1);
      expect(result.restaurant.categories[0].name, 'Category 1');
      expect(result.restaurant.menus.foods.length, 1);
      expect(result.restaurant.menus.foods[0].name, 'Food 1');
      expect(result.restaurant.menus.drinks.length, 1);
      expect(result.restaurant.menus.drinks[0].name, 'Drink 1');
      expect(result.restaurant.rating, 4.5);
      expect(result.restaurant.customerReviews.length, 1);
      expect(result.restaurant.customerReviews[0].name, 'Reviewer 1');
      expect(result.restaurant.customerReviews[0].review, 'Good');
      expect(result.restaurant.customerReviews[0].date, '2022-01-18');
    });

    test('toJson should correctly convert to JSON', () {
      // Arrange
      final restaurantDetail = RestaurantDetail(
        error: false,
        message: 'Success',
        restaurant: RestaurantDetailItem(
          id: '1',
          name: 'Restaurant 1',
          description: 'Description 1',
          city: 'City 1',
          address: 'Address 1',
          pictureId: 'pic1',
          categories: [Category(name: 'Category 1')],
          menus: Menus(
              foods: [MenuItem(name: 'Food 1')],
              drinks: [MenuItem(name: 'Drink 1')]),
          rating: 4.5,
          customerReviews: [
            CustomerReview(
                name: 'Reviewer 1', review: 'Good', date: '2022-01-18')
          ],
        ),
      );

      // Act
      final result = restaurantDetail.toJson();

      // Assert
      expect(result['error'], false);
      expect(result['message'], 'Success');
      expect(result['restaurant']['id'], '1');
      expect(result['restaurant']['name'], 'Restaurant 1');
      expect(result['restaurant']['description'], 'Description 1');
      expect(result['restaurant']['city'], 'City 1');
      expect(result['restaurant']['address'], 'Address 1');
      expect(result['restaurant']['pictureId'], 'pic1');
      expect(result['restaurant']['categories'][0]['name'], 'Category 1');
      expect(result['restaurant']['menus']['foods'][0]['name'], 'Food 1');
      expect(result['restaurant']['menus']['drinks'][0]['name'], 'Drink 1');
      expect(result['restaurant']['rating'], 4.5);
      expect(result['restaurant']['customerReviews'][0]['name'], 'Reviewer 1');
      expect(result['restaurant']['customerReviews'][0]['review'], 'Good');
      expect(result['restaurant']['customerReviews'][0]['date'], '2022-01-18');
    });
  });

  group('RestaurantDetailItem', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': '1',
        'name': 'Restaurant 1',
        'description': 'Description 1',
        'city': 'City 1',
        'address': 'Address 1',
        'pictureId': 'pic1',
        'categories': [
          {'name': 'Category 1'}
        ],
        'menus': {
          'foods': [
            {'name': 'Food 1'}
          ],
          'drinks': [
            {'name': 'Drink 1'}
          ]
        },
        'rating': 4.5,
        'customerReviews': [
          {'name': 'Reviewer 1', 'review': 'Good', 'date': '2022-01-18'}
        ],
      };

      // Act
      final result = RestaurantDetailItem.fromJson(json);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Restaurant 1');
      expect(result.description, 'Description 1');
      expect(result.city, 'City 1');
      expect(result.address, 'Address 1');
      expect(result.pictureId, 'pic1');
      expect(result.categories.length, 1);
      expect(result.categories[0].name, 'Category 1');
      expect(result.menus.foods.length, 1);
      expect(result.menus.foods[0].name, 'Food 1');
      expect(result.menus.drinks.length, 1);
      expect(result.menus.drinks[0].name, 'Drink 1');
      expect(result.rating, 4.5);
      expect(result.customerReviews.length, 1);
      expect(result.customerReviews[0].name, 'Reviewer 1');
      expect(result.customerReviews[0].review, 'Good');
      expect(result.customerReviews[0].date, '2022-01-18');
    });

    test('toJson should correctly convert to JSON', () {
      // Arrange
      final restaurantDetailItem = RestaurantDetailItem(
        id: '1',
        name: 'Restaurant 1',
        description: 'Description 1',
        city: 'City 1',
        address: 'Address 1',
        pictureId: 'pic1',
        categories: [Category(name: 'Category 1')],
        menus: Menus(
            foods: [MenuItem(name: 'Food 1')],
            drinks: [MenuItem(name: 'Drink 1')]),
        rating: 4.5,
        customerReviews: [
          CustomerReview(name: 'Reviewer 1', review: 'Good', date: '2022-01-18')
        ],
      );

      // Act
      final result = restaurantDetailItem.toJson();

      // Assert
      expect(result['id'], '1');
      expect(result['name'], 'Restaurant 1');
      expect(result['description'], 'Description 1');
      expect(result['city'], 'City 1');
      expect(result['address'], 'Address 1');
      expect(result['pictureId'], 'pic1');
      expect(result['categories'][0]['name'], 'Category 1');
      expect(result['menus']['foods'][0]['name'], 'Food 1');
      expect(result['menus']['drinks'][0]['name'], 'Drink 1');
      expect(result['rating'], 4.5);
      expect(result['customerReviews'][0]['name'], 'Reviewer 1');
      expect(result['customerReviews'][0]['review'], 'Good');
      expect(result['customerReviews'][0]['date'], '2022-01-18');
    });
  });
}
