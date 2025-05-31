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

    // Calculate responsive sizes
    final smallCardSize = screenWidth * 0.4; // 40% of screen width
    final largeCardHeight = screenHeight * 0.13; // 12% of screen height
    final titleFontSize = screenWidth * 0.05; // 6% of screen width
    final smallTitleFontSize = screenWidth * 0.049; // 4.5% of screen width
    final animationSize = screenWidth * 0.15; // 15% of screen width

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Lottie.asset(
              'assets/animations/wired-flat-63-home-loop-smoke.json',
              width: animationSize,
              height: animationSize,
              fit: BoxFit.contain,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'أذكاري',
          style: GoogleFonts.tajawal(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(  screenWidth * 0.01),
          child: Column(
            children: [
              // Hero Image

              LiquidSwipe(
  pages: [
    // First page - Image
    Container(
      height: MediaQuery.of(context).size.height * 0.42,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(16), // Consistent margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/images/athk_pic3.png',
          fit: BoxFit.cover, // Changed from fill to cover for better aspect ratio
        ),
      ),
    ),

    // Second page - Prayer Times
    Container(
      height: MediaQuery.of(context).size.height * 0.42, // Same height
      margin: const EdgeInsets.all(16), // Same margin
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 198, 198, 198),
        borderRadius: BorderRadius.circular(15), // Same border radius
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListView(
        children: _prayerTimes.entries.map((entry) {
          bool isCurrent = entry.key == _currentPrayer;
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCurrent
                      ? Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.2)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary,
                ),
              ),
              title: Text(
                entry.key,
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: isCurrent
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary,
                ),
              ),
              trailing: Text(
                entry.value,
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: isCurrent
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  ],
  fullTransitionValue: 700,
  slideIconWidget: Icon(Icons.swipe_left_outlined,
  size: 16,
      color: const Color.fromARGB(255, 249, 248, 248)),
  positionSlideIcon: 0.20,
  waveType: WaveType.liquidReveal,
),

              SizedBox(
                height: 20,
              ),

              ReorderableWrap(
                spacing: screenWidth * 0.075,
                runSpacing: screenWidth * 0.04,
                padding: EdgeInsets.zero,
                needsLongPressDraggable: true,
                onReorder: _onReorder,
                children: _features.map((feature) {
                  if (feature['type'] == 'large') {
                    return SizedBox(
                      width: double.infinity,
                      child: _buildLargeFeatureCard(
                        context,
                        feature['title'],
                        feature['animationPath'],
                        feature['page'],
                        largeCardHeight,
                        titleFontSize,
                        animationSize,
                      ),
                    );
                  } else {
                    return SizedBox(
                    width: (screenWidth - screenWidth * 0.075) / 2 - 8, // adjust for spacing
                    child: _buildFeatureCard(
                      context,
                      feature['title'],
                      feature['animationPath'],
                      feature['page'],
                      smallCardSize,
                      smallTitleFontSize,
                      animationSize * 0.7,
                    ),
                  );
                  }
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String animationPath,
    Widget page,
    double cardSize,
    double fontSize,
    double animationSize,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).colorScheme.primary,
        child: Container(
          width: cardSize ,
          height: cardSize,
          padding: EdgeInsets.all(cardSize * 0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                Theme.of(context).colorScheme.primary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              animationPath.endsWith('.json')
                  ? Lottie.asset(
                      animationPath,
                      width: animationSize,
                      height: animationSize,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      animationPath,
                      width: animationSize,
                      height: animationSize,
                      fit: BoxFit.contain,
                    ),
              SizedBox(height: cardSize * 0.05),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeFeatureCard(
    BuildContext context,
    String title,
    String animationPath,
    Widget page,
    double cardHeight,
    double fontSize,
    double animationSize,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        height: cardHeight,
        margin: EdgeInsets.symmetric(vertical: cardHeight * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.primary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(cardHeight * 0.1),
                child: Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(cardHeight * 0.05),
                child: animationPath.endsWith('.json')
                    ? Lottie.asset(
                        animationPath,
                        width: animationSize,
                        height: animationSize,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        animationPath,
                        width: animationSize,
                        height: animationSize,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
