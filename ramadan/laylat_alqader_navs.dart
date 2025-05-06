import 'package:athkary/pages/ramadan/laylat_alqader_duaa.dart';
import 'package:athkary/pages/ramadan/laylat_alqader_info.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class LaylatAlQadrNav extends StatefulWidget {
  const LaylatAlQadrNav({super.key});

  @override
  State<LaylatAlQadrNav> createState() => LaylatAlQadrNavState();
}

class LaylatAlQadrNavState extends State<LaylatAlQadrNav> {
 int selectedIndex = 0;
 
  // List of pages to display based on selected index
  final List<Widget> pages = [
     LaylatAlQadrInfoScreen(),
     LaylatAlQadrDuaScreen()
  ];
  // pages changer
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
    onWillPop: () async {
      // Handle custom back navigation logic here if needed
      // Returning `true` will allow the back action
      return false;
    },
      child: Scaffold(
          
          body: pages[selectedIndex],
      
          bottomNavigationBar: Container(
            color: const Color.fromARGB(255, 245, 244, 243),
            child: BottomNavigationBar(
              // mouseCursor: MouseCursor.defer,
            // useLegacyColorScheme: true,
            fixedColor: const Color.fromARGB(255, 227, 227, 30),
            selectedFontSize :16,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            backgroundColor: Theme.of(context).colorScheme.onPrimary  ,
            // selectedItemColor:const Color.fromARGB(255, 227, 227, 30) ,
            unselectedItemColor: Theme.of(context).colorScheme.primary,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items:  [
              BottomNavigationBarItem(
                icon: Lottie.asset(
                                'assets/animations/wired-lineal-1821-night-sky-moon-stars-hover-pinch.json', // Dark mode animation
                                width: 36,
                                height: 36,
                                fit: BoxFit.fill,
                                animate: true,
                                repeat: true,
                              ),
                label: 'معلومات عن ليلة القدر',
              ),
              
              BottomNavigationBarItem(
                icon: Lottie.asset(
                                'assets/animations/wired-flat-1821-night-sky-moon-stars-hover-pinch.json', // Dark mode animation
                                width: 36,
                                height: 36,
                                fit: BoxFit.fill,
                                animate: true,
                                repeat: true,
                              ),
                label: 'أدعية ليلة القدر',
              ),
              
            ],
                        ),
          ),
      
      ),
    );
    }
}
    
   