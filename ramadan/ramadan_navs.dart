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
import 'package:athkary/pages/ramadan/laylat_alqader_info.dart';
import 'package:athkary/pages/ramadan/laylat_alqader_navs.dart';
import 'package:athkary/pages/ramadan/ramadan_duaa.dart';
import 'package:athkary/pages/ramadan/ramadan_health.dart';
import 'package:athkary/pages/ramadan/ramdan_quran_ketmah.dart';
import 'package:athkary/pages/ramadan/ramdan_sonan.dart';
import 'package:athkary/pages/tasabeh.dart';
import 'package:athkary/theme/dark_mode.dart';
import 'package:athkary/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:lottie/lottie.dart';
// import 'package:athkar_app/athkar.dart';

class RamadanNavs extends StatefulWidget {
  const RamadanNavs({super.key});

  @override
  State<RamadanNavs> createState() => _RamadanNavsState();
}

class _RamadanNavsState extends State<RamadanNavs> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final TextStyle textStyle2 = GoogleFonts.amiri(
    fontSize: 23 ,fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.inversePrimary, );

    final TextStyle textStyle1 = GoogleFonts.amiri(
    fontSize: 25,
    color: Theme.of(context).colorScheme.primary, );
    
    final TextStyle textStyle3 = GoogleFonts.amiri(
    fontSize: 17,
    color: Theme.of(context).colorScheme.primary, );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
            icon:   Icon(Icons.arrow_back_ios_new_rounded , color: Theme.of(context).colorScheme.primary,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
                  Lottie.asset(
                              'assets/animations/wired-flat-2024-rzeszow-city-hover-pinch.json', // Dark mode animation
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              animate: true,
                              repeat: true,
                            ),
                   Text(' رمضان' , style: textStyle1,),
                ],
              ),
              Divider(),

              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    context,
                    'سنن رمضانية',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    RamadanSunnahsPage(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                    'كيفية ختم القرآن',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    QuranCompletionMethodsScreen(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    context,
                    'رمضان والصحة',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    RamadanHealthBenefits(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                    'أدعية رمضان',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    RamadanDuaa(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                ],
              ),
               SizedBox(height: screenHeight * 0.04),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     _buildButton(
              //       context,
              //       'رمضان والصحة',
              //       Lottie.asset(
              //           "",
              //          width: 70,
              //          height: 70,
              //          fit: BoxFit.fill,
              //          animate: true,
              //          repeat: true,
              //        ),
              //       RamadanHealthBenefits(),
              //       screenWidth * 0.4,
              //       screenHeight * 0.2,
              //     ),
              //     _buildButton(
              //       context,
              //       'ليلة القدر',
              //       Lottie.asset(
              //           "",
              //          width: 70,
              //          height: 70,
              //          fit: BoxFit.fill,
              //          animate: true,
              //          repeat: true,
              //        ),
              //       LaylatAlqader(),
              //       screenWidth * 0.4,
              //       screenHeight * 0.2,
              //     ),
              //   ],
              // ), 
              _buildButton(
                context,
                'ليلة القدر',
                Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                LaylatAlQadrNav(),
                screenWidth * 0.6,
                screenHeight * 0.2,
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, Widget animation, Widget page, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(width, height)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.lalezar(
                color: Theme.of(context).colorScheme.inversePrimary,
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
      ),
    );
  }
}