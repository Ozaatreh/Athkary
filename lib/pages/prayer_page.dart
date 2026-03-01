import 'package:athkary/Component/athan_page.dart';
import 'package:athkary/services/athan_download_service.dart';
import 'package:athkary/services/prayer_time_service.dart';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared Preferences Keys
const String _athanSoundKey = 'selectedAthanSound';
const String _soundEnabledKey = 'soundEnabled';
const String _notificationsEnabledKey = 'notificationsEnabled';
const String _athanEnabledKey = 'athanEnabled';
const String _outsidePrayerPopupKey = 'outsidePrayerPopupEnabled';

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

Future<void> saveOutsidePrayerPopupEnabled(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_outsidePrayerPopupKey, enabled);
}

Future<Map<String, dynamic>> loadAllSettings() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'selectedAthanSound':
        prefs.getString(_athanSoundKey) ?? 'audios/athan_om_alqora.mp3',
    'soundEnabled': prefs.getBool(_soundEnabledKey) ?? true,
    'notificationsEnabled': prefs.getBool(_notificationsEnabledKey) ?? false,
    'athanEnabled': prefs.getBool(_athanEnabledKey) ?? true,
    'outsidePrayerPopupEnabled':
        prefs.getBool(_outsidePrayerPopupKey) ?? true,
  };
}

class PrayerDashboard extends StatefulWidget {
  @override
  _PrayerDashboardState createState() => _PrayerDashboardState();
}

