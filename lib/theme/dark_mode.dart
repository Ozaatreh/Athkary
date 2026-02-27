import 'package:flutter/material.dart'; 

ThemeData darkMode =ThemeData(
brightness: Brightness.dark,
colorScheme: ColorScheme.dark(
  surface: Colors.grey.shade900,
  primary:  const Color.fromARGB(255, 242, 239, 239),
  secondary:  const Color.fromARGB(255, 21, 21, 21),
  inversePrimary: const Color.fromARGB(255, 3, 3, 3),
  inverseSurface:  const Color.fromARGB(255, 62, 58, 58),
  onPrimary: Color(0xFF2C3E50),
  ),

  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[200],
    displayColor: Colors.white,
  )

);