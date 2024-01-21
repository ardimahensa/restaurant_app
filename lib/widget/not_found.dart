import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Expanded(
            child: Lottie.asset('assets/image/not_found.json',
                width: 250, height: 250),
          ),
          Expanded(
            child: Text(
              'Tidak ada hasil pencarian',
              style: GoogleFonts.roboto(),
            ),
          ),
        ],
      ),
    );
  }
}
