import 'package:athkary/Component/contact_us_page.dart';
import 'package:athkary/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _language = 'Arabic';
  bool _darkMode = false;
  double _fontSize = 16;
  bool _enableMorningAthkar = true;
  bool _enableEveningAthkar = true;
  bool _enableSleepAthkar = false;
  // bool _showRepetitionCounter = true;
  // bool _showExplanation = false;
  TimeOfDay _morningTime =  TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _eveningTime =  TimeOfDay(hour: 17, minute: 0);
  bool _notificationSound = true;
  // String _athan = 'Athan 1';
  // double _volume = 0.5;
  final sleepStart = TimeOfDay(hour: 22, minute: 0);
  final sleepEnd = TimeOfDay(hour: 6, minute: 0);

  
  @override
void initState() {
  super.initState();
  _loadSettings();
}

// Future<String> getCurrentNotificationChannel() async {
//   final now = DateTime.now();
//   final prefs = await SharedPreferences.getInstance();
//   final enableSleep = prefs.getBool('enableSleepAthkar') ?? false;

//   if (!enableSleep) return 'tasabeh_with_sound';

//   // Between 10 PM and 7 AM
//   if (now.hour >= 22 || now.hour < 7) {
//     return 'tasabeh_silent';
//   }

//   return 'tasabeh_with_sound';
// }

void _loadSettings() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _language = prefs.getString('language') ?? 'Arabic';
    _darkMode = prefs.getBool('darkMode') ?? false;
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    _enableMorningAthkar = prefs.getBool('enableMorningAthkar') ?? true;
    _enableEveningAthkar = prefs.getBool('enableEveningAthkar') ?? true;
    _enableSleepAthkar = prefs.getBool('enableSleepAthkar') ?? false;
    _notificationSound = prefs.getBool('notificationSound') ?? true;

    final morningHour = prefs.getInt('morningHour') ?? 7;
    final morningMinute = prefs.getInt('morningMinute') ?? 0;
    _morningTime = TimeOfDay(hour: morningHour, minute: morningMinute);

    final eveningHour = prefs.getInt('eveningHour') ?? 17;
    final eveningMinute = prefs.getInt('eveningMinute') ?? 0;
    _eveningTime = TimeOfDay(hour: eveningHour, minute: eveningMinute);
  });
}
 
 void scheduleSilentModeSwitches() {
  if (_enableSleepAthkar) {
    // At night (10 PM): switch to silent channels
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 300,
        channelKey: 'tasabeh_silent', // Your silent channel
        title: '🌙 وضع السكون',
        body: 'تم تفعيل وضع السكون، سيتم كتم الإشعارات',
        notificationLayout: NotificationLayout.Default,
        payload: {'silent_mode': 'on'},
      ),
      schedule: NotificationCalendar(hour: 22, minute: 0, second: 0, repeats: true),
    );

    // In the morning (7 AM): switch back to normal (with sound)
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 301,
        channelKey: 'tasabeh_with_sound', // your sound channel
        title: '☀️ تم إلغاء وضع السكون',
        body: 'تمت إعادة تشغيل الإشعارات مع الصوت',
        notificationLayout: NotificationLayout.Default,
        payload: {'silent_mode': 'off'},
      ),
      schedule: NotificationCalendar(hour: 7, minute: 0, second: 0, repeats: true),
    );
  } else {
    AwesomeNotifications().cancel(300);
    AwesomeNotifications().cancel(301);
  }
}


 void _scheduleMorningNotification() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 100,
      channelKey: 'athkar_sabah',
      title: '🌅 أذكار الصباح',
      body: 'لا تنسَ أذكار الصباح ✨',
      payload: {'screen': 'sabah'},
    ),
    schedule: NotificationCalendar(
      hour: _morningTime.hour,
      minute: _morningTime.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

void _scheduleEveningNotification() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 200,
      channelKey: 'athkar_masaa',
      title: '🌇 أذكار المساء',
      body: 'لا تنسَ أذكار المساء 🌙',
      payload: {'screen': 'masaa'},
    ),
    schedule: NotificationCalendar(
      hour: _eveningTime.hour,
      minute: _eveningTime.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}


void _cancelMorningNotification() {
  AwesomeNotifications().cancel(100);
}


void _cancelEveningNotification() {
  AwesomeNotifications().cancel(200);
}


