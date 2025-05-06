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
    
    final TextStyle textStyle2 = GoogleFonts.amiri(
    fontSize: 19 ,fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.inversePrimary, );

    final TextStyle textStyle1 = GoogleFonts.amiri(
    fontSize: 25,
    color: Theme.of(context).colorScheme.primary, );
    
    final TextStyle textStyle3 = GoogleFonts.amiri(
    fontSize: 17,
    color: Theme.of(context).colorScheme.inversePrimary, );

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
                              'assets/animations/wired-flat-1845-rose-hover-pinch.json', // Dark mode animation
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              animate: true,
                              repeat: true,
                            ),
                   Text('سنن النَّبِيِّ' , style: textStyle1,),
                ],
              ),
              Divider(),

              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    context,
                    'سنن النوم',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    SleepSunnahsPage(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                  'سنن الوضوء والصلاة',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    WuduAndSalahSunnahsScreen(),
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
                    'سنن الصيام',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                    FastingSunnahsPage(),
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                  _buildButton(
                    context,
                    'سنن متنوعة',
                    Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
                      RandomsSunnahsScreen(), 
                    screenWidth * 0.4,
                    screenHeight * 0.2,
                  ),
                ],
              ),
               SizedBox(height: screenHeight * 0.04),
              _buildButton(
                context,
                'سنن اللباس و الطعام',
                Lottie.asset(
                        "",
                       width: 70,
                       height: 70,
                       fit: BoxFit.fill,
                       animate: true,
                       repeat: true,
                     ),
               ClothingAndEatingSunnahsScreen(),
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
