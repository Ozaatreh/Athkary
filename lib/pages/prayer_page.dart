import 'package:athkary/Component/athan_page.dart';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

// Shared Preferences Keys
const String _athanSoundKey = 'selectedAthanSound';
const String _soundEnabledKey = 'soundEnabled';
const String _notificationsEnabledKey = 'notificationsEnabled';
const String _athanEnabledKey = 'athanEnabled';

// Helper functions for SharedPreferences
Future<void> saveAthanSound(String path) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_athanSoundKey, path);
}

Future<String?> loadAthanSound() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_athanSoundKey);
}

Future<void> saveSoundPreference(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_soundEnabledKey, enabled);
}

Future<void> saveNotificationsEnabled(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_notificationsEnabledKey, enabled);
}

Future<void> saveAthanEnabled(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_athanEnabledKey, enabled);
}

Future<Map<String, dynamic>> loadAllSettings() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'selectedAthanSound': prefs.getString(_athanSoundKey) ?? 'audios/athan_om_alqora.mp3',
    'soundEnabled': prefs.getBool(_soundEnabledKey) ?? true,
    'notificationsEnabled': prefs.getBool(_notificationsEnabledKey) ?? false,
    'athanEnabled': prefs.getBool(_athanEnabledKey) ?? true,
  };
}

class PrayerDashboard extends StatefulWidget {
  @override
  _PrayerDashboardState createState() => _PrayerDashboardState();
}

class _PrayerDashboardState extends State<PrayerDashboard> {
  double latitude = 31.9539;
  double longitude = 35.9106;
  Map<String, String> prayerTimes = {};
  String currentPrayer = "";
  String nextPrayerTime = "";
  Duration timeLeft = Duration();
  bool notificationsEnabled = false;
  DateTime selectedDate = DateTime.now();
  bool athanEnabled = true;
  String selectedAthanSound = "audios/athan_om_alqora.mp3";
  String? athanSound;
  bool soundEnabled = true;
  Timer? _ticker;
  bool _isLoadingLocation = false;
  String _locationLabel = 'عمان، الأردن';
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String? _lastAthanKey;
  final Set<int> _prayerNotificationIds = <int>{};

