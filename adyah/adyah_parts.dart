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

class AdyahPartsPage extends StatefulWidget {
  const AdyahPartsPage({super.key});

  @override
  State<AdyahPartsPage> createState() => _AdyahPartsPageState();
}

class _AdyahPartsPageState extends State<AdyahPartsPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
                  Image.asset(
                             'assets/images/duaa_img.png', // Dark mode animation
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              
                            ),
                   Text('أدعية' , style: TextStyle(fontSize: 25),),
                ],
              ),
              Divider(),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    context,
                    'الْأدْعِيَةُ القرآنية',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    AdyahAlquran(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                    'أدعية النَّبِيِّ',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    AdyahAlnabi(),
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
                    'أدعية الأنبياء',
                     Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    AdyahAlanbiaa(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                    'أدعية للميّت',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    AdyahForDead(),
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
                    'أدعية السفر',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    AdyahAlsafar(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                    'أدعية المطر',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    AdyahRaining(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                ],
              ),
               SizedBox(height: screenHeight * 0.04),
              _buildButton(
                context,
                'أدعية الرزق',
                Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                AdyahAlrizq(),
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
          children: [
            
            SizedBox(height: 8),
            Text(
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