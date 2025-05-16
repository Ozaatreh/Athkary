import 'package:athkary/pages/sunnan_alnabi/sunnan_alnom.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_alsiam.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_eating_clothing.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_randoms.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_wadu_salah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SonanAlnabiNavs extends StatefulWidget {
  const SonanAlnabiNavs({super.key});

  @override
  State<SonanAlnabiNavs> createState() => _SonanAlnabiNavsState();
}

class _SonanAlnabiNavsState extends State<SonanAlnabiNavs> {
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
              
              SizedBox(height: screenSize.height * 0.02),
              const Divider(thickness: 1.2, color: Colors.white),
              SizedBox(height: screenSize.height * 0.03),
              
              // Grid Section
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
    return Row(
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
        Lottie.asset(
          'assets/animations/wired-flat-1845-rose-hover-pinch.json',
          width: screenSize.width * 0.2,
          height: screenSize.height * 0.1,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        Text(
          'سنن النَّبِيِّ',
          style: GoogleFonts.tajawal(
            fontSize: screenSize.height * 0.025,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Widget _buildGrid(BuildContext context, bool isPortrait, Size screenSize) {
    final crossAxisCount = isPortrait ? 2 : 3;
    final childAspectRatio = isPortrait ? 1.0 : 1.3;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: screenSize.height * 0.02,
      crossAxisSpacing: screenSize.width * 0.04,
      padding: EdgeInsets.all(screenSize.width * 0.02),
      children: [
        _buildCategoryCard(
          context,
          'سنن النوم',
          SleepSunnahsPage(),
          Icons.nightlight_round,
          screenSize,
        ),
        _buildCategoryCard(
          context,
          'سنن الوضوء والصلاة',
          WuduAndSalahSunnahsScreen(),
          Icons.water_drop,
          screenSize,
        ),
        _buildCategoryCard(
          context,
          'سنن الصيام',
          FastingSunnahsPage(),
          Icons.fastfood,
          screenSize,
        ),
        _buildCategoryCard(
          context,
          'سنن متنوعة',
          RandomsSunnahsScreen(),
          Icons.category,
          screenSize,
        ),
        _buildCategoryCard(
          context,
          'سنن اللباس و الطعام',
          ClothingAndEatingSunnahsScreen(),
          Icons.restaurant,
          screenSize,
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, 
    String title, 
    Widget page, 
    IconData icon,
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
          MaterialPageRoute(builder: (context) => page),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: screenSize.height * 0.06,
                color: Theme.of(context).colorScheme.surface,
              ),
              SizedBox(height: screenSize.height * 0.015),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lalezar(
                  fontSize: screenSize.height * 0.02,
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