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
  late final AnimationController _animationController;
  late Animation<double> _animation;
  double _previousDirection = 0.0;
  bool _locationEnabled = false;
  String _statusMessage = "جارٍ التحقق من صلاحية الموقع...";
  String _degreeText = "";
  String _locationText = 'جارٍ تحديد الموقع...';
  late final Stream<QiblahDirection> _qiblahStream;
  double _previousDegree = 0.0;
bool _isHeadingCorrect = false;
double _directionThreshold = 5.0;
  // Cached values
  late final ThemeData _theme;
  late final bool _isDarkMode;
  late final double _screenWidth;
  late final double _screenHeight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _qiblahStream = FlutterQiblah.qiblahStream;
    _checkLocationPermission();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache values that depend on context
    _theme = Theme.of(context);
    _isDarkMode = _theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
  }

  Future<void> _checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _statusMessage = "يرجى تفعيل خدمة الموقع لتحديد اتجاه القبلة";
        });
      }
      await Geolocator.openLocationSettings();
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever && mounted) {
      setState(() {
        _statusMessage = "تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات الجهاز";
      });
      return;
    }

    if (mounted) {
      setState(() {
        _locationEnabled = true;
      });
    }

    await _loadCurrentLocationLabel();
  }


  Future<void> _loadCurrentLocationLabel() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _locationText =
            'الموقع الحالي: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _locationText = 'تعذر تحديد الموقع الحالي';
      });
    }
  }

 void updateCompass(double newDirection) {
  final degreeDifference = (newDirection - _previousDirection).abs();

  // Only update if the change is significant (more than 1 degree)
  if (degreeDifference > (pi / 180)) {
    _animation = Tween(begin: _previousDirection, end: newDirection).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );
    _previousDirection = newDirection;
    _animationController.forward(from: 0);

    // Check if we're heading in the right direction
    final currentDegree = (newDirection * (180 / pi)).abs();
    final degreeChange = (currentDegree - _previousDegree).abs();

    if (degreeChange > _directionThreshold) {
      _previousDegree = currentDegree;
      final newHeadingState = currentDegree <= _directionThreshold;
      if (newHeadingState != _isHeadingCorrect) {
        setState(() {
          _isHeadingCorrect = newHeadingState;
        });
      }
    }
  }
}

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(_theme.colorScheme.primary),
          strokeWidth: 3,
        ),
        SizedBox(height: _screenHeight * 0.02),
        Text(
          "جاري تحديد الاتجاه...",
          style: TextStyle(
            fontSize: _screenWidth * 0.045,
            color: _theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildCompassContent(QiblahDirection qiblahDirection) {
    final direction = qiblahDirection.qiblah;
    updateCompass(-direction * (pi / 180));
    _degreeText = "${qiblahDirection.direction.toInt()}°";

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: _screenHeight * 0.02),
          Text(
            "اتجاه القبلة",
            style: TextStyle(
              fontSize: _screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: _theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: _screenHeight * 0.015),
          Container(
            margin: EdgeInsets.symmetric(horizontal: _screenWidth * 0.08),
            padding: EdgeInsets.symmetric(
              horizontal: _screenWidth * 0.04,
              vertical: _screenHeight * 0.012,
            ),
            decoration: BoxDecoration(
              color: _theme.colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _theme.colorScheme.primary.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.place_rounded, color: _theme.colorScheme.primary),
                SizedBox(width: _screenWidth * 0.02),
                Expanded(
                  child: Text(
                    _locationText,
                    style: TextStyle(
                      fontSize: _screenWidth * 0.035,
                      color: _theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: _screenHeight * 0.03),
          // Degree indicator
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _screenWidth * 0.06,
              vertical: _screenHeight * 0.015,
            ),
            decoration: BoxDecoration(
              color: _theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.explore,
                  color: _theme.colorScheme.primary,
                  size: _screenWidth * 0.05,
                ),
                SizedBox(width: _screenWidth * 0.02),
                Text(
                  _degreeText,
                  style: TextStyle(
                    fontSize: _screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: _theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Icon(
              Icons.arrow_drop_down,
              size: 40,
              color: const Color.fromARGB(255, 234, 177, 4),
            ),
          ),
          // Compass
          Container(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Transform.rotate(
                angle: _animation.value,
                child: Image.asset(
                  'assets/images/compass_v3.png',
                  width: _screenWidth,
                  cacheWidth: (_screenWidth * MediaQuery.of(context).devicePixelRatio).round(),
                  filterQuality: FilterQuality.low, // Better performance for animations
                ),
              ),
            ),
          ),
          Text(
            "قم بتوجيه الجهاز نحو القبلة كما هو موضح في الشاشة",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _screenWidth * 0.04,
              color: _theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: _screenHeight * 0.05),
        ],
      ),
    );
  }

  Widget _buildLocationDisabledContent() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: _screenWidth * 0.15,
              color: _theme.primaryColor,
            ),
            SizedBox(height: _screenHeight * 0.03),
            Text(
              _statusMessage,
              style: TextStyle(
                fontSize: _screenWidth * 0.045,
                color: _isDarkMode ? Colors.white70 : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _screenHeight * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: _screenWidth * 0.08,
                  vertical: _screenHeight * 0.02,
                ),
              ),
              onPressed: _checkLocationPermission,
              child: Text(
                "تفعيل خدمة الموقع",
                style: TextStyle(
                  fontSize: _screenWidth * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 42, 5),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: _screenHeight * 0.02),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: _theme.colorScheme.primary,
                    size: _screenWidth * 0.07,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _locationEnabled
                  ? StreamBuilder<QiblahDirection>(
                      stream: _qiblahStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return _buildLoadingIndicator();
                        }
                        return _buildCompassContent(snapshot.data!);
                      },
                    )
                  : _buildLocationDisabledContent(),
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
