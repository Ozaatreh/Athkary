// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'package:athkary/pages/ramadan/ramadan_navs.dart';
import 'package:athkary/quranv3/quran_v3_page.dart';
import 'package:athkary/services/prayer_time_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  String _nextPrayerName = "";
  Duration _timeLeft = Duration.zero;
  final List<Map<String, dynamic>> defaultFeatures = [
    {
      'title': 'القرآن الكريم',
      'animationPath':
          'assets/animations/wired-lineal-112-book-hover-closed.json',
      'page': QuranPartsScreen(),
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
      'title': 'رمضان',
      'animationPath':
          'assets/animations/wired-flat-1821-night-sky-moon-stars-hover-pinch.json',
      'page': RamadanNavs(),
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
      'animationPath': 'assets/images/compass_v3.png',
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
    {
      'title': 'أسماء الله الحسنى',
      'animationPath': 'assets/images/allah_.png',
      'page': AlahNames(),
      'type': 'small',
    },
  
    {
       'title': 'Quran Cloud',
       'animationPath':
           'assets/animations/wired-lineal-112-book-hover-flutter.json',
       'page': QuranV3Page(),
       'type': 'small',
    },
  
  ];

  List<Map<String, dynamic>> _features = [];

  @override
void initState() {
  super.initState();
  _initializeHome();
}
  Future<void> _initializeHome() async {
  await _calculatePrayerTimes();
  _updateCurrentPrayer();
  _loadUserFeatures();

  _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
    await _calculatePrayerTimes();
    _updateCurrentPrayer();
    _checkAndLaunchAthan();
    _checkForUpdate();
    _updateNextPrayer(); 
  });
}
  Future<void> _checkForUpdate() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  
  try {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    
    await remoteConfig.fetchAndActivate();
    
    final minAppVersion = remoteConfig.getString('min_app_version');
    final updateUrl = remoteConfig.getString('update_url');
    
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    
    if (_compareVersions(currentVersion, minAppVersion) < 0) {
      _showUpdateDialog(updateUrl);
    }
  } catch (e) {
    print('Error fetching remote config: $e');
  }
}

int _compareVersions(String v1, String v2) {
  final v1Parts = v1.split('.').map(int.parse).toList();
  final v2Parts = v2.split('.').map(int.parse).toList();
  
  for (var i = 0; i < v1Parts.length; i++) {
    if (v1Parts[i] > v2Parts[i]) return 1;
    if (v1Parts[i] < v2Parts[i]) return -1;
  }
  
  return 0;
}

