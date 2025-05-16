import 'package:athkary/Component/athan_page.dart';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveAthanSound(String path) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedAthanSound', path);
}

Future<String?> loadAthanSound() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('selectedAthanSound');
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
  String selectedAthanSound = "audios/athan1.mp3";
  String? athanSound;

  @override
  void initState() {
    super.initState();
//       Future.delayed(Duration(seconds: 6), () {
//    Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => AthanPopup(
//   prayerName: currentPrayer,
//   prayerTime: prayerTimes[currentPrayer] ?? '',
//   athanSoundPath: athanSound ?? 'audios/athan1.mp3',
// ),
  // ),
// );
  // }
  // );
  
   loadAthanSound().then((path) {
  setState(() {
    athanSound = path ?? selectedAthanSound;
  });
});

    _loadNotificationState();
    _calculatePrayerTimes();
    _updateNextPrayer();
    _checkAndLaunchAthan();
   Timer.periodic(Duration(seconds: 1), (timer) {
  _updateNextPrayer();
  _checkAndLaunchAthan();
});

    initializeNotifications();
  }

/// Loads the notification state from SharedPreferences
void _loadNotificationState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    notificationsEnabled = prefs.getBool('notificationsEnabled')!;
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
  
  void schedulePrayerNotifications() {
    for (var entry in prayerTimes.entries) {
      DateTime prayerTime = DateFormat.jm().parse(entry.value);
      prayerTime = DateTime(DateTime.now().year, DateTime.now().month, 
          DateTime.now().day, prayerTime.hour, prayerTime.minute);
      
      if (prayerTime.isAfter(DateTime.now())) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: entry.key.hashCode,
            channelKey: 'prayer_channel',
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
    AwesomeNotifications().cancelAll();
  }

  void toggleNotifications(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = value;
    });

    await prefs.setBool('notificationsEnabled', value);

    if (value) {
      schedulePrayerNotifications();
    } else {
      _cancelPrayerNotifications();
    }
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
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
            
                // إشعارات Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            Text(
              "تفعيل الإشعارات",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setModalState(() {
                  notificationsEnabled = value;
                });
                toggleNotifications(value);
              },
              trackOutlineColor: WidgetStateProperty.all(
                notificationsEnabled
                    ? Color.fromARGB(255, 240, 235, 235)
                    : Color.fromARGB(255, 240, 237, 237),
              ),
              activeColor: Color.fromARGB(255, 63, 189, 67),
              thumbColor: WidgetStateProperty.all(
                  notificationsEnabled ? Colors.white : Colors.black),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor:
                  Theme.of(context).colorScheme.primary,
            ),
                    ],
                  ),
                ),
            
                SizedBox(height: 20),
            
                // أذان Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            Text(
              "تفعيل الأذان",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Switch(
              value: athanEnabled,
              onChanged: (value) {
                setModalState(() {
                  athanEnabled = value;
                });
                // Optional: Add a function to handle athan toggle
              },
              trackOutlineColor: WidgetStateProperty.all(
                notificationsEnabled
                    ? Color.fromARGB(255, 240, 235, 235)
                    : Color.fromARGB(255, 240, 237, 237),
              ),
              activeColor: Color.fromARGB(255, 63, 189, 67),
              thumbColor: WidgetStateProperty.all(
                  athanEnabled ? Colors.white : Colors.black),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor:
                  Theme.of(context).colorScheme.primary,
            ),
                    ],
                  ),
                ),
            
                // اختيار صوت الأذان (only if athanEnabled)
                if (athanEnabled) ...[
                  SizedBox(height: 15),
                  Container(
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
                SizedBox(width: 10), // optional spacing between text and dropdown
                Flexible(
                  child: DropdownButton<String>(
                    isExpanded: true, // so it fills available width
                    value: selectedAthanSound,
                    onChanged: (value) async {
              if (value != null) {
                setModalState(() {
                  selectedAthanSound = value;
                });
            
                // Save it to SharedPreferences
                await saveAthanSound(value);
            
                // Update athanSound immediately
                setState(() {
                  athanSound = value;
                });
              }
            },
            
                    items: [
            DropdownMenuItem(
              child: Text("الأذان بصوت محمد الجازي" , 
              style: TextStyle( fontSize: 15,color: Theme.of(context).colorScheme.primary,),),
              value: "audios/athan1.mp3",
            ),
            DropdownMenuItem(
              child: Text("الأذان بصوت القارئ اسلام صبحي",
              style: TextStyle( fontSize: 15,color: Theme.of(context).colorScheme.primary,),),
              value: "audios/athan_islam_sobhi.mp3",
            ),
            DropdownMenuItem(
              child: Text("الأذان بصوت ياسر الدوسري",
              style: TextStyle( fontSize: 15,color: Theme.of(context).colorScheme.primary,),),
              value: "audios/athan_yaseer_dosary.mp3",
            ),
            DropdownMenuItem(
              child: Text("أذان ام القرى",
              style: TextStyle( fontSize: 15,color: Theme.of(context).colorScheme.primary,),),
              value: "audios/athan_om_alqora.mp3",
            ),
                    ],
                  ),
                ),
              ],
            ),
            
                  ),
                ],
            
                SizedBox(height: 20),
            
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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

  void _calculatePrayerTimes({DateTime? date}) {
    final params = CalculationMethod.muslim_world_league.getParameters();
    final coordinates = Coordinates(latitude, longitude);
    final today = date ?? DateTime.now();
    final dateComponents = DateComponents(today.year, today.month, today.day);
    final prayerTimesData = PrayerTimes(coordinates, dateComponents, params);

    setState(() {
      prayerTimes = {
        "الفجر": DateFormat.jm().format(prayerTimesData.fajr),
        "الشروق": DateFormat.jm().format(prayerTimesData.sunrise),
        "الظهر": DateFormat.jm().format(prayerTimesData.dhuhr),
        "العصر": DateFormat.jm().format(prayerTimesData.asr),
        "المغرب": DateFormat.jm().format(
            prayerTimesData.maghrib.add(Duration(minutes: 4))),
        "العشاء": DateFormat.jm().format(
            prayerTimesData.isha.add(Duration(minutes: 5))),
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
  final now = DateTime.now();
  for (var entry in prayerTimes.entries) {
    DateTime prayerTime = DateFormat.jm().parse(entry.value);
    prayerTime = DateTime(now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

    if (now.difference(prayerTime).inSeconds.abs() <= 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AthanPopup(
            prayerName: entry.key,
            prayerTime: entry.value,
            athanSoundPath: athanSound ?? 'audios/athan1.mp3',
          ),
        ),
      );
      break; // Prevent triggering multiple times
    }
  }
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
                        _calculatePrayerTimes(date: selectedDate);
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
                        _calculatePrayerTimes(date: selectedDate);
                      });
                    },
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
                    "متبقي: ${timeLeft.inHours} س ${timeLeft.inMinutes.remainder(60)} د ${timeLeft.inSeconds.remainder(60)} ث",
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