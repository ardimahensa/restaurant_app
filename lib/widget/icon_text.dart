import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/restaurant_detail.dart';
import '../models/restaurant_list.dart';

class IconText extends StatelessWidget {
  final String text1;
  final String? text2;
  final IconData icon;
  final Color colorIcon;
  final double? iconSize;
  final RestaurantListItem? restaurant;
  final RestaurantDetailItem? restaurantDetail;

  const IconText({
    super.key,
    this.restaurant,
    this.restaurantDetail,
    required this.colorIcon,
    required this.text1,
    this.text2,
    this.iconSize,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var iconSize = MediaQuery.of(context).size.width * 0.05;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: colorIcon, size: iconSize),
        const SizedBox(width: 2),
        Text(
          text1,
          style: GoogleFonts.roboto(
              fontSize: MediaQuery.of(context).size.width * 0.03),
        ),
        if (text2 != null) ...[
          const SizedBox(width: 2),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text2!,
              style: GoogleFonts.roboto(
                  fontSize: MediaQuery.of(context).size.width * 0.03),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}