void _showUpdateDialog(String updateUrl) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تحديث متاح', style: GoogleFonts.tajawal()),
        content: Text(
          'يوجد إصدار جديد من التطبيق. يرجى التحديث للحصول على أفضل تجربة.',
          style: GoogleFonts.tajawal(),
        ),
        actions: [
          TextButton(
            child: Text('تحديث الآن', style: GoogleFonts.tajawal()),
            onPressed: () async {
              if (await canLaunch(updateUrl)) {
                await launch(updateUrl);
              }
            },
          ),
        ],
      );
    },
  );
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

 Future<void> _calculatePrayerTimes() async {
  final prefs = await SharedPreferences.getInstance();

  final lat = prefs.getDouble('latitude') ?? 31.9539;
  final lon = prefs.getDouble('longitude') ?? 35.9106;

  final rawTimes = PrayerTimeService.getPrayerTimes(
    latitude: lat,
    longitude: lon,
  );

  final formatted =
      PrayerTimeService.formatPrayerTimes(rawTimes);

  setState(() {
    _prayerTimes = formatted;
  });
}
void _updateNextPrayer() async {
  final prefs = await SharedPreferences.getInstance();
  final lat = prefs.getDouble('latitude') ?? 31.9539;
  final lon = prefs.getDouble('longitude') ?? 35.9106;

  final rawTimes = PrayerTimeService.getPrayerTimes(
    latitude: lat,
    longitude: lon,
  );

  final now = DateTime.now();

  DateTime? nextPrayerTime;
  String? nextName;

  for (var entry in rawTimes.entries) {
    if (entry.value.isAfter(now)) {
      nextPrayerTime = entry.value;
      nextName = entry.key;
      break;
    }
  }

  // If no prayer left today → tomorrow fajr
  if (nextPrayerTime == null) {
    final tomorrow = now.add(const Duration(days: 1));
    final tomorrowTimes = PrayerTimeService.getPrayerTimes(
      latitude: lat,
      longitude: lon,
      date: tomorrow,
    );
    nextPrayerTime = tomorrowTimes["الفجر"];
    nextName = "الفجر";
  }

  setState(() {
    _nextPrayerName = nextName!;
    _timeLeft = nextPrayerTime!.difference(now);
  });
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
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isLandscape = screenWidth > screenHeight;
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
              _buildFeaturesGrid(context, screenWidth, screenHeight, isLandscape),
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

  Widget _buildHeroSection(
  BuildContext context,
  double screenWidth,
  double screenHeight,
) {
  final cards = [
    _buildImageCard(screenWidth, screenHeight),
    _buildNextPrayerCard(screenWidth, screenHeight),
  ];

  return SizedBox(
    height: screenHeight * (screenWidth > screenHeight ? 0.75 : 0.48),
    child: CardSwiper(
      padding: const EdgeInsets.symmetric(vertical: 8),
      cardsCount: cards.length,
      numberOfCardsDisplayed: 2,
      backCardOffset: const Offset(0, 20),
      cardBuilder: (context, index, _, __) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: cards[index],
      ),
    ),
  );
}
 Widget _buildImageCard(double screenWidth, double screenHeight) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      'assets/images/athk_pic3.png',
      fit: BoxFit.cover,
    ),
  );
}
Widget _buildNextPrayerCard(
    double screenWidth,
    double screenHeight) {

  final isLandscape =
      screenWidth > screenHeight;

  final circleSize =
      isLandscape ? screenHeight * 0.45 : screenWidth * 0.4;

  final titleSize =
      isLandscape ? screenHeight * 0.07 : screenWidth * 0.055;

  final countdownSize =
      isLandscape ? screenHeight * 0.08 : screenWidth * 0.065;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF0E5A2F),
          Color(0xFF145A32),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: SingleChildScrollView( // 🔥 Prevent overflow
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "الصلاة القادمة",
                  style: GoogleFonts.tajawal(
                    fontSize: titleSize,
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: isLandscape ? 10 : 20),

                /// Responsive Circle
                Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: FittedBox( // 🔥 Prevent text overflow
                      child: Text(
                        _nextPrayerName,
                        style: GoogleFonts.tajawal(
                          fontSize: circleSize * 0.25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isLandscape ? 12 : 25),

                FittedBox( // 🔥 Prevent overflow
                  child: Text(
                    "${_timeLeft.inHours.toString().padLeft(2, '0')} : "
                    "${_timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0')} : "
                    "${_timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                    style: GoogleFonts.tajawal(
                      fontSize: countdownSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: isLandscape ? 6 : 10),

                Text(
                  "متبقي على الأذان",
                  style: GoogleFonts.tajawal(
                    fontSize: isLandscape
                        ? screenHeight * 0.05
                        : screenWidth * 0.04,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
 Widget _buildFeaturesGrid(
  BuildContext context,
  double screenWidth,
  double screenHeight,
  bool isLandscape,
){
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
          spacing: isLandscape ? 20 : screenWidth * 0.05,
          runSpacing: isLandscape ? 20 : screenWidth * 0.05,
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
  final isLandscape = screenWidth > screenHeight;

  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    child: SizedBox(
      width: isLandscape
          ? (screenWidth - 60) / 3   // 3 columns in landscape
          : (screenWidth - 60) / 2,  // 2 columns portrait
      child: AspectRatio(
        aspectRatio: isLandscape ? 1.2 : 0.9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.12),
                Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.15),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final iconSize = constraints.maxWidth * 0.35;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                    child: Center(
                      child: animationPath.endsWith('.json')
                          ? Lottie.asset(animationPath,
                              width: iconSize * 0.7)
                          : Image.asset(animationPath,
                              width: iconSize * 0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
  double screenWidth,
  double screenHeight,
) {
  final isLandscape = screenWidth > screenHeight;

  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    ),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(0.15),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final iconSize = isLandscape
                  ? constraints.maxHeight * 0.6
                  : 50.0;

              return Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Center(
                  child: animationPath.endsWith('.json')
                      ? Lottie.asset(animationPath,
                          width: iconSize * 0.6)
                      : Image.asset(animationPath,
                          width: iconSize * 0.6),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: isLandscape ? 16 : 18,
                fontWeight: FontWeight.w600,
                color:
                    Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18),
        ],
      ),
    ),
  );
}
}