class _PrayerDashboardState extends State<PrayerDashboard> {
  static const MethodChannel _prayerWidgetChannel =
      MethodChannel('athkary/prayer_widget');
  double latitude = 31.9539;
  double longitude = 35.9106;
  Map<String, String> prayerTimes = {};
  String currentPrayer = "";
  String nextPrayerTime = "";
  Duration timeLeft = Duration();
  bool notificationsEnabled = false;
  DateTime selectedDate = DateTime.now();
  bool athanEnabled = true;
  bool outsidePrayerPopupEnabled = true;
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
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      _updateNextPrayer();
      await _checkAndLaunchAthan();
    });
    initializeNotifications();
  }

  Future<void> _initializeLocation() async {
    final location = loc.Location();

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
    final location = loc.Location();
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

 Future<void> _updateCoordinates(
    double lat,
    double lon,
    {required String label}) async {

  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('latitude', lat);
  await prefs.setDouble('longitude', lon);

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
  Future<void> _updateLocationLabelFromCoordinates(
    double lat, double lon) async {
  try {
    final placemarks = await placemarkFromCoordinates(lat, lon);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;

      final country = place.country ?? '';
      final city = place.locality ?? place.administrativeArea ?? '';

      setState(() {
        _locationLabel = "$country - $city";
      });
    }
  } catch (e) {
    // fallback if geocoding fails
    setState(() {
      _locationLabel =
          "${lat.toStringAsFixed(3)}, ${lon.toStringAsFixed(3)}";
    });
  }
}
  void _showLocationSettings() {
  _latitudeController.text = latitude.toStringAsFixed(4);
  _longitudeController.text = longitude.toStringAsFixed(4);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  )
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Drag Handle
                    Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    /// Title
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: Color(0xFF0E5A2F)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'إعدادات الموقع',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'الموقع الحالي: $_locationLabel',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Use Current Location Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoadingLocation
                            ? null
                            : () async {
                                setModalState(
                                    () => _isLoadingLocation = true);
                                await _useCurrentLocation();
                                if (mounted) Navigator.pop(context);
                              },
                        icon: _isLoadingLocation
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.my_location_rounded),
                        label: Text(
                          _isLoadingLocation
                              ? 'جاري تحديد الموقع...'
                              : 'استخدام موقعي الحالي',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF0E5A2F),
                          padding:
                              const EdgeInsets.symmetric(
                                  vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Divider
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10),
                          child: Text("أو"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Latitude Field
                    _buildLocationInputField(
                      controller: _latitudeController,
                      label: "خط العرض (Latitude)",
                      icon: Icons.map_outlined,
                    ),

                    const SizedBox(height: 15),

                    /// Longitude Field
                    _buildLocationInputField(
                      controller: _longitudeController,
                      label: "خط الطول (Longitude)",
                      icon: Icons.public_rounded,
                    ),

                    const SizedBox(height: 25),

                    /// Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _saveManualLocation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF0E5A2F),
                          padding:
                              const EdgeInsets.symmetric(
                                  vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          elevation: 6,
                        ),
                        child: const Text(
                          "حفظ الموقع المخصص",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
Widget _buildLocationInputField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
}) {
  return TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(
        decimal: true, signed: true),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: const Color(0xFF0E5A2F)),
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(color: Color(0xFF0E5A2F), width: 2),
      ),
    ),
  );
}

  Future<void> _loadAllSettings() async {
    final settings = await loadAllSettings();
    setState(() {
      selectedAthanSound = settings['selectedAthanSound'];
      soundEnabled = settings['soundEnabled'];
      notificationsEnabled = settings['notificationsEnabled'];
      athanEnabled = settings['athanEnabled'];
      outsidePrayerPopupEnabled = settings['outsidePrayerPopupEnabled'];
      athanSound = selectedAthanSound;
    });

    // If notifications were enabled, schedule them again
    if (notificationsEnabled) {
      schedulePrayerNotifications();
    }
  }

  void initializeNotifications() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'prayer_with_sound',
          channelName: 'Prayer Notifications',
          channelDescription: 'Prayer time alerts with sound',
          importance: NotificationImportance.Max,
          defaultColor: const Color(0xFF0E5A2F),
          ledColor: const Color(0xFF0E5A2F),
          playSound: true,
          enableVibration: true,
          channelShowBadge: true,
          locked: true,
        ),
        NotificationChannel(
          channelKey: 'prayer_silent',
          channelName: 'Silent Prayer Notifications',
          channelDescription: 'Prayer alerts without sound',
          importance: NotificationImportance.High,
          defaultColor: const Color(0xFF0E5A2F),
          ledColor: const Color(0xFF0E5A2F),
          playSound: false,
          enableVibration: true,
        ),
      ],
    );

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
      "المغرب": prayerTimesData.maghrib/*.add(const Duration(minutes: 4))*/,
      "العشاء": prayerTimesData.isha/*.add(const Duration(minutes: 5))*/,
    };
  }

  void schedulePrayerNotifications() {
    final prayerOrder = [
      'الفجر',
      'الشروق',
      'الظهر',
      'العصر',
      'المغرب',
      'العشاء'
    ];
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
            title: '🕌 وقت الصلاة',
            body: 'حان الآن موعد ${entry.key}',
            payload: {
              'prayerName': entry.key,
              'prayerTime': DateFormat.jm().format(prayerTime),
              'outsidePopupEnabled':
                  outsidePrayerPopupEnabled.toString(),
            },
            bigPicture: null,
            notificationLayout: NotificationLayout.BigText,
            category: NotificationCategory.Reminder,
            wakeUpScreen: outsidePrayerPopupEnabled,
            fullScreenIntent:
                entry.key != "الشروق" && outsidePrayerPopupEnabled,
            autoDismissible: false,
            backgroundColor: const Color(0xFF0E5A2F),
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

  void toggleOutsidePrayerPopup(bool value) async {
    setState(() {
      outsidePrayerPopupEnabled = value;
    });
    await saveOutsidePrayerPopupEnabled(value);

    if (notificationsEnabled) {
      _cancelPrayerNotifications();
      schedulePrayerNotifications();
    }
  }

  void _showNotificationSettings() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  )
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Drag Handle
                    Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    /// Title
                    Row(
                      children: [
                        const Icon(Icons.notifications_active_rounded,
                            color: Color(0xFF0E5A2F)),
                        const SizedBox(width: 10),
                        Text(
                          "إعدادات الإشعارات",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    /// Notifications Section
                    _buildEnhancedSwitch(
                      context: context,
                      title: "تفعيل الإشعارات",
                      subtitle: "استقبال تنبيهات عند دخول وقت الصلاة",
                      value: notificationsEnabled,
                      icon: Icons.notifications_rounded,
                      onChanged: (value) {
                        setModalState(
                            () => notificationsEnabled = value);
                        toggleNotifications(value);

                        if (!value) {
                          setModalState(() => soundEnabled = false);
                          toggleSoundEnabled(false);
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    /// Sound Section
                    _buildEnhancedSwitch(
                      context: context,
                      title: "تشغيل صوت الإشعارات",
                      subtitle: "تنبيه صوتي مع إشعار وقت الصلاة",
                      value: soundEnabled,
                      icon: Icons.volume_up_rounded,
                      isEnabled: notificationsEnabled,
                      onChanged: notificationsEnabled
                          ? (value) {
                              setModalState(
                                  () => soundEnabled = value);
                              toggleSoundEnabled(value);
                            }
                          : null,
                    ),

                    const SizedBox(height: 18),

                    /// Athan Section
                    _buildEnhancedSwitch(
                      context: context,
                      title: "تفعيل الأذان الكامل",
                      subtitle: "تشغيل الأذان عند دخول وقت الصلاة",
                      value: athanEnabled,
                      icon: Icons.mosque_rounded,
                      onChanged: (value) {
                        setModalState(() => athanEnabled = value);
                        toggleAthanEnabled(value);
                      },
                    ),

                    const SizedBox(height: 18),

                    _buildEnhancedSwitch(
                      context: context,
                      title: "إظهار نافذة الأذان خارج التطبيق",
                      subtitle:
                          "تشغيل/إيقاف نافذة الأذان الكاملة من الإشعار",
                      value: outsidePrayerPopupEnabled,
                      icon: Icons.open_in_new_rounded,
                      isEnabled: notificationsEnabled,
                      onChanged: notificationsEnabled
                          ? (value) {
                              setModalState(
                                  () => outsidePrayerPopupEnabled = value);
                              toggleOutsidePrayerPopup(value);
                            }
                          : null,
                    ),

                    /// Animated Dropdown
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: athanEnabled
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 20),
                              child: _buildAthanSoundDropdown(
                                  context, setModalState),
                            )
                          : const SizedBox(),
                    ),

                    const SizedBox(height: 30),

                    /// Done Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF0E5A2F),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          padding:
                              const EdgeInsets.symmetric(vertical: 18),
                          elevation: 6,
                        ),
                        child: const Text(
                          "حفظ الإعدادات",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

 Widget _buildEnhancedSwitch({
  required BuildContext context,
  required String title,
  required String subtitle,
  required bool value,
  required IconData icon,
  bool isEnabled = true,
  required ValueChanged<bool>? onChanged,
}) {
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 200),
    opacity: isEnabled ? 1 : 0.5,
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.08),
            Theme.of(context).colorScheme.primary.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0E5A2F).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF0E5A2F)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: isEnabled ? onChanged : null,
            activeColor: const Color(0xFF0E5A2F),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildAthanSoundDropdown(
    BuildContext context, StateSetter setModalState) {
  final athanOptions = [
    {
      "title": "الأذان بصوت محمد الجازي",
      "value": "audios/athan1.mp3",
      "icon": Icons.mic_rounded,
    },
    {
      "title": "الأذان بصوت القارئ اسلام صبحي",
      "value": "audios/athan_islam_sobhi.mp3",
      "icon": Icons.record_voice_over_rounded,
    },
    {
      "title": "أذان ام القرى",
      "value": "audios/athan_om_alqora.mp3",
      "icon": Icons.mosque_rounded,
    },
  ];

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF0E5A2F).withOpacity(0.08),
          const Color(0xFF0E5A2F).withOpacity(0.03),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.music_note_rounded, color: Color(0xFF0E5A2F)),
            SizedBox(width: 8),
            Text(
              "اختيار صوت الأذان",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0E5A2F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        /// Modern Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF0E5A2F).withOpacity(0.3),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedAthanSound,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              onChanged: (value) async {
                if (value == null) return;

                setModalState(() => selectedAthanSound = value);
                await saveAthanSound(value);
                setState(() => athanSound = value);

                // 🔥 Pre-download instantly (better UX)
                try {
                  final fileName = value.split('/').last;
                  final athanService = AthanDownloadService();
                  await athanService.getOrDownloadAthan(fileName);
                } catch (_) {}
              },
              items: athanOptions.map((option) {
                final isSelected =
                    option["value"] == selectedAthanSound;

                return DropdownMenuItem<String>(
                  value: option["value"] as String,
                  child: Row(
                    children: [
                      Icon(
                        option["icon"] as IconData,
                        size: 20,
                        color: isSelected
                            ? const Color(0xFF0E5A2F)
                            : Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          option["title"] as String,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? const Color(0xFF0E5A2F)
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

  Future<void> calculatePrayerTimes({DateTime? date}) async {
  final rawTimes = PrayerTimeService.getPrayerTimes(
    latitude: latitude,
    longitude: longitude,
    date: date,
  );

  final formatted =
      PrayerTimeService.formatPrayerTimes(rawTimes);

  setState(() {
    prayerTimes = formatted;
  });

  await _syncPrayerWidget(formatted);
}

  Future<void> _syncPrayerWidget(Map<String, String> formatted) async {
    final prefs = await SharedPreferences.getInstance();
    const prayerKeys = ["الفجر", "الشروق", "الظهر", "العصر", "المغرب", "العشاء"];

    for (final key in prayerKeys) {
      await prefs.setString(key, formatted[key] ?? '--:--');
    }

    await prefs.setString('prayer_widget_location', _locationLabel);

    try {
      await _prayerWidgetChannel.invokeMethod(
        'refreshPrayerWidget',
        {
          'times': formatted,
          'location': _locationLabel,
        },
      );
    } catch (_) {
      // Ignore widget refresh errors; prayer screen should continue working.
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
          prayerTime = DateTime(
            now.year,
            now.month,
            now.day,
            prayerTime.hour,
            prayerTime.minute,
          );

          if (prayerTime.isAfter(now)) {
            nextPrayerDateTime = prayerTime;
            nextPrayerName = prayer;
            break;
          }
        } catch (_) {}
      }
    }

    // 🚨 IMPORTANT FIX: If no prayer left today → use tomorrow Fajr
    if (nextPrayerDateTime == null) {
      final tomorrow = now.add(const Duration(days: 1));

      final params = CalculationMethod.muslim_world_league.getParameters();
      final coordinates = Coordinates(latitude, longitude);
      final dateComponents =
          DateComponents(tomorrow.year, tomorrow.month, tomorrow.day);

      final prayerTimesTomorrow =
          PrayerTimes(coordinates, dateComponents, params);

      nextPrayerDateTime = prayerTimesTomorrow.fajr;
      nextPrayerName = "الفجر";
    }

    setState(() {
      currentPrayer = nextPrayerName!;
      nextPrayerTime = DateFormat.jm().format(nextPrayerDateTime!);
      timeLeft = nextPrayerDateTime.difference(now);
    });
  }

  Future<void> _checkAndLaunchAthan() async {
    if (!athanEnabled) return;

    final now = DateTime.now();

    for (var entry in prayerTimes.entries) {
      DateTime prayerTime = DateFormat.jm().parse(entry.value);
      prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      if (now.difference(prayerTime).inSeconds.abs() <= 1) {
        final athanKey =
            '${entry.key}-${DateFormat('yyyy-MM-dd HH:mm').format(prayerTime)}';

        if (_lastAthanKey == athanKey) return;
        _lastAthanKey = athanKey;

        // 🔥 Download or get cached file
        final athanService = AthanDownloadService();
        final fileName = selectedAthanSound.split('/').last;
        final localPath = await athanService.getOrDownloadAthan(fileName);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AthanPopup(
              prayerName: entry.key,
              prayerTime: entry.value,
              athanSoundPath: localPath,
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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
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
            icon: Icon(Icons.location_on_outlined,
                color: Theme.of(context).colorScheme.primary),
            onPressed: _showLocationSettings,
          ),
          IconButton(
            icon: Icon(
              notificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
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
                    icon: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                    icon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                  Icon(Icons.place_outlined,
                      color: Theme.of(context).colorScheme.primary),
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
                          color: isCurrent
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      title: Text(
                        entry.key,
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight:
                              isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      trailing: Text(
                        entry.value,
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight:
                              isCurrent ? FontWeight.bold : FontWeight.normal,
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
