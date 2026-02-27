import 'dart:ui';
import 'package:athkary/pages/adyah/adyah_alanbiaa.dart';
import 'package:athkary/pages/adyah/adyah_alnabi.dart';
import 'package:athkary/pages/adyah/adyah_alquran.dart';
import 'package:athkary/pages/adyah/adyah_alrizq.dart';
import 'package:athkary/pages/adyah/adyah_alsafar.dart';
import 'package:athkary/pages/adyah/adyah_for_dead.dart';
import 'package:athkary/pages/adyah/adyah_raining.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahPartsPage extends StatelessWidget {
  const AdyahPartsPage({super.key});

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
                            Image.asset(
                              'assets/images/duaa_img.png',
                              width: 36,
                              height: 36,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'أدعية',
                              style: GoogleFonts.amiri(
                                fontSize: 28,
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
                        _buildCategory(context, 'الأدعية القرآنية',
                            Icons.menu_book_rounded, AdyahAlquran()),
                        _buildCategory(context, 'أدعية النبي ﷺ',
                            Icons.dark_mode_rounded, AdyahAlnabi()),
                        _buildCategory(context, 'أدعية الأنبياء',
                            Icons.collections_bookmark_rounded,
                            AdyahAlanbiaa()),
                        _buildCategory(context, 'أدعية للميت',
                            Icons.monitor_heart_rounded,
                            AdyahForDead()),
                        _buildCategory(context, 'أدعية السفر',
                            Icons.directions_car_rounded,
                            AdyahAlsafar()),
                        _buildCategory(context, 'أدعية المطر',
                            Icons.water_drop_rounded,
                            AdyahRaining()),
                        _buildCategory(context, 'أدعية الرزق',
                            Icons.auto_stories_rounded,
                            AdyahAlrizq()),
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