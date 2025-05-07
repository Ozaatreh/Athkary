// ignore_for_file: unused_import


import 'package:athkary/Component/drawer.dart';
import 'package:athkary/Component/notification.dart';
import 'package:athkary/pages/adyah/adyah_parts.dart';
import 'package:athkary/pages/alah_names.dart';
import 'package:athkary/pages/athkar/athkar_almasaa.dart';
import 'package:athkary/pages/masbahah_elc.dart';
import 'package:athkary/pages/prayer_page.dart';
import 'package:athkary/pages/quran/quran_page.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_alnabi_navs.dart';
import 'package:athkary/pages/tasabeh.dart';
import 'package:athkary/theme/dark_mode.dart';
import 'package:athkary/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:lottie/lottie.dart';

import 'athkar/athkar_alsabah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Lottie.asset(
              'assets/animations/wired-flat-63-home-loop-smoke.json',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'أذكاري',
          style: GoogleFonts.tajawal(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer:  CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Hero Image
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/athk_pic3.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Grid of Features
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildFeatureCard(
                    context,
                    'القرآن الكريم',
                    'assets/animations/wired-lineal-112-book-hover-closed.json',
                    QuranPartsScreen(),
                  ),
                  // _buildFeatureCard(
                  //   context,
                  //   'رمضان',
                  //   'assets/animations/wired-flat-2024-rzeszow-city-hover-pinch.json',
                  //   RamadanNavs(),
                  // ),
                   _buildFeatureCard(
                    context,
                    'أسماء الله الحسنى',
                    'assets/animations/stare_blink.json',
                    AlahNames(),
                  ),
                  _buildFeatureCard(
                    context,
                    'سنن النَّبِيِّ',
                    'assets/animations/wired-flat-1845-rose-hover-pinch.json',
                    SonanAlnabiNavs(),
                  ),
                  _buildFeatureCard(
                    context,
                    'تسابيح',
                    'assets/animations/wired-flat-12-layers-hover-slide.json',
                    Tasabeh(),
                  ),
                  _buildFeatureCard(
                    context,
                    'اذكار الصباح',
                    'assets/animations/wired-lineal-1958-sun-hover-pinch.json',
                    AthkarAlsabah(),
                  ),
                  _buildFeatureCard(
                    context,
                    'اذكار المساء',
                    'assets/animations/wired-lineal-1865-shooting-stars-hover-pinch.json',
                    AthkarAlmasaa(),
                  ),
                ],
              ),

              // Larger Bottom Buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    
                    InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdyahPartsPage()),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.primary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'أدعيه',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
            Expanded(
              child:Image.asset('assets/images/duaa_img.png')
            ),
          ],
        ),
      ),
    ),
                    // _buildLargeFeatureCard(
                    //   context,
                    //   'أدعيه',
                    //   'assets/images/duaa_img.png',
                    //   AdyahPartsPage(),
                    // ),
                    const SizedBox(height: 16),
                    _buildLargeFeatureCard(
                      context,
                      'مواعيد الصلاه',
                      'assets/animations/wired-lineal-1923-mosque-hover-pinch.json',
                      PrayerDashboard(),
                    ),
                    const SizedBox(height: 16),
                    _buildLargeFeatureCard(
                      context,
                      'المسبحة الالكترونية',
                      'assets/animations/wired-gradient-49-plus-circle-hover-rotation.json',
                      MasbahaElc(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, String animationPath, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                animationPath,
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeFeatureCard(
      BuildContext context, String title, String animationPath, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.primary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Lottie.asset(
                animationPath,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}