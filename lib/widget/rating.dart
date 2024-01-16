import 'package:flutter/material.dart';

import '../models/restaurant_list.dart';

class StarRating extends StatelessWidget {
  final double? iconSize;
  final int rating;
  final RestaurantListItem restaurant;
  const StarRating({
    super.key,
    required this.rating,
    required this.restaurant,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    var iconSize = MediaQuery.of(context).size.width * 0.06;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            5,
            (index) {
              double ratingValue = index + 1.0;
              return Icon(
                ratingValue <= rating
                    ? Icons.star
                    : ratingValue - 0.5 <= restaurant.rating
                        ? Icons.star_half
                        : Icons.star_border,
                color: Colors.yellow,
                size: iconSize,
              );
            },
          ),
        ),
        const SizedBox(width: 5),
        Text(
          '${restaurant.rating}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
