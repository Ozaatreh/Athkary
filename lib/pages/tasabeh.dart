import 'dart:async';
import 'dart:math';
import 'package:athkary/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Tasabeh extends StatefulWidget {
  @override
  _TasabehState createState() => _TasabehState();
}

class _TasabehState extends State<Tasabeh> {

  // /// ------------------- VOICE SYSTEM -------------------
  // late stt.SpeechToText _speech;
  // bool isListening = false;
  // Timer? silenceTimer;
  // DateTime? lastSpeechTime;

  /// ------------------- NOTIFICATIONS -------------------
  bool every30Min = false;
  bool every1Hour = false;
  bool every2Hours = false;
  bool soundEnabled = true;
  bool notificationsEnabled = true;

  List<TimeOfDay> customNotifications = [];
  List<bool> isNotificationEnabled = [];
  List<int> customNotificationThikrIndexes = [];
  int _notificationId = 100;

  /// ------------------- DATA -------------------
final List<String> theker1 = [
  'سُبْحَانَ اللَّهِ',
  'لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ',
  'اللَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد',
  'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
  'أستغفر الله',
  'سُبْحَانَ اللَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا اللَّهُ، وَاللَّهُ أَكْبَرُ',
  'لَا إِلَهَ إِلَّا اللَّهُ',
  'الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ',
  'اللَّهُ أَكْبَرُ',
  'اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً',
  'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
  'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ',
  'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
  'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ'
];

final List<String> thekinfo1 = [
  'يكتب له ألف حسنة أو يحط عنه ألف خطيئة',
  'كنز من كنوز الجنة',
  'من صلى على حين يصبح وحين يمسى أدركته شفاعتى يوم القيامة',
  'حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ',
  'غفر الله له وإن كان فر من الزحف',
  'هن أحب الكلام إلى الله...',
  'أفضل الذكر لا إله إلا الله',
  'رأيت اثني عشر ملكاً يبتدرونها...',
  'كتبت له عشرون حسنة...',
  'فتحت لها أبواب السماء',
  'يرفع له عشر درجات...',
  'كلمتان خفيفتان على اللسان ثقيلتان في الميزان حبيبتان إلى الرحمن',
  'قالها إبراهيم عليه السلام حين ألقي في النار فجعلها الله عليه برداً وسلاماً',
  'كان النبي يستغفر ويتوب في اليوم أكثر من سبعين مرة'
];

final List<int> tasbeehTargetCounts = const [
  100,
  100,
  10,
  100,
  100,
  100,
  100,
  10,
  100,
  10,
  10,
  100,
  50,
  100,
];


  late List<int> _remainingTasbeehCounts;

  @override
  void initState() {
    super.initState();
    // _speech = stt.SpeechToText();
    _remainingTasbeehCounts = List<int>.from(tasbeehTargetCounts);
    loadCustomNotifications();
    loadSoundPreference();
  }

  @override
  void dispose() {
    // silenceTimer?.cancel();
    super.dispose();
  }

  /// ================= STORAGE =================

  Future<void> loadSoundPreference() async {
    final prefs = await SharedPreferences.getInstance();
    soundEnabled = prefs.getBool('soundEnabled') ?? true;
    setState(() {});
  }

