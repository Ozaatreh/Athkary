import 'package:flutter/material.dart'; 

ThemeData lightMode =ThemeData(
brightness: Brightness.light,
colorScheme: ColorScheme.light(
  surface: const Color.fromRGBO(128, 108, 73, 1),
  // surface: const Color(0xFFB89A68),
  primary:  const Color.fromARGB(255, 212, 210, 210),
  secondary:  const Color.fromARGB(255, 48, 47, 47),
  inversePrimary:  const Color.fromARGB(255, 0, 0, 0),
  inverseSurface:  const Color.fromARGB(255, 184, 154, 104),
  onPrimary: const Color.fromARGB(255, 112, 95, 64)
  ),

  textTheme:ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black,
  )

);