  @override
  void initState() {
    super.initState();
    _loadAllSettings();
    _initializeLocation();
    calculatePrayerTimes();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateNextPrayer();
      _checkAndLaunchAthan();
    });
    initializeNotifications();
  }


  Future<void> _initializeLocation() async {
    final location = Location();

    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
      }

      if (serviceEnabled && permission == PermissionStatus.granted) {
        await _useCurrentLocation(showSuccessMessage: false);
      }
    } catch (_) {
      // Keep default location if current location is unavailable.
    }
  }

  Future<void> _useCurrentLocation({bool showSuccessMessage = true}) async {
    final location = Location();
    setState(() => _isLoadingLocation = true);
    try {
      final data = await location.getLocation();
      final lat = data.latitude;
      final lon = data.longitude;
      if (lat == null || lon == null) return;

      _updateCoordinates(
        lat,
        lon,
        label: 'الموقع الحالي',
      );

      if (showSuccessMessage && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تحديث الموقع الحالي')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تعذر الوصول إلى الموقع الحالي')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingLocation = false);
      }
    }
  }

  void _updateCoordinates(double lat, double lon, {required String label}) {
    setState(() {
      latitude = lat;
      longitude = lon;
      _locationLabel = label;
      _lastAthanKey = null;
    });
    calculatePrayerTimes(date: selectedDate);
  }

  void _saveManualLocation() {
    final lat = double.tryParse(_latitudeController.text.trim());
    final lon = double.tryParse(_longitudeController.text.trim());

    if (lat == null || lon == null || lat.abs() > 90 || lon.abs() > 180) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال إحداثيات صحيحة')),
      );
      return;
    }

    _updateCoordinates(lat, lon, label: 'موقع مخصص');
    Navigator.pop(context);
  }

  void _showLocationSettings() {
    _latitudeController.text = latitude.toStringAsFixed(4);
    _longitudeController.text = longitude.toStringAsFixed(4);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'الموقع',
                style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'يمكنك استخدام الموقع الحالي أو إدخال موقع يدويًا.',
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoadingLocation
                      ? null
                      : () async {
                          await _useCurrentLocation();
                          if (mounted) Navigator.pop(context);
                        },
                  icon: const Icon(Icons.my_location_rounded),
                  label: Text(_isLoadingLocation ? 'جاري التحديد...' : 'استخدام موقعي الحالي'),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _latitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(labelText: 'خط العرض (Latitude)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _longitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(labelText: 'خط الطول (Longitude)'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveManualLocation,
                  child: const Text('حفظ الموقع المخصص'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _loadAllSettings() async {
    final settings = await loadAllSettings();
    setState(() {
      selectedAthanSound = settings['selectedAthanSound'];
      soundEnabled = settings['soundEnabled'];
      notificationsEnabled = settings['notificationsEnabled'];
      athanEnabled = settings['athanEnabled'];
      athanSound = selectedAthanSound;
    });

    // If notifications were enabled, schedule them again
    if (notificationsEnabled) {
      schedulePrayerNotifications();
    }
  }

  void initializeNotifications() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }


  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Map<String, DateTime> _notificationPrayerTimesForDate(DateTime date) {
    final params = CalculationMethod.muslim_world_league.getParameters();
    final coordinates = Coordinates(latitude, longitude);
    final dateComponents = DateComponents(date.year, date.month, date.day);
    final prayerTimesData = PrayerTimes(coordinates, dateComponents, params);

    return {
      "الفجر": prayerTimesData.fajr,
      "الشروق": prayerTimesData.sunrise,
      "الظهر": prayerTimesData.dhuhr,
      "العصر": prayerTimesData.asr,
      "المغرب": prayerTimesData.maghrib.add(const Duration(minutes: 4)),
      "العشاء": prayerTimesData.isha.add(const Duration(minutes: 5)),
    };
  }

  void schedulePrayerNotifications() {
    final prayerOrder = ['الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'];
    final today = DateTime.now();
    final prayersForToday = _notificationPrayerTimesForDate(today);

    for (var entry in prayersForToday.entries) {
      final prayerTime = entry.value;

      if (prayerTime.isAfter(DateTime.now())) {
        final channelKey = entry.key == "الشروق"
            ? 'prayer_silent'
            : (soundEnabled ? 'prayer_with_sound' : 'prayer_silent');

        final prayerIndex = prayerOrder.indexOf(entry.key);
        final notificationId = prayerTime.year * 1000000 +
            prayerTime.month * 10000 +
            prayerTime.day * 100 +
            (prayerIndex < 0 ? 0 : prayerIndex);
        _prayerNotificationIds.add(notificationId);

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: notificationId,
            channelKey: channelKey,
            title: 'وقت الصلاة',
            body: 'حان الان موعد ${entry.key}',
          ),
          schedule: NotificationCalendar(
            year: prayerTime.year,
            month: prayerTime.month,
            day: prayerTime.day,
            hour: prayerTime.hour,
            minute: prayerTime.minute,
            second: 0,
            preciseAlarm: true,
            allowWhileIdle: true,
          ),
        );
      }
    }
  }

  void _cancelPrayerNotifications() {
    for (final id in _prayerNotificationIds) {
      AwesomeNotifications().cancel(id);
    }
    _prayerNotificationIds.clear();
  }

  void toggleNotifications(bool value) async {
    setState(() {
      notificationsEnabled = value;
    });

    await saveNotificationsEnabled(value);

    if (value) {
      _cancelPrayerNotifications();
      schedulePrayerNotifications();
    } else {
      _cancelPrayerNotifications();
    }
  }

  void toggleSoundEnabled(bool value) async {
    setState(() {
      soundEnabled = value;
    });
    await saveSoundPreference(value);

    // Reschedule notifications if they're enabled
    if (notificationsEnabled) {
      _cancelPrayerNotifications();
      schedulePrayerNotifications();
    }
  }

  void toggleAthanEnabled(bool value) async {
    setState(() {
      athanEnabled = value;
    });
    await saveAthanEnabled(value);
  }

  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "إعدادات الإشعارات",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Notifications Toggle
                    _buildSettingSwitch(
                      context: context,
                      title: "تفعيل الإشعارات",
                      value: notificationsEnabled,
                      onChanged: (value) {
                        setModalState(() => notificationsEnabled = value);
                        toggleNotifications(value);
                      },
                    ),

                    SizedBox(height: 20),

                    // Sound Toggle
                    _buildSettingSwitch(
                      context: context,
                      title: "تشغيل صوت الإشعارات",
                      value: soundEnabled,
                      onChanged: (value) {
                        setModalState(() => soundEnabled = value);
                        toggleSoundEnabled(value);
                      },
                    ),

                    SizedBox(height: 20),

                    // Athan Toggle
                    _buildSettingSwitch(
                      context: context,
                      title: "تفعيل الأذان",
                      value: athanEnabled,
                      onChanged: (value) {
                        setModalState(() => athanEnabled = value);
                        toggleAthanEnabled(value);
                      },
                    ),

                    // Athan Sound Selection (only if athanEnabled)
                    if (athanEnabled) ...[
                      SizedBox(height: 15),
                      _buildAthanSoundDropdown(context, setModalState),
                    ],

                    SizedBox(height: 20),

                    // Done Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "تم",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSettingSwitch({
    required BuildContext context,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            trackOutlineColor: WidgetStateProperty.all(
              value ? Color.fromARGB(255, 240, 235, 235)
                   : Color.fromARGB(255, 240, 237, 237),
            ),
            activeColor: Color.fromARGB(255, 63, 189, 67),
            thumbColor: WidgetStateProperty.all(
                value ? Colors.white : Colors.black),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildAthanSoundDropdown(BuildContext context, StateSetter setModalState) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "اختيار صوت الأذان : ",
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedAthanSound,
              onChanged: (value) async {
                if (value != null) {
                  setModalState(() => selectedAthanSound = value);
                  await saveAthanSound(value);
                  setState(() => athanSound = value);
                }
              },
              items: [
                DropdownMenuItem(
                  child: Text(
                    "الأذان بصوت محمد الجازي",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  value: "audios/athan1.mp3",
                ),
                DropdownMenuItem(
                  child: Text(
                    "الأذان بصوت القارئ اسلام صبحي",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  value: "audios/athan_islam_sobhi.mp3",
                ),
                DropdownMenuItem(
                  child: Text(
                    "أذان ام القرى",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  value: "audios/athan_om_alqora.mp3",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculatePrayerTimes({DateTime? date}) async {
    final params = CalculationMethod.muslim_world_league.getParameters();
    final coordinates = Coordinates(latitude, longitude);
    final today = date ?? DateTime.now();
    final dateComponents = DateComponents(today.year, today.month, today.day);
    final prayerTimesData = PrayerTimes(coordinates, dateComponents, params);

    final calculatedTimes = {
      "الفجر": DateFormat.jm().format(prayerTimesData.fajr),
      "الشروق": DateFormat.jm().format(prayerTimesData.sunrise),
      "الظهر": DateFormat.jm().format(prayerTimesData.dhuhr),
      "العصر": DateFormat.jm().format(prayerTimesData.asr),
      "المغرب": DateFormat.jm().format(
          prayerTimesData.maghrib.add(Duration(minutes: 4))),
      "العشاء": DateFormat.jm().format(
          prayerTimesData.isha.add(Duration(minutes: 5))),
    };

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    for (var entry in calculatedTimes.entries) {
      await prefs.setString(entry.key, entry.value);
    }

    setState(() {
      prayerTimes = calculatedTimes;
    });

    if (notificationsEnabled && _isSameDate(today, DateTime.now())) {
      _cancelPrayerNotifications();
      schedulePrayerNotifications();
    }
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
          prayerTime = DateTime(now.year, now.month, now.day,
                              prayerTime.hour, prayerTime.minute);

          if (prayerTime.isAfter(now)) {
            nextPrayerDateTime = prayerTime;
            nextPrayerName = prayer;
            break;
          }
        } catch (e) {
          print("Error parsing prayer time for $prayer: ${prayerTimes[prayer]} - $e");
        }
      }
    }

    if (nextPrayerDateTime != null) {
      setState(() {
        currentPrayer = nextPrayerName!;
        nextPrayerTime = prayerTimes[nextPrayerName]!;
        timeLeft = nextPrayerDateTime!.difference(now);
      });
    }
  }

  void _checkAndLaunchAthan() {
    if (!athanEnabled) return;

    final now = DateTime.now();
    for (var entry in prayerTimes.entries) {
      DateTime prayerTime = DateFormat.jm().parse(entry.value);
      prayerTime = DateTime(now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

      if (now.difference(prayerTime).inSeconds.abs() <= 1) {
        final athanKey = '${entry.key}-${DateFormat('yyyy-MM-dd HH:mm').format(prayerTime)}';
        if (_lastAthanKey == athanKey) continue;
        _lastAthanKey = athanKey;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AthanPopup(
              prayerName: entry.key,
              prayerTime: entry.value,
              athanSoundPath: athanSound ?? 'audios/athan_om_alqora.mp3',
            ),
          ),
        );
        break;
      }
    }
  }


  @override
  void dispose() {
    _ticker?.cancel();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).colorScheme.primary,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "أوقات الصلاة",
          style: GoogleFonts.tajawal(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.location_on_outlined, color: Theme.of(context).colorScheme.primary),
            onPressed: _showLocationSettings,
          ),
          IconButton(
            icon: Icon(notificationsEnabled
                ? Icons.notifications_active
                : Icons.notifications_off_outlined,
                color: Theme.of(context).colorScheme.primary,),
            onPressed: _showNotificationSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Date Selector
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left , color: Theme.of(context).colorScheme.primary,),
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.subtract(Duration(days: 1));
                        calculatePrayerTimes(date: selectedDate);
                      });
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        DateFormat('EEEE, d MMMM y').format(selectedDate),
                        style: GoogleFonts.tajawal(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,),
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.add(Duration(days: 1));
                        calculatePrayerTimes(date: selectedDate);
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.place_outlined, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'الموقع: $_locationLabel (${latitude.toStringAsFixed(3)}, ${longitude.toStringAsFixed(3)})',
                      style: GoogleFonts.tajawal(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Next Prayer Card
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "الصلاة القادمة",
                    style: GoogleFonts.tajawal(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentPrayer,
                    style: GoogleFonts.tajawal(
                      fontSize: 28,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    nextPrayerTime,
                    style: GoogleFonts.tajawal(
                      fontSize: 36,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    " ${timeLeft.inHours} H  ${timeLeft.inMinutes.remainder(60)} Min  ${timeLeft.inSeconds.remainder(60)} Sec  : متبقي",
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // All Prayer Times
            Text(
              "أوقات الصلاة اليوم",
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 15),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: prayerTimes.entries.map((entry) {
                  bool isCurrent = entry.key == currentPrayer;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.1),
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
                              ? Theme.of(context).colorScheme.surface.withOpacity(0.2)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.access_time,
                          color: isCurrent
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      title: Text(
                        entry.key,
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      trailing: Text(
                        entry.value,
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
