import 'package:flutter_test/flutter_test.dart';
import 'package:makan_bang/models/restaurant_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:makan_bang/models/restaurant_detail.dart';
import 'package:makan_bang/service/api_services.dart';

import './api_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'getDetailRestaurant',
    () {
      test('test untuk resto list', () async {
        final client = MockClient();
        when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async => http.Response('''
            {
              "error": false,
              "message": "success",
              "count": 20,
              "restaurants": [
                  {
                      "id": "rqdv5juczeskfw1e867",
                      "name": "Melting Pot",
                      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                      "pictureId": "14",
                      "city": "Medan",
                      "rating": 4.2
                  },
                  {
                      "id": "s1knt6za9kkfw1e867",
                      "name": "Kafe Kita",
                      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                      "pictureId": "25",
                      "city": "Gorontalo",
                      "rating": 4
                  }
            ]
          }''', 200));

        final result = await ApiService().getRestaurantList(client);

        expect(result, isA<RestaurantList>());
      });

      test('should throw an exception on failure', () async {
        final client = MockClient();
        when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
            .thenAnswer((_) async =>
                http.Response('Failed to load restaurant list', 403));

        expect(
          () async => await ApiService().getRestaurantList(client),
          throwsException,
        );
      });
      test(
        'test ambil salah satu detail resto',
        () async {
          final client = MockClient();
          when(client.get(Uri.parse(
                  'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
              .thenAnswer((_) async => http.Response('''
            {
              "error": false,
              "message": "success",
              "restaurant": {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                "city": "Medan",
                "address": "Jln. Pandeglang no 19",
                "pictureId": "14",
                "categories": [
                    {
                        "name": "Italia"
                    },
                    {
                        "name": "Modern"
                    }
                ],
                "menus": {
                    "foods": [
                        {
                            "name": "Paket rosemary"
                        },
                        {
                            "name": "Toastie salmon"
                        }
                    ],
                    "drinks": [
                        {
                            "name": "Es krim"
                        },
                        {
                            "name": "Sirup"
                        }
                    ]
                },
                "rating": 4.2,
                "customerReviews": [
                    {
                        "name": "Ahmad",
                        "review": "Tidak rekomendasi untuk pelajar!",
                        "date": "13 November 2019"
                    }
                ]
              }
            }''', 200));

          final result = await ApiService()
              .getRestaurantDetail('rqdv5juczeskfw1e867', client);

          expect(result, isA<RestaurantDetail>());
        },
      );
      test(
        'test gagal ambil salah satu detail resto',
        () async {
          final client = MockClient();
          when(client.get(Uri.parse(
                  'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
              .thenAnswer((_) async =>
                  http.Response('Failed to load restaurant detail', 403));

          expect(
            () async => await ApiService()
                .getRestaurantDetail('rqdv5juczeskfw1e867', client),
            throwsException,
          );
        },
      );
    },
  );
}
