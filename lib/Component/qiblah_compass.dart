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
    _qiblahStream = FlutterQiblah.qiblahStream;
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
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.02),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: theme.colorScheme.primary,
                    size: screenSize.width * 0.07,
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
                ),
              ],
            ),
            _locationEnabled
                ? Expanded(
                    child: StreamBuilder<QiblahDirection>(
                      stream: FlutterQiblah.qiblahStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                                strokeWidth: 3,
                              ),
                              SizedBox(height: screenSize.height * 0.02),
                              Text(
                                "جاري تحديد الاتجاه...",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.045,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          );
                        }

                        final qiblahDirection = snapshot.data!;
                        final direction = qiblahDirection.qiblah;
                        updateCompass(-direction * (pi / 180));
                        _degreeText = "${qiblahDirection.direction.toInt()}°";

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: screenSize.height * 0.02),
                              Text(
                                "اتجاه القبلة",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.03),
                              // Degree indicator
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.06,
                                  vertical: screenSize.height * 0.015,
                                ),
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
                                      size: screenSize.width * 0.05,
                                    ),
                                    SizedBox(width: screenSize.width * 0.02),
                                    Text(
                                      _degreeText,
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.055,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.04),
                              // Compass
                              Container(
                                padding: EdgeInsets.all(screenSize.width * 0.05),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AnimatedBuilder(
                                      animation: _animation,
                                      builder: (context, child) => Transform.rotate(
                                        angle: _animation.value,
                                        child: Image.asset(
                                          'assets/images/qiblah_v5d.png',
                                          width: isPortrait 
                                              ? screenSize.width * 0.8 
                                              : screenSize.height * 0.6,
                                          height: isPortrait 
                                              ? screenSize.width * 0.8 
                                              : screenSize.height * 0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.04),
                              // Help text
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                                child: Text(
                                  "قم بتوجيه الجهاز نحو القبلة كما هو موضح في الشاشة",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.04,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.05),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_off_rounded,
                              size: screenSize.width * 0.15,
                              color: theme.primaryColor,
                            ),
                            SizedBox(height: screenSize.height * 0.03),
                            Text(
                              _statusMessage,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.045,
                                color: isDarkMode ? Colors.white70 : Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenSize.height * 0.05),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.08,
                                  vertical: screenSize.height * 0.02,
                                ),
                              ),
                              onPressed: _checkLocationPermission,
                              child: Text(
                                "تفعيل خدمة الموقع",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
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