  Future<void> saveSoundPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', value);
  }

  Future<void> saveRecurringNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('every30Min', every30Min);
    await prefs.setBool('every1Hour', every1Hour);
    await prefs.setBool('every2Hours', every2Hours);
  }

  Future<void> saveCustomNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'customNotifications',
        customNotifications
            .map((t) => "${t.hour}:${t.minute}")
            .toList());

    await prefs.setStringList(
        'isNotificationEnabled',
        isNotificationEnabled.map((e) => e.toString()).toList());

    await prefs.setStringList(
      'customNotificationThikrIndexes',
      customNotificationThikrIndexes.map((e) => e.toString()).toList(),
    );
  }

  Future<void> loadCustomNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    every30Min = prefs.getBool('every30Min') ?? false;
    every1Hour = prefs.getBool('every1Hour') ?? false;
    every2Hours = prefs.getBool('every2Hours') ?? false;

    List<String>? times =
        prefs.getStringList('customNotifications');
    List<String>? enabled =
        prefs.getStringList('isNotificationEnabled');
    List<String>? thikrIndexes =
        prefs.getStringList('customNotificationThikrIndexes');

    if (times != null && enabled != null) {
      customNotifications = times.map((t) {
        final parts = t.split(':');
        return TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]));
      }).toList();

      isNotificationEnabled =
          enabled.map((e) => e == 'true').toList();

      customNotificationThikrIndexes =
          thikrIndexes?.map(int.parse).toList() ??
              List<int>.filled(customNotifications.length, 0);

      if (customNotificationThikrIndexes.length < customNotifications.length) {
        customNotificationThikrIndexes.addAll(
          List<int>.filled(
            customNotifications.length - customNotificationThikrIndexes.length,
            0,
          ),
        );
      }
    }

    setState(() {});
  }

  /// ================= NOTIFICATION LOGIC =================

  void _toggleRecurringNotification(
      String tag, bool enable, int interval) {
    if (enable) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: tag.hashCode,
          channelKey:
              soundEnabled ? 'tasabeh_with_sound' : 'tasabeh_silent',
          title: theker1[Random().nextInt(theker1.length)],
          body: thekinfo1[Random().nextInt(thekinfo1.length)],
        ),
        schedule: NotificationInterval(
          interval: Duration(minutes: interval),
          repeats: true,
          timeZone: 'Asia/Amman',
        ),
      );
    } else {
      AwesomeNotifications().cancel(tag.hashCode);
    }
  }

  void scheduleCustomNotification(TimeOfDay time, int id, int thikrIndex) {
    final i = thikrIndex.clamp(0, theker1.length - 1);
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey:
            soundEnabled ? 'tasabeh_with_sound' : 'tasabeh_silent',
        title: theker1[i],
        body: thekinfo1[i],
      ),
      schedule: NotificationCalendar(
        hour: time.hour,
        minute: time.minute,
        repeats: true,
        timeZone: 'Asia/Amman',
      ),
    );
  }

  void cancelNotification(int id) {
    AwesomeNotifications().cancel(id);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  /// ================= UI =================
 void _decrementTasbeeh(int index) {
  if (_remainingTasbeehCounts[index] > 0) {
    setState(() {
      _remainingTasbeehCounts[index]--;
    });

    if (soundEnabled) {
      HapticFeedback.lightImpact();
    }

    if (_remainingTasbeehCounts[index] == 0) {
      _showCompletionSnackBar();
    }
  }
}
void _resetAllTasbeehCounts() {
  setState(() {
    _remainingTasbeehCounts =
        List<int>.from(tasbeehTargetCounts);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("تمت إعادة تعيين جميع الأذكار"),
      duration: Duration(seconds: 2),
    ),
  );
}
void _showCompletionSnackBar() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("ما شاء الله 🌿 تم إكمال الذكر"),
      backgroundColor: Color(0xFF0E5A2F),
      duration: Duration(seconds: 2),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
  centerTitle: true,
  title: Text(
    "تسابيح",
    style: GoogleFonts.tajawal(
      fontSize: width * 0.06,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    ),
  ),
  backgroundColor: theme.colorScheme.surface,
  elevation: 0,
  leading: IconButton(
    icon: Icon(
      Icons.arrow_back_ios_new_rounded,
      color: theme.colorScheme.primary,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    },
  ),

  /// 🔔 ADD THIS PART
  actions: [
    IconButton(
      icon: Icon(
  (every30Min || every1Hour || every2Hours ||
   isNotificationEnabled.contains(true))
      ? Icons.notifications_active
      : Icons.notifications_none,
  color: (every30Min || every1Hour || every2Hours ||
          isNotificationEnabled.contains(true))
      ? Colors.green
      : theme.colorScheme.primary,
),
      onPressed: _showNotificationSettings,
    ),
  ],
),

      /// -------- BODY --------
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: theker1.length,
        itemBuilder: (context, index) {
          final target = tasbeehTargetCounts[index];
          final remaining = _remainingTasbeehCounts[index];

          return GestureDetector(
            onTap: () => _decrementTasbeeh(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isDark
                    ? const LinearGradient(
                        colors: [Color(0xFF2E2E2E), Color(0xFF1C1C1C)],
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFEAF2F8), Color(0xFFDFECF2)],
                      ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Responsive header
                  Row(
                    children: [
                      Icon(Icons.self_improvement_rounded,
                          color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.primary.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Text(
                              remaining == 0
                                  ? 'تم ✓'
                                  : 'المتبقي: $remaining / $target',
                              style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.bold,
                                color:
                                    theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Responsive thikr text
                  Text(
                    theker1[index],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: width * 0.05,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    thekinfo1[index],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: width * 0.038,
                      color: isDark ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      /// -------- RESET BUTTON --------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: _resetAllTasbeehCounts,
          icon: const Icon(Icons.restart_alt),
          label: const Text('إعادة تعيين'),
        ),
      ),
);
      /// -------- VOICE BUTTON --------
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: isListening ? Colors.red : theme.colorScheme.primary,
    //     onPressed: isListening ? stopListening : startListening,
    //     child: Icon(isListening ? Icons.stop : Icons.mic),
    //   ),
    // );
  }

  /// ================= BOTTOM SHEET =================

 void _showNotificationSettings() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, -4),
                )
              ],
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Drag Indicator
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  /// Title
                  Row(
                    children: const [
                      Icon(Icons.notifications_active_rounded,
                          color: Color(0xFF0E5A2F)),
                      SizedBox(width: 10),
                      Text(
                        "إعدادات التنبيهات",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E5A2F),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// 🔊 Sound Section
                  _modernSwitchTile(
                    context: context,
                    title: "تشغيل صوت الإشعارات",
                    subtitle: "تشغيل صوت عند كل تنبيه",
                    icon: Icons.volume_up_rounded,
                    value: soundEnabled,
                    onChanged: (v) {
                      setModalState(() => soundEnabled = v);
                      saveSoundPreference(v);
                    },
                  ),

                  const SizedBox(height: 30),

                  /// ⏱ Recurring Section Title
                  const Text(
                    "تنبيهات متكررة",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E5A2F),
                    ),
                  ),

                  const SizedBox(height: 15),

                  _modernSwitchTile(
                    context: context,
                    title: "كل نصف ساعة",
                    icon: Icons.timer_rounded,
                    value: every30Min,
                    onChanged: (v) {
                      setModalState(() => every30Min = v);
                      _toggleRecurringNotification("30min", v, 30);
                      saveRecurringNotifications();
                    },
                  ),

                  _modernSwitchTile(
                    context: context,
                    title: "كل ساعة",
                    icon: Icons.schedule_rounded,
                    value: every1Hour,
                    onChanged: (v) {
                      setModalState(() => every1Hour = v);
                      _toggleRecurringNotification("1hour", v, 60);
                      saveRecurringNotifications();
                    },
                  ),

                  _modernSwitchTile(
                    context: context,
                    title: "كل ساعتين",
                    icon: Icons.more_time_rounded,
                    value: every2Hours,
                    onChanged: (v) {
                      setModalState(() => every2Hours = v);
                      _toggleRecurringNotification("2hours", v, 120);
                      saveRecurringNotifications();
                    },
                  ),

                  const SizedBox(height: 30),

                  /// 🕒 Custom Section
                  const Text(
                    "تنبيهات مخصصة",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E5A2F),
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...List.generate(customNotifications.length, (i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E5A2F).withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.alarm,
                            color: Color(0xFF0E5A2F)),
                        title: Text(
                          _formatTime(customNotifications[i]),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          customNotificationThikrIndexes.length > i
                              ? theker1[customNotificationThikrIndexes[i]]
                              : theker1[0],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Switch(
                          activeColor: const Color(0xFF0E5A2F),
                          value: isNotificationEnabled[i],
                          onChanged: (v) {
                            setModalState(() {
                              isNotificationEnabled[i] = v;
                            });

                            if (v) {
                              scheduleCustomNotification(
                                  customNotifications[i],
                                  _notificationId + i,
                                  customNotificationThikrIndexes[i]);
                            } else {
                              cancelNotification(
                                  _notificationId + i);
                            }

                            saveCustomNotifications();
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  /// Add Custom Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E5A2F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () async {
                        TimeOfDay? picked =
                            await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (picked == null) return;

                        final selectedIndex = await _pickTasbeehForNotification();

                        if (selectedIndex == null) return;

                        setModalState(() {
                          customNotifications.add(picked);
                          isNotificationEnabled.add(true);
                          customNotificationThikrIndexes.add(selectedIndex);
                        });

                        scheduleCustomNotification(
                          picked,
                          _notificationId + customNotifications.length - 1,
                          selectedIndex,
                        );

                        saveCustomNotifications();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("إضافة وقت إشعار مخصص"),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Done Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "تم",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
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

Widget _modernSwitchTile({
  required BuildContext context,
  required String title,
  String? subtitle,
  required IconData icon,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF0E5A2F).withOpacity(0.06),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF0E5A2F)),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold)),
              if (subtitle != null)
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
          activeColor: const Color(0xFF0E5A2F),
          value: value,
          onChanged: onChanged,
        ),
      ],
    ),
  );
}

Future<int?> _pickTasbeehForNotification() async {
  int selected = 0;
  return showDialog<int>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('اختر التسبيح للتنبيه'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SizedBox(
              width: double.maxFinite,
              child: DropdownButton<int>(
                value: selected,
                isExpanded: true,
                items: List.generate(
                  theker1.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      theker1[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() => selected = value);
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, selected),
            child: const Text('حفظ'),
          ),
        ],
      );
    },
  );
}

}
