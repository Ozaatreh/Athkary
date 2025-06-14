// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';

import 'package:adhan/adhan.dart';
import 'package:athkary/Component/athan_page.dart';
import 'package:athkary/Component/drawer.dart';
import 'package:athkary/Component/notification.dart';
import 'package:athkary/Component/qiblah_compass.dart';
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
import 'package:intl/intl.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'athkar/athkar_alsabah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> _prayerTimes = {};
  String _currentPrayer = "";
  String _currentPrayerTime = "";
  bool _athanLaunched = false;
  Timer? _timer;
  String athanSound = 'audios/athan_islam_sobhi.mp3';
  Map<String, String> prayerTimes = {};
  final List<Map<String, dynamic>> defaultFeatures = [
    {
      'title': 'القرآن الكريم',
      'animationPath':
          'assets/animations/wired-lineal-112-book-hover-closed.json',
      'page': QuranPartsScreen(),
      'type': 'small',
    },
    {
      'title': 'أسماء الله الحسنى',
      'animationPath': 'assets/images/allah_.png',
      'page': AlahNames(),
      'type': 'small',
    },
    {
      'title': 'سنن النَّبِيِّ',
      'animationPath':
          'assets/animations/wired-flat-1845-rose-hover-pinch.json',
      'page': SonanAlnabiNavs(),
      'type': 'small',
    },
    {
      'title': 'تسابيح',
      'animationPath':
          'assets/animations/wired-flat-12-layers-hover-slide.json',
      'page': Tasabeh(),
      'type': 'small',
    },
    {
      'title': 'اذكار الصباح',
      'animationPath':
          'assets/animations/wired-lineal-1958-sun-hover-pinch.json',
      'page': AthkarAlsabah(),
      'type': 'small',
    },
    {
      'title': 'اذكار المساء',
      'animationPath':
          'assets/animations/wired-lineal-1865-shooting-stars-hover-pinch.json',
      'page': AthkarAlmasaa(),
      'type': 'small',
    },
    {
      'title': 'القبلة',
      'animationPath': 'assets/images/compass_v2.png',
      'page': QiblahScreen(),
      'type': 'large',
    },
    {
      'title': 'أدعيه',
      'animationPath': 'assets/images/duaa_img.png',
      'page': AdyahPartsPage(),
      'type': 'large',
    },
    {
      'title': 'مواعيد الصلاه',
      'animationPath':
          'assets/animations/wired-lineal-1923-mosque-hover-pinch.json',
      'page': PrayerDashboard(),
      'type': 'large',
    },
    {
      'title': 'المسبحة الالكترونية',
      'animationPath':
          'assets/animations/wired-gradient-49-plus-circle-hover-rotation.json',
      'page': MasbahaElc(),
      'type': 'large',
    },
  ];

  List<Map<String, dynamic>> _features = [];

  @override
  void initState() {
    super.initState();
    _calculatePrayerTimes();
    _updateCurrentPrayer();
    _loadUserFeatures();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _calculatePrayerTimes();
      _updateCurrentPrayer();
      _checkAndLaunchAthan();
    });
  }

  void _loadUserFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList('feature_order');

    if (savedOrder != null) {
      _features = savedOrder.map((title) {
        return defaultFeatures.firstWhere((f) => f['title'] == title);
      }).toList();
    } else {
      _features = List.from(defaultFeatures);
    }

    setState(() {});
  }

  Future<void> _saveFeatureOrder(List<Map<String, dynamic>> orderedList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> titles =
        orderedList.map((item) => item['title'] as String).toList();
    await prefs.setStringList('feature_order', titles);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _features.removeAt(oldIndex);
      _features.insert(newIndex, item);
    });
    _saveFeatureOrder(_features);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculatePrayerTimes() {
    final params = CalculationMethod.muslim_world_league.getParameters();
    final coords = Coordinates(31.9539, 35.9106);
    final today = DateTime.now();
    final times = PrayerTimes(
      coords,
      DateComponents(today.year, today.month, today.day),
      params,
    );

    setState(() {
      _prayerTimes = {
        "الفجر": DateFormat.jm().format(times.fajr),
        "الشروق": DateFormat.jm().format(times.sunrise),
        "الظهر": DateFormat.jm().format(times.dhuhr),
        "العصر": DateFormat.jm().format(times.asr),
        "المغرب":
            DateFormat.jm().format(times.maghrib.add(Duration(minutes: 4))),
        "العشاء": DateFormat.jm().format(times.isha.add(Duration(minutes: 5))),
      };
    });
  }

  void _updateNextPrayer() {
    final now = DateTime.now();
    final prayerKeys = ["الفجر", "الظهر", "العصر", "المغرب", "العشاء"];
    DateTime? nextPrayerDateTime;
    String? nextPrayerName;

    for (var prayer in prayerKeys) {
      if (prayerTimes[prayer] != null) {
        try {
          DateTime prayerTime = DateFormat.jm().parse(prayerTimes[prayer]!);
          prayerTime = DateTime(
              now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

          if (prayerTime.isAfter(now)) {
            nextPrayerDateTime = prayerTime;
            nextPrayerName = prayer;
            break;
          }
        } catch (e) {
          print(
              "Error parsing prayer time for $prayer: ${prayerTimes[prayer]} - $e");
        }
      }
    }
  }

  void _updateCurrentPrayer() {
    final now = DateTime.now();
    for (var entry in _prayerTimes.entries.toList().reversed) {
      final pt = DateFormat.jm().parse(entry.value);
      final dt = DateTime(now.year, now.month, now.day, pt.hour, pt.minute);
      if (now.isAfter(dt.subtract(Duration(seconds: 1)))) {
        setState(() {
          _currentPrayer = entry.key;
          _currentPrayerTime = entry.value;
        });
        break;
      }
    }
  }

  void _checkAndLaunchAthan() {
    if (!_athanLaunched && _currentPrayer.isNotEmpty) {
      final now = DateTime.now();
      final pt = DateFormat.jm().parse(_currentPrayerTime);
      final sched = DateTime(now.year, now.month, now.day, pt.hour, pt.minute);

      if ((now.difference(sched).inSeconds).abs() <= 1) {
        _athanLaunched = true;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AthanPopup(
            prayerName: _currentPrayer,
            prayerTime: _currentPrayerTime,
            athanSoundPath: athanSound,
          ),
        );

        Future.delayed(Duration(minutes: 2), () {
          _athanLaunched = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(context, theme, screenWidth),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              _buildHeroSection(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildFeaturesGrid(context, screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ThemeData theme, double screenWidth) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Lottie.asset(
            'assets/animations/wired-flat-63-home-loop-smoke.json',
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        'أذكاري',
        style: GoogleFonts.tajawal(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.notifications_none, size: screenWidth * 0.07),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  Widget _buildHeroSection(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: LiquidSwipe(
          pages: [
            // Image Page
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/athk_pic3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Prayer Times Page
            Container(
              color: Theme.of(context).colorScheme.primary ,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'أوقات الصلاة',
                    style: GoogleFonts.tajawal(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _prayerTimes.length,
                      separatorBuilder: (_, __) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final entry = _prayerTimes.entries.elementAt(index);
                        final isCurrent = entry.key == _currentPrayer;
                        return ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: isCurrent 
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
                          ),
                          title: Text(
                            entry.key,
                            style: GoogleFonts.tajawal(
                              fontSize: screenWidth * 0.045,
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          trailing: Text(
                            entry.value,
                            style: GoogleFonts.tajawal(
                              fontSize: screenWidth * 0.045,
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          fullTransitionValue: 700,
          slideIconWidget: Icon(
            Icons.swipe_left,
            size: 16,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          positionSlideIcon: 0.1,
          waveType: WaveType.liquidReveal,
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        //   child: Text(
        //     'الأدوات',
        //     style: GoogleFonts.tajawal(
        //       fontSize: screenWidth * 0.055,
        //       fontWeight: FontWeight.bold,
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //   ),
        // ),
        SizedBox(height: screenHeight * 0.02),
        ReorderableWrap(
          spacing: screenWidth * 0.05,
          runSpacing: screenWidth * 0.05,
          padding: EdgeInsets.zero,
          onReorder: _onReorder,
          children: _features.map((feature) {
            return feature['type'] == 'large'
                ? _buildLargeFeatureCard(
                    context,
                    feature['title'],
                    feature['animationPath'],
                    feature['page'],
                    screenWidth,
                    screenHeight,
                  )
                : _buildSmallFeatureCard(
                    context,
                    feature['title'],
                    feature['animationPath'],
                    feature['page'],
                    screenWidth,
                    screenHeight,
                  );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSmallFeatureCard(
    BuildContext context,
    String title,
    String animationPath,
    Widget page,
    double screenWidth,
    double screenHeight,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      child: Container(
        width: (screenWidth - screenWidth * 0.15) / 2,
        height: screenHeight * 0.18,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: animationPath.endsWith('.json')
                    ? Lottie.asset(
                        animationPath,
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      )
                    : Image.asset(
                        animationPath,
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeFeatureCard(
    BuildContext context,
    String title,
    String animationPath,
    Widget page,
    double screenWidth,
    double screenHeight,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.12,
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: animationPath.endsWith('.json')
                    ? Lottie.asset(
                        animationPath,
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      )
                    : Image.asset(
                        animationPath,
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      ),
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.tajawal(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: screenWidth * 0.04,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}

  // Widget _buildFeatureCard(
  //   BuildContext context,
  //   String title,
  //   String animationPath,
  //   Widget page,
  //   double cardSize,
  //   double fontSize,
  //   double animationSize,
  // ) {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(16),
  //     onTap: () => Navigator.push(
  //       context,
  //       PageRouteBuilder(
  //         transitionDuration: const Duration(milliseconds: 500),
  //         pageBuilder: (_, __, ___) => page,
  //         transitionsBuilder: (_, animation, __, child) => FadeTransition(
  //           opacity: animation,
  //           child: child,
  //         ),
  //       ),
  //     ),
  //     child: Card(
  //       elevation: 4,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       color: Theme.of(context).colorScheme.primary,
  //       child: Container(
  //         width: cardSize ,
  //         height: cardSize,
  //         padding: EdgeInsets.all(cardSize * 0.05),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(16),
  //           gradient: LinearGradient(
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //             colors: [
  //               Theme.of(context).colorScheme.primary.withOpacity(0.8),
  //               Theme.of(context).colorScheme.primary,
  //             ],
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
  //               blurRadius: 10,
  //               offset: const Offset(0, 4),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             animationPath.endsWith('.json')
  //                 ? Lottie.asset(
  //                     animationPath,
  //                     width: animationSize,
  //                     height: animationSize,
  //                     fit: BoxFit.contain,
  //                   )
  //                 : Image.asset(
  //                     animationPath,
  //                     width: animationSize,
  //                     height: animationSize,
  //                     fit: BoxFit.contain,
  //                   ),
  //             SizedBox(height: cardSize * 0.05),
  //             Text(
  //               title,
  //               textAlign: TextAlign.center,
  //               style: GoogleFonts.tajawal(
  //                 fontSize: fontSize,
  //                 fontWeight: FontWeight.w600,
  //                 color: Theme.of(context).colorScheme.inversePrimary,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildLargeFeatureCard(
  //   BuildContext context,
  //   String title,
  //   String animationPath,
  //   Widget page,
  //   double cardHeight,
  //   double fontSize,
  //   double animationSize,
  // ) {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(16),
  //     onTap: () => Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => page),
  //     ),
  //     child: Container(
  //       height: cardHeight,
  //       margin: EdgeInsets.symmetric(vertical: cardHeight * 0.05),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16),
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [
  //             Theme.of(context).colorScheme.primary.withOpacity(0.8),
  //             Theme.of(context).colorScheme.primary,
  //           ],
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
  //             blurRadius: 10,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             flex: 2,
  //             child: Padding(
  //               padding: EdgeInsets.all(cardHeight * 0.1),
  //               child: Text(
  //                 title,
  //                 style: GoogleFonts.tajawal(
  //                   fontSize: fontSize,
  //                   fontWeight: FontWeight.w700,
  //                   color: Theme.of(context).colorScheme.inversePrimary,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: EdgeInsets.all(cardHeight * 0.05),
  //               child: animationPath.endsWith('.json')
  //                   ? Lottie.asset(
  //                       animationPath,
  //                       width: animationSize,
  //                       height: animationSize,
  //                       fit: BoxFit.contain,
  //                     )
  //                   : Image.asset(
  //                       animationPath,
  //                       width: animationSize,
  //                       height: animationSize,
  //                       fit: BoxFit.contain,
  //                     ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