void _shareAppLink() {
  const String appLink = 'https://drive.google.com/uc?export=download&id=1uIEqRrm5lVl41yXeJ_4OfAWmegfTvTAt';
  final String message = '📲 حمل تطبيق الأذكار من هنا:\n$appLink';

  Share.share(message, subject: 'تحميل تطبيق الأذكار');
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded)  ,
        color: Theme.of(context).colorScheme.primary, onPressed: () {
          Navigator.pop(context); 
           },),
        title:  Text('الاعدادات' ,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary),),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('General Settings'),
          _buildCard([
            // _buildDropdownTile('Language', ['Arabic', 'English'], _language, (val) {
            //   setState(() => _language = val);
            // }),
            _buildSwitchTile('Dark Mode', _darkMode, (val) {
              setState(() => _darkMode = val);
              SharedPreferences.getInstance().then((prefs) {
                prefs.setBool('darkMode', val);
              });
              themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;

            }),
          //   _buildSliderTile('Font Size', _fontSize, 12, 24, (val) {
          //     setState(() => _fontSize = val);
          //   }),
          ]),

          _buildSectionTitle('Athkar Settings'),
          _buildCard([
            _buildSwitchTile('Enable Morning Athkar', _enableMorningAthkar, (val) {
            setState(() => _enableMorningAthkar = val);
            if (val) {
              _scheduleMorningNotification();
            } else {
              _cancelMorningNotification();
            }
          }),

            _buildSwitchTile('Enable Evening Athkar', _enableEveningAthkar, (val) {
            setState(() => _enableEveningAthkar = val);
            if (val) {
              _scheduleEveningNotification();
            } else {
              _cancelEveningNotification();
            }
          }),
          

            // _buildSwitchTile('Enable Sleep Athkar', _enableSleepAthkar, (val) {
            //   setState(() =>{ });
            // }),

            // _buildSwitchTile('Show Repetition Counter', _showRepetitionCounter, (val) {
            //   setState(() => _showRepetitionCounter = val);
            // }),
            // _buildSwitchTile('Show Explanation of Athkar', _showExplanation, (val) {
            //   setState(() => _showExplanation = val);
            // }),
          ]),

          _buildSectionTitle('Notifications'),
          _buildCard([

            _buildTimeTile(context, 'Morning Reminder', _morningTime, (picked) async {
              setState(() => _morningTime = picked);
              final prefs = await SharedPreferences.getInstance();
              prefs.setInt('morningHour', picked.hour);
              prefs.setInt('morningMinute', picked.minute);
            }),

            _buildTimeTile(context, 'Evening Reminder', _eveningTime, (picked) async {
              setState(() => _eveningTime = picked);
              final prefs = await SharedPreferences.getInstance();
              prefs.setInt('eveningHour', picked.hour);
              prefs.setInt('eveningMinute', picked.minute);
            }),

            // _buildSwitchTile('Enable Notification Sound', _notificationSound, (val) {
            //   setState(() => _notificationSound = val);
            // }),
          ]),

          // _buildSectionTitle('Athan Sound'),
          // _buildCard([
            // _buildDropdownTile('Choose Athan', ['Athan 1', 'Athan 2'], _athan, (val) {
            //   setState(() => _athan = val);
            // }),
            // _buildSliderTile('Volume', _volume, 0.0, 1.0, (val) {
            //   setState(() => _volume = val);
          //   // }),
          //   _buildButtonTile('Preview Athan', () {}),
          // ]),

          _buildSectionTitle('About'),
          _buildCard([
            _buildButtonTile('Contact Us', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage(),));
            }),
            // _buildButtonTile('Rate the App', () {}),
            _buildButtonTile('Share the App', _shareAppLink),

          ]),
        ],
      ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       currentIndex: 1,
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  //         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //       ],
  //     ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Theme.of(context).colorScheme.primary.withOpacity(.10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,),),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSliderTile(String title, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdownTile(String title, List<String> options, String selected, ValueChanged<String> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
        DropdownButton<String>(
          value: selected,
          items: options.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val , style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
            );
          }).toList(),
          onChanged: (String? newVal) {
            if (newVal != null) onChanged(newVal);
          },
        ),
      ],
    );
  }

  Widget _buildTimeTile(BuildContext context, String title, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return ListTile(
      title: Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
      trailing: Text(time.format(context) , style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (pickedTime != null) {
          onChanged(pickedTime);
        }
      },
    );
  }

  Widget _buildButtonTile(String title, VoidCallback onPressed) {
    return ListTile(
      title: Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
      trailing:  Icon(Icons.arrow_forward_ios ,color: Theme.of(context).colorScheme.primary,),
      onTap: onPressed,
    );
  }
}