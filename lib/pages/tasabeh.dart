import 'package:athkary/pages/home_page.dart';
import 'package:athkary/pages/masbahah_elc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tasabeh extends StatefulWidget {
  @override
  _TasabehState createState() => _TasabehState();
}

class _TasabehState extends State<Tasabeh> {
  bool every30Min = false;
  bool every1Hour = false;
  bool every2Hours = false;
  bool notificationsEnabled = true;
  List<TimeOfDay> customNotifications = [];
  List<bool> isNotificationEnabled = [];

     final List<String> theker1 = [
    'سُبْحَانَ اللَّهِ', //1
    'لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ', //2
    'الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد', //3
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', //4
    'أستغفر الله', //5
    'سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ', //6
    'لَا إِلَهَ إِلَّا اللَّهُ ', //7
    'الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ', //8
    'الْلَّهُ أَكْبَرُ', //9
    'اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً' , //10
    'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ'
  ];

  final List<String> thekinfo1 = [
    'يكتب له ألف حسنة أو يحط عنه ألف خطيئة', //1
    'كنز من كنوز الجنة ', //2
    'من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة', //3
    'حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ', //4
    'غفر اللهُ له، وإن كان فرَّ من الزحف', //5
    'هن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات',
    'أفضل الذكر لا إله إلاّ الله', //7
    'قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ لَقَدْ رَأَيْتُ اثْنَيْ عَشَرَ مَلَكًا يَبْتَدِرُونَهَا، أَيُّهُمْ يَرْفَعُهَا"', //8
    'من قال الله أكبر كتبت له عشرون حسنة وحطت عنه عشرون سيئة. الله أكبر من كل شيء', //9
    'قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ "عَجِبْتُ لَهَا ، فُتِحَتْ لَهَا أَبْوَابُ السَّمَاءِ"',
    'في كل مره تحط عنه عشر خطايا ويرفع له عشر درجات ويصلي الله عليه عشرا وتعرض على الرسول صلى الله عليه وسلم'
  ];

  int _notificationId = 100;
   static final String icon1 = 'assets/icons/anniversary.png';

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
    loadCustomNotifications();
    loadSoundPreference();
  }
  
  bool soundEnabled = true;

Future<void> saveSoundPreference(bool enabled) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('soundEnabled', enabled);
}

Future<void> loadSoundPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  soundEnabled = prefs.getBool('soundEnabled') ?? true;
  setState(() {});
}
int _generateNotificationId() {
  return DateTime.now().millisecondsSinceEpoch % 100000;
}
  Future<void> saveRecurringNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('every30Min', every30Min);
  await prefs.setBool('every1Hour', every1Hour);
  await prefs.setBool('every2Hours', every2Hours);
}


  Future<void> saveCustomNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> times = customNotifications.map((t) => "${t.hour}:${t.minute}").toList();
  List<String> enabledList = isNotificationEnabled.map((e) => e.toString()).toList();

  await prefs.setStringList('customNotifications', times);
  await prefs.setStringList('isNotificationEnabled', enabledList);
}


