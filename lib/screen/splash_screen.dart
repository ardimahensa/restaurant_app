import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/homeScreen');
    });
    super.initState();
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
              'assets/image/foo.jpg',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShakeY(
                from: 10,
                infinite: false,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Lottie.asset(
                    'assets/image/splash_girl.json',
                    repeat: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
