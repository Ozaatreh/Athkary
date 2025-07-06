import 'package:athkary/Component/qiblah_compass.dart';
import 'package:athkary/Component/setting_page.dart';
import 'package:athkary/pages/alah_names.dart';
import 'package:athkary/pages/home_page.dart';
import 'package:athkary/pages/prayer_page.dart';
import 'package:athkary/pages/quran/quran_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isDarkMode = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.8),
                    theme.colorScheme.primary.withOpacity(0.4),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 140,
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Lottie.asset(
                      'assets/animations/wired-lineal-1923-mosque-in-reveal.json',
                      fit: BoxFit.contain,
                      animate: true,
                      repeat: false,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أذكاري',
                    style: GoogleFonts.tajawal(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                
                  Center(
                    child: _buildDrawerItem(
                      context,
                      title: "الاعدادات",
                      icon: Image.asset("assets/icons/setting_icon.png" , height: 40,width: 40,) ,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      ),
                    // ),
                    // _buildDrawerItem(
                    //   context,
                    //   title: 'القرآن الكريم',
                    //   icon: Lottie.asset(
                    //     'assets/animations/wired-lineal-112-book-hover-closed.json',
                    //     height: 28,
                    //     width: 28,
                    //   ),
                    //   onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => QuranPartsScreen()),
                    //   ),
                    // ),
                    // _buildDrawerItem(
                    //   context,
                    //   title: 'مواعيد الصلاة',
                    //   icon: Lottie.asset(
                    //     'assets/animations/wired-lineal-1923-mosque-hover-pinch.json',
                    //     height: 28,
                    //     width: 28,
                    //   ),
                    //   onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => PrayerDashboard()),
                    //   ),
                    ),
                  ),
                  const Divider(
                    height: 32,
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  // Add more items here as needed
                ],
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Version 1.0.0',
                style: GoogleFonts.tajawal(
                  fontSize: 12,
                  color: theme.colorScheme.primary.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String title,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: SizedBox(width: 40, height: 40, child: Center(child: icon)),
      title: Text(
        title,
        style: GoogleFonts.tajawal(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
      onTap: onTap,
      hoverColor: theme.colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}