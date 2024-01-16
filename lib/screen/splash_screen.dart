import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Tunggu beberapa detik sebelum navigasi ke HomeScreen
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Get.offAll(HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.passthrough,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 100),
            child: Image.asset(
              'assets/image/food.jpg',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ShakeY(
              from: 10,
              infinite: false,
              child: Lottie.asset(
                'assets/image/splash_girl.json',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                repeat: false,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
