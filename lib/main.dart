import 'package:flutflix/colors.dart';
import 'package:flutflix/screens/home_screen.dart';
import 'package:flutflix/screens/nav_screen.dart';
import 'package:flutflix/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        useMaterial3: true,
      ),
      home: SplashScreen(), //const NavScreen(),
    );
  }
}
