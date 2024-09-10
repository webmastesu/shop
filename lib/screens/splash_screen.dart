import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop/screens/home_screen.dart'; // Replace with your home screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Start the animation and navigate to the home screen once it's done
    _controller.forward().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash_animation.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
          },
        ),
      ),
    );
  }
}
