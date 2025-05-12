import 'dart:math';
import 'package:athkary/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _previousDirection = 0.0;
  bool _locationEnabled = false;
  String _statusMessage = "جارٍ التحقق من صلاحية الموقع...";
  String _directionText = "";
  String _degreeText = "";
late Stream<QiblahDirection> _qiblahStream;

@override
void initState() {
  super.initState();
  _checkLocationPermission();
  _qiblahStream = FlutterQiblah.qiblahStream; // Warm up early
  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
}


  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _statusMessage = "يرجى تفعيل خدمة الموقع لتحديد اتجاه القبلة";
      });
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _statusMessage = "تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات الجهاز";
      });
      return;
    }

    setState(() {
      _locationEnabled = true;
    });
  }

  // String getDirectionText(double offset) {
  //   if (offset.abs() <= 5) {
  //     return "أنت تتجه نحو الكعبة مباشرة";
  //   } else if (offset > 5) {
  //     return "قم بتدوير جهازك إلى اليسار";
  //   } else {
  //     return "قم بتدوير جهازك إلى اليمين";
  //   }
  // }

  void updateCompass(double newDirection) {
    debugPrint('Updating compass from $_previousDirection to $newDirection');
    _animation = Tween(begin: _previousDirection, end: newDirection).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );
    _previousDirection = newDirection;
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)),
                ),
               
              ],
            ),
            // const SizedBox(height: 10),
            _locationEnabled
                ? StreamBuilder<QiblahDirection>(
                    stream: FlutterQiblah.qiblahStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 220),
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                              strokeWidth: 3,
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                "جاري تحديد الاتجاه...",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
            
                      final qiblahDirection = snapshot.data!;
                      final direction = qiblahDirection.qiblah;
                      // final offset = qiblahDirection.offset;
            
                      updateCompass(-direction * (pi / 180));
                      // _directionText = getDirectionText(offset);
                      _degreeText = "${qiblahDirection.direction.toInt()}°";
            
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                               "اتجاه القبلة",
                               style: TextStyle(
                                 fontSize: 22,
                                 fontWeight: FontWeight.bold,
                                 color: theme.colorScheme.primary,
                               ),
                             ),
                          ),
                           SizedBox(height: 20,),
                          // Degree indicator
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.explore,
                                  color: theme.colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _degreeText,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          
                          // Compass
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode ? theme.colorScheme.primary.withOpacity(0.1) : theme.colorScheme.inversePrimary.withOpacity(0.1) ,
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 230,
                                  height: 160,
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   color: isDarkMode ? Colors.grey[850] : Colors.white,
                                  //   boxShadow: [
                                  //     BoxShadow(
                                  //       color: Colors.black.withOpacity(0.2),
                                  //       blurRadius: 2,
                                  //       spreadRadius: 1,
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) => Transform.rotate(
                                    angle: _animation.value,
                                    child: Image.asset(
                                      'assets/images/qiblah_v4.png',
                                      width: 260,
                                      height: 260,
                                    ),
                                  ),
                                ),
                                // Center marker
                                // Container(
                                //   width: 12,
                                //   height: 12,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     color: theme.colorScheme.primary,
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: theme.primaryColor.withOpacity(0.5),
                                //         blurRadius: 8,
                                //         spreadRadius: 2),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          
                          // // Direction text
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 40),
                          //   child: Text(
                          //     _directionText,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.w600,
                          //       color: theme.colorScheme.primary,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          
                          // Help text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "قم بتوجيه الجهاز نحو القبلة كما هو موضح في الشاشة",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_off_rounded,
                            size: 60,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _statusMessage,
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode ? Colors.white70 : Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            onPressed: _checkLocationPermission,
                            child: const Text(
                              "تفعيل خدمة الموقع",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
} 