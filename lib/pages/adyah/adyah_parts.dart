// ignore_for_file: unused_import


import 'package:athkary/Component/drawer.dart';
import 'package:athkary/Component/notification.dart';
import 'package:athkary/pages/adyah/adyah_alanbiaa.dart';
import 'package:athkary/pages/adyah/adyah_alnabi.dart';
import 'package:athkary/pages/adyah/adyah_alquran.dart';
import 'package:athkary/pages/adyah/adyah_alrizq.dart';
import 'package:athkary/pages/adyah/adyah_alsafar.dart';
import 'package:athkary/pages/adyah/adyah_for_dead.dart';
import 'package:athkary/pages/adyah/adyah_raining.dart';
import 'package:athkary/pages/athkar/athkar_almasaa.dart';
import 'package:athkary/pages/athkar/athkar_alsabah.dart';
import 'package:athkary/pages/masbahah_elc.dart';
import 'package:athkary/pages/quran/quran_page.dart';
import 'package:athkary/pages/tasabeh.dart';
import 'package:athkary/theme/dark_mode.dart';
import 'package:athkary/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:lottie/lottie.dart';
// import 'package:athkar_app/athkar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahPartsPage extends StatelessWidget {
  const AdyahPartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              // Header Section
              _buildHeader(context),
              const Divider(thickness: 1.5 , color: Colors.white,),
              const SizedBox(height: 24),
              
              // Supplication Categories Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildDuaaCategory(
                      context,
                      'الْأدْعِيَةُ القرآنية',
                      Icons.menu_book,
                      AdyahAlquran(),
                    ),
                    _buildDuaaCategory(
                      context,
                      'أدعية النَّبِيِّ',
                      Icons.dark_mode_sharp,
                      AdyahAlnabi(),
                    ),
                    _buildDuaaCategory(
                      context,
                      'أدعية الأنبياء',
                      Icons.collections_bookmark_rounded,
                      AdyahAlanbiaa(),
                    ),
                    _buildDuaaCategory(
                      context,
                      'أدعية للميّت',
                      Icons.monitor_heart_rounded,
                      AdyahForDead(),
                    ),
                    _buildDuaaCategory(
                      context,
                      'أدعية السفر',
                      Icons.directions_car,
                      AdyahAlsafar(),
                    ),
                    _buildDuaaCategory(
                      context,
                      'أدعية المطر',
                      Icons.water_drop,
                      AdyahRaining(),
                    ),
                    _buildDuaaCategory(
                      context,
                      'أدعية الرزق',
                      Icons.auto_stories_sharp,
                      AdyahAlrizq(),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Image.asset(
            'assets/images/duaa_img.png',
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Text(
            'أدعية',
            style: GoogleFonts.amiri(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48), // Balance the row
        ],
      ),
    );
  }

  Widget _buildDuaaCategory(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lalezar(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}