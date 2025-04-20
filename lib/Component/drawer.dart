
import 'package:athkary/pages/adyah/adyah_parts.dart';
import 'package:athkary/pages/alah_names.dart';
import 'package:athkary/pages/athkar/athkar_almasaa.dart';
import 'package:athkary/pages/prayer_page.dart';
import 'package:athkary/pages/quran/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({
    super.key,
  });

  // final IconData icon;
  // final String title;
  // final Function() onPress;
  // Color color1 = Color.fromARGB(255, 184, 154, 104);
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
             height: MediaQuery.of(context).size.height,
             width:  MediaQuery.of(context).size.width /1.5 ,
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                      children: [
              SizedBox(height: 15,),
               Container(
                height: 120,width: 120, 
                child: Lottie.asset(
                          'assets/animations/wired-lineal-1923-mosque-in-reveal.json', // Dark mode animation
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                          animate: true,
                          repeat: false,
                        ),
               ),
             
              SizedBox(height:5,),
      
               Divider(height: 10, color: Theme.of(context).colorScheme.primary, thickness: 1,),
      
               SizedBox(height: 25,),          
              // TextButton.icon(
              //   iconAlignment: IconAlignment.end,
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(
              //                  builder: ((context) =>  Tasabeh() ),),);},
              //   // icon: Lottie.asset(
              //   //           'assets/animations/wired-flat-12-layers-hover-slide.json', // Dark mode animation
              //   //           width: 40,
              //   //           height: 40,
              //   //           fit: BoxFit.fill,
              //   //           animate: true,
              //   //           repeat: true,
              //   //         ),
              //   label: Text(
              //     "      تسابيح",
              //     style: GoogleFonts.amiri(
              //       color: Theme.of(context).colorScheme.primary,
              //       textStyle: const TextStyle(fontSize: 19),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 25,),
      
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                               builder: ((context) =>  AlahNames() ),),);
                },
                icon: Row(
                  children: [
                    Image.asset('assets/images/allah_.png' ,height: 40,width: 40,)
                    // Lottie.asset(
                    //           'assets/animations/wired-lineal-1958-sun-hover-pinch.json', // Dark mode animation
                    //           width: 40,
                    //           height: 40,
                    //           fit: BoxFit.fill,
                    //           animate: true,
                    //           repeat: true,
                    //         ),
                  ],
                ),
                label: Text(
                  'اسماء الله الحسنى',
                  style: GoogleFonts.amiri(
                    color: Theme.of(context).colorScheme.primary,
                    textStyle: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 25,),
      
              // TextButton.icon(
              //   iconAlignment: IconAlignment.end,
              //   onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(
              //                  builder: ((context) =>  AthkarAlmasaa() ),),);
              //   },
              //   icon: Lottie.asset(
              //             'assets/animations/wired-lineal-1865-shooting-stars-hover-pinch.json', // Dark mode animation
              //             width: 40,
              //             height: 40,
              //             fit: BoxFit.fill,
              //             animate: true,
              //             repeat: true,
              //           ),
              //   label: Text(
              //     "اذكار المساء",
              //     style: GoogleFonts.amiri(
              //       color: Theme.of(context).colorScheme.primary,
              //       textStyle: const TextStyle(fontSize: 19),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 25,),
              
              
      
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                               builder: ((context) => QuranPartsScreen() ),),);
                },
                icon: Lottie.asset(
                          'assets/animations/wired-lineal-112-book-hover-closed.json', // Dark mode animation
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                          animate: true,
                          repeat: true,
                        ),
                label: Text(
                  "القرآن الكريم" ,
                  style: GoogleFonts.amiri(
                    color: Theme.of(context).colorScheme.primary,
                    textStyle: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
      
              // SizedBox(height: 25,),
               
              // TextButton.icon(
              //   iconAlignment: IconAlignment.end,
              //   onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(
              //                  builder: ((context) => AdyahPartsPage() ),),);
              //   },
              //   icon: Lottie.asset(
              //             'assets/animations/wired-lineal-1270-fetus-hover-pinch.json', // Dark mode animation
              //             width: 40,
              //             height: 40,
              //             fit: BoxFit.fill,
              //             animate: true,
              //             repeat: true,
              //           ),
              //   label: Text(
              //     "     أدعيه " ,
              //     style: GoogleFonts.amiri(
              //       color: Theme.of(context).colorScheme.primary,
              //       textStyle: const TextStyle(fontSize: 20),
              //     ),
              //   ),
              // ), 
             
                SizedBox(height: 25,),

              TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                               builder: ((context) => PrayerDashboard() ),),);
                },
                icon: Lottie.asset(
                          'assets/animations/wired-lineal-1923-mosque-hover-pinch.json', // Dark mode animation
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                          animate: true,
                          repeat: true,
                        ),
                label: Text(
                  "مواعيد الصلاه" ,
                  style: GoogleFonts.amiri(
                    color: Theme.of(context).colorScheme.primary,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ), 
               ],
                    ),
            
      ),
    );
  }
}
