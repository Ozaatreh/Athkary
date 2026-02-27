import 'dart:ui';
import 'package:athkary/pages/sunnan_alnabi/sunnan_alnom.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_alsiam.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_althekr_doaa.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_eating_clothing.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_randoms.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_wadu_salah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SonanAlnabiNavs extends StatelessWidget {
  const SonanAlnabiNavs({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D1B2A),
                Color(0xFF1B263B),
                Color(0xFF2C3E50),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [

                /// ===== HEADER =====
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/wired-flat-1845-rose-hover-pinch.json',
                              width: 40,
                              repeat: true,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'سنن النبي ﷺ',
                              style: GoogleFonts.amiri(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withOpacity(0.1),
                ),

                const SizedBox(height: 20),

                /// ===== GRID =====
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: 1.05,
                      children: [
                        _buildCategory(
                          context,
                          'سنن النوم',
                          Icons.nightlight_round,
                          SleepSunnahsPage(),
                        ),
                        _buildCategory(
                          context,
                          'سنن الوضوء والصلاة',
                          Icons.water_drop_rounded,
                          WuduAndSalahSunnahsScreen(),
                        ),
                        _buildCategory(
                          context,
                          'سنن الصيام',
                          Icons.fastfood_rounded,
                          FastingSunnahsPage(),
                        ),
                        _buildCategory(
                          context,
                          'الذكر والدعاء',
                          Icons.menu_book_rounded,
                          ThikrAndDuaSunnahsScreen(),
                        ),
                        _buildCategory(
                          context,
                          'سنن متنوعة',
                          Icons.category_rounded,
                          RandomsSunnahsScreen(),
                        ),
                        _buildCategory(
                          context,
                          'سنن اللباس والطعام',
                          Icons.restaurant_rounded,
                          ClothingAndEatingSunnahsScreen(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(
      BuildContext context, String title, IconData icon, Widget page) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 34,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}