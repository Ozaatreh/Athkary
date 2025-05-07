import 'package:athkary/pages/sunnan_alnabi/sunnan_alnom.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_alsiam.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_eating_clothing.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_randoms.dart';
import 'package:athkary/pages/sunnan_alnabi/sunnan_wadu_salah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
// import 'package:athkar_app/athkar.dart';

class SonanAlnabiNavs extends StatefulWidget {
  const SonanAlnabiNavs({super.key});

  @override
  State<SonanAlnabiNavs> createState() => _SonanAlnabiNavsState();
}

class _SonanAlnabiNavsState extends State<SonanAlnabiNavs> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final textStyle1 = GoogleFonts.amiri(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Header with back button and title
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Lottie.asset(
                    'assets/animations/wired-flat-1845-rose-hover-pinch.json',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  Text(
                  'سنن النَّبِيِّ',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                  // Text('سنن النَّبِيِّ', style: textStyle1),
                  const Spacer(flex: 2),
                ],
              ),
              
              const Divider(thickness: 1.2, color: Colors.white,),
              SizedBox(height: screenHeight * 0.03),
              
              // Grid of Sunnah categories
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  padding: const EdgeInsets.all(8),
                  children: [
                    _buildCategoryCard(
                      context,
                      'سنن النوم',
                      SleepSunnahsPage(),
                      Icons.nightlight_round,
                    ),
                    _buildCategoryCard(
                      context,
                      'سنن الوضوء والصلاة',
                      WuduAndSalahSunnahsScreen(),
                      Icons.water_drop,
                    ),
                    _buildCategoryCard(
                      context,
                      'سنن الصيام',
                      FastingSunnahsPage(),
                      Icons.fastfood,
                    ),
                    _buildCategoryCard(
                      context,
                      'سنن متنوعة',
                      RandomsSunnahsScreen(),
                      Icons.category,
                    ),
                    _buildCategoryCard(
                      context,
                      'سنن اللباس و الطعام',
                      ClothingAndEatingSunnahsScreen(),
                      Icons.restaurant,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, Widget page, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
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