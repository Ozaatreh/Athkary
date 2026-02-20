// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Shared accent colours ─────────────────────────────────────────────────
  static const Color goldPrimary   = Color(0xFFD4AF37);
  static const Color goldLight     = Color(0xFFEDD882);
  static const Color goldDark      = Color(0xFF9B7E0A);
  static const Color emeraldGreen  = Color(0xFF1B7A4A);
  static const Color emeraldLight  = Color(0xFF2ECC71);
  static const Color highlightGreen = Color(0xFF4CAF50);

  // ── Dark theme palette ────────────────────────────────────────────────────
  static const Color darkBg      = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkCard    = Color(0xFF21262D);
  static const Color darkBorder  = Color(0xFF30363D);

  // ── Light theme palette (user-defined green scheme) ───────────────────────
  // surface      : Color.fromARGB(255, 1,  42,  5)   → deep forest green
  // primary      : Color.fromARGB(255, 212,210,210)  → soft silver-grey
  // secondary    : Color.fromARGB(255, 48, 47, 47)   → near-black
  // inversePrimary: Color.fromARGB(255, 0,  0,  0)   → pure black
  // inverseSurface: Color.fromARGB(255, 23,116, 32)  → mid green
  // onPrimary    : Color.fromARGB(255, 2,  66,  9)   → dark green
  static const Color lightSurface       = Color.fromARGB(255,  1,  42,  5);
  static const Color lightPrimary       = Color.fromARGB(255, 212, 210, 210);
  static const Color lightSecondary     = Color.fromARGB(255,  48,  47,  47);
  static const Color lightInversePrimary= Color.fromARGB(255,   0,   0,   0);
  static const Color lightInverseSurface= Color.fromARGB(255,  23, 116,  32);
  static const Color lightOnPrimary     = Color.fromARGB(255,   2,  66,   9);

  // Derived light helpers used across widgets
  static const Color lightBg     = Color.fromARGB(255,   2,  55,   7);  // slightly lighter bg
  static const Color lightCard   = Color.fromARGB(255,   3,  65,   9);
  static const Color lightBorder = Color.fromARGB(255,  23, 116,  32);

  // ── Dark ThemeData ─────────────────────────────────────────────────────────
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary:         goldPrimary,
        secondary:       emeraldGreen,
        surface:         darkSurface,
        onPrimary:       darkBg,
        onSurface:       Color(0xFFE6D5A7),
        inversePrimary:  goldLight,
        inverseSurface:  Color(0xFF1B7A4A),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: goldPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      textTheme: GoogleFonts.amiriTextTheme(ThemeData.dark().textTheme),
    );
  }

  // ── Light ThemeData (user's green scheme) ─────────────────────────────────
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      colorScheme: const ColorScheme.light(
        surface:         lightSurface,
        primary:         lightPrimary,
        secondary:       lightSecondary,
        inversePrimary:  lightInversePrimary,
        inverseSurface:  lightInverseSurface,
        onPrimary:       lightOnPrimary,
        onSurface:       lightPrimary,
        onSecondary:     lightPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: lightPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: lightBorder, width: 1),
        ),
      ),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.black,
      ),
    );
  }
}
