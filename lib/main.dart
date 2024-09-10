import 'package:flutter/material.dart';
import 'package:shop/screens/home_screen.dart';
import 'package:shop/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MingalarShop',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Add the custom font family to the overall theme
        fontFamily: 'CustomFont',
      ),
      home: SplashScreen(),
    );
  }
}
