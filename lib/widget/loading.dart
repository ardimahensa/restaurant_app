import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:typing_animation/typing_animation.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            Expanded(
              child: Lottie.asset(
                'assets/image/sandwich.json',
                width: 250,
                height: 250,
              ),
            ),
            Expanded(
              child: TypingAnimation(
                text: 'Loading....',
                textStyle: GoogleFonts.roboto(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
