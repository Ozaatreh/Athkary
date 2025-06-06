import 'dart:async';
import 'package:athkary/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart'; // Import Rive package


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds before switching to HomePage
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(opacity: anim, child: child);
          },
          transitionDuration: Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
     // Get the current theme brightness
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Choose the animation based on the theme
    String animationFile = isDarkMode
        ? 'assets/animation_riv/logo_dark.riv' // Dark mode animation
        : 'assets/animation_riv/light_riv (2).riv'; // Light mode animation

    return Scaffold(
      backgroundColor: Colors.white, // Set a background color
      body: Center(
        child: RiveAnimation.asset(
          animationFile, // Your Rive file
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
