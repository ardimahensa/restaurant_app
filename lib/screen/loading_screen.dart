import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:typing_animation/typing_animation.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10, width: double.infinity),
            Lottie.asset('assets/image/sandwich.json', width: 250, height: 250),
            TypingAnimation(
              text: 'Loading....',
              textStyle: GoogleFonts.roboto(
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
