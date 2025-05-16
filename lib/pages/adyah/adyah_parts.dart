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
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.02,
          ),
          child: Column(
            children: [
              // Header Section
              _buildHeader(context, screenSize),
              Divider(
                thickness: screenSize.height * 0.002,
                color: Colors.white,
              ),
              SizedBox(height: screenSize.height * 0.03),
              
              // Supplication Categories Grid
              Expanded(
                child: _buildGrid(context, isPortrait, screenSize),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: screenSize.height * 0.03,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Image.asset(
            'assets/images/duaa_img.png',
            width: screenSize.width * 0.15,
            height: screenSize.height * 0.08,
            fit: BoxFit.contain,
          ),
          SizedBox(width: screenSize.width * 0.02),
          const Spacer(),
          Text(
            'أدعية',
            style: GoogleFonts.amiri(
              fontSize: screenSize.height * 0.03,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          SizedBox(width: screenSize.width * 0.1), // Balance the row
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, bool isPortrait, Size screenSize) {
    final crossAxisCount = isPortrait ? 2 : 3;
    final childAspectRatio = isPortrait ? 1.1 : 1.3;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: screenSize.height * 0.02,
      crossAxisSpacing: screenSize.width * 0.04,
      padding: EdgeInsets.all(screenSize.width * 0.02),
      children: [
        _buildDuaaCategory(
          context,
          'الْأدْعِيَةُ القرآنية',
          Icons.menu_book,
          AdyahAlquran(),
          screenSize,
        ),
        _buildDuaaCategory(
          context,
          'أدعية النَّبِيِّ',
          Icons.dark_mode_sharp,
          AdyahAlnabi(),
          screenSize,
        ),
        _buildDuaaCategory(
          context,
          'أدعية الأنبياء',
          Icons.collections_bookmark_rounded,
          AdyahAlanbiaa(),
          screenSize,
        ),
        _buildDuaaCategory(
          context,
          'أدعية للميّت',
          Icons.monitor_heart_rounded,
          AdyahForDead(),
          screenSize,
        ),
        _buildDuaaCategory(
          context,
          'أدعية السفر',
          Icons.directions_car,
          AdyahAlsafar(),
          screenSize,
        ),
        _buildDuaaCategory(
          context,
          'أدعية المطر',
          Icons.water_drop,
          AdyahRaining(),
          screenSize,
        ),
        _buildDuaaCategory(
          context,
          'أدعية الرزق',
          Icons.auto_stories_sharp,
          AdyahAlrizq(),
          screenSize,
        ),
      ],
    );
  }

  Widget _buildDuaaCategory(
    BuildContext context, 
    String title, 
    IconData icon, 
    Widget page,
    Size screenSize,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenSize.width * 0.03),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        borderRadius: BorderRadius.circular(screenSize.width * 0.03),
        onTap: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => page)
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: screenSize.height * 0.05,
                color: Theme.of(context).colorScheme.surface,
              ),
              SizedBox(height: screenSize.height * 0.015),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lalezar(
                  fontSize: screenSize.height * 0.018,
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