Future<void> loadCustomNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Load custom notification times
  List<String>? times = prefs.getStringList('customNotifications');
  List<String>? enabledList = prefs.getStringList('isNotificationEnabled');

  if (times != null && enabledList != null && times.length == enabledList.length) {
    customNotifications = times.map((t) {
      final parts = t.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }).toList();

    isNotificationEnabled = enabledList.map((e) => e == 'true').toList();
  } else {
    // fallback in case something goes wrong
    customNotifications = [];
    isNotificationEnabled = [];
  }

  // ✅ Load recurring switches
  every30Min = prefs.getBool('every30Min') ?? false;
  every1Hour = prefs.getBool('every1Hour') ?? false;
  every2Hours = prefs.getBool('every2Hours') ?? false;

  // ✅ update UI
  if (mounted) {
    setState(() {});
  }
}




  void _animateItems() async {
    for (int i = 0; i < theker1.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
      // await _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    }
  }
   @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "تسابيح",
          style: GoogleFonts.tajawal(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color:theme.colorScheme.primary,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => HomePage())),
          ),
        ),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.surface.withOpacity(0.8),
                    theme.colorScheme.surface,
                    theme.colorScheme.surface,
                  ],
                )
              : null,
          color: isDarkMode ? theme.colorScheme.surface : theme.colorScheme.surface,
        ),
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                initialItemCount: 0,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutQuart,
                      )),
                      child: _buildThikrCard(context, index),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildThikrCard(BuildContext context, int index) {
  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => MasbahaElc())),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color.fromARGB(255, 90, 90, 90) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: theme.colorScheme.primary,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image(image: AssetImage(icon1)
                  ,height:50,width:50  ,),
                ),
                Expanded(
                  child: Text(
                    theker1[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(
                      fontSize: 20,
                      height: 1.6,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: theme.colorScheme.primary.withOpacity(0.5),
              thickness: 1,
            ),
            const SizedBox(height: 8),
            Text(
              thekinfo1[index],
              textAlign: TextAlign.end,
              style: GoogleFonts.tajawal(
                fontSize: 16,
                height: 1.5,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  void _showNotificationSettings() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
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
                  
                  _buildToggle( 
                     title: "تشغيل صوت الإشعارات",
                     value: soundEnabled, onChanged: (value) {
                     setModalState(() => soundEnabled = value);
                     saveSoundPreference(value);
                   },),
               

                  // Recurring notification toggles
                  _buildToggle(
                    title: "كل نصف ساعة",
                    value: every30Min,
                    onChanged: (value) {
                      setModalState(() => every30Min = value);
                      _toggleRecurringNotification("30min", value, 30);
                      saveRecurringNotifications();
                    },
                  ),
                  _buildToggle(
                    title: "كل ساعة",
                    value: every1Hour,
                    onChanged: (value) {
                      setModalState(() => every1Hour = value);
                      _toggleRecurringNotification("1hour", value, 60);
                      saveRecurringNotifications();
                    },
                  ),
                  _buildToggle(
                    title: "كل ساعتين",
                    value: every2Hours,
                    onChanged: (value) {
                      setModalState(() => every2Hours = value);
                      _toggleRecurringNotification("2hours", value, 120);
                      saveRecurringNotifications();
                    },
                  ),

                  SizedBox(height: 20),

                  // Custom notification toggles
                  ...List.generate(customNotifications.length, (i) {
                    return Container(
                     margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ${_formatTime(customNotifications[i])}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          
                          Row(
                            children: [
                              Switch(
                                activeColor: Colors.green,
                                inactiveTrackColor: Theme.of(context).colorScheme.primary,
                                thumbColor: WidgetStateProperty.all(Colors.white),
                                value: isNotificationEnabled[i],
                                onChanged: (value) {
                                  setModalState(() {
                                    isNotificationEnabled[i] = value;
                                  });
                                  if (value) {
                                    scheduleCustomNotification(
                                      customNotifications[i],
                                      _notificationId + i,
                                    );
                                  } else {
                                    cancelNotification(_notificationId + i);
                                  }
                                  saveCustomNotifications(); // Save change
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cancelNotification(_notificationId + i);
                                  setModalState(() {
                                    customNotifications.removeAt(i);
                                    isNotificationEnabled.removeAt(i);
                                  });
                                  saveCustomNotifications(); // Save after delete
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 20),

                  // Add new custom time
                  OutlinedButton.icon(
                    onPressed: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null &&
                          !customNotifications.contains(picked)) {
                        setModalState(() {
                          customNotifications.add(picked);
                          isNotificationEnabled.add(true);
                        });
                        scheduleCustomNotification(
                          picked,
                          _notificationId + customNotifications.length - 1,
                        );
                        saveCustomNotifications(); // Save after add
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text("إضافة وقت إشعار مخصص"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                SizedBox(height: 25,),
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
            style: GoogleFonts.tajawal(
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


  

  Widget _buildToggle({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
            inactiveTrackColor: Theme.of(context).colorScheme.primary,
            thumbColor: WidgetStateProperty.all(Colors.white),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  void _toggleRecurringNotification(
      String tag, bool enable, int intervalMinutes) {
    if (enable) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: tag.hashCode,
          channelKey: soundEnabled ? 'tasabeh_with_sound' : 'tasabeh_silent',
          title: getRandomThekrTitle(),
          body: getRandomThekrBody(),
          notificationLayout: NotificationLayout.Default,
          
        ),
        schedule: NotificationInterval(
          interval: Duration(minutes:  intervalMinutes * 60) ,
          timeZone: 'Asia/Amman',
          repeats: true,
        ),
      );
    } else {
      AwesomeNotifications().cancel(tag.hashCode);
    }
  }

  void scheduleCustomNotification(TimeOfDay time, int id) {
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final i = Random().nextInt(theker1.length);
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: soundEnabled ? 'tasabeh_with_sound' : 'tasabeh_silent',
        title: theker1[i],
        body: thekinfo1[i],
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: time.hour,
        minute: time.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        timeZone: 'Asia/Amman',
      ),
    );
  }

  void cancelNotification(int id) {
    AwesomeNotifications().cancel(id);
  }

  String getRandomThekrTitle() {
    final i = Random().nextInt(theker1.length);
    return theker1[i];
  }

  String getRandomThekrBody() {
    final i = Random().nextInt(thekinfo1.length);
    return thekinfo1[i];
  }
}
