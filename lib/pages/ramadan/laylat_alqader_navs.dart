import 'dart:ui';
import 'package:athkary/pages/ramadan/laylat_alqader_duaa.dart';
import 'package:athkary/pages/ramadan/laylat_alqader_info.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class LaylatAlQadrNav extends StatefulWidget {
  const LaylatAlQadrNav({super.key});

  @override
  State<LaylatAlQadrNav> createState() => LaylatAlQadrNavState();
}

class LaylatAlQadrNavState extends State<LaylatAlQadrNav> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    LaylatAlQadrInfoScreen(),
    LaylatAlQadrDuaScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: const Color(0xFF0D1B2A),

          /// ========= BODY WITH STATE PRESERVATION =========
          body: IndexedStack(
            index: selectedIndex,
            children: pages,
          ),

          /// ========= MODERN FLOATING NAV =========
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: selectedIndex,
                    onTap: onItemTapped,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: const Color(0xFFF4D35E),
                    unselectedItemColor: Colors.white70,
                    selectedLabelStyle: GoogleFonts.amiri(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: GoogleFonts.amiri(
                      fontSize: 14,
                    ),
                    items: [
                      BottomNavigationBarItem(
                        icon: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: selectedIndex == 0 ? 1 : 0.5,
                          child: Lottie.asset(
                            'assets/animations/wired-lineal-1821-night-sky-moon-stars-hover-pinch.json',
                            width: 32,
                            repeat: selectedIndex == 0,
                          ),
                        ),
                        label: 'معلومات',
                      ),
                      BottomNavigationBarItem(
                        icon: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: selectedIndex == 1 ? 1 : 0.5,
                          child: Lottie.asset(
                            'assets/animations/wired-flat-1821-night-sky-moon-stars-hover-pinch.json',
                            width: 32,
                            repeat: selectedIndex == 1,
                          ),
                        ),
                        label: 'أدعية',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}