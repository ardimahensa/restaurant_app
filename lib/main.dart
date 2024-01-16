import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen/detail_screen.dart';
import 'screen/home_screen.dart';
import 'screen/search_screen.dart';
import 'screen/splash_screen.dart';
import 'service/restaurant.dart';
import 'widget/grid_view.dart';
import 'widget/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/searchScreen': (context) => const SearchScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/detailScreen': (context) => DetailScreen(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        '/gridViewCart': (context) => GridViewCart(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        '/listViewCart': (context) => ListViewCart(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}
