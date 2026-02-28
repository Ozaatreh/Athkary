import 'package:athkary/Component/splash_screen.dart';
import 'package:athkary/Component/athan_page.dart';
import 'package:athkary/Component/notification.dart';
import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:athkary/theme/dark_mode.dart';
import 'package:athkary/theme/light_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

@pragma('vm:entry-point')
Future<void> onNotificationActionReceived(
  ReceivedAction receivedAction,
) async {
  final payload = receivedAction.payload ?? {};
  final prayerName = payload['prayerName'];
  final prayerTime = payload['prayerTime'];
  final outsidePopupEnabled =
      (payload['outsidePopupEnabled'] ?? 'true').toLowerCase() == 'true';

  if (prayerName == null || prayerTime == null || !outsidePopupEnabled) return;

  final context = navigatorKey.currentContext;
  if (context == null) return;

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => AthanPopup(
        prayerName: prayerName,
        prayerTime: prayerTime,
        athanSoundPath: 'audios/athan_islam_sobhi.mp3',
      ),
    ),
  );
}

Future<void> main() async {
  // AwesomeNotifications().

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  CustomNotificationState().initState();

  await Firebase.initializeApp();
  // Initialize Awesome Notificationsb
  AwesomeNotifications().initialize(
    'resource://drawable/athk_v3', // Set null to use the default icon for notifications
    [
      NotificationChannel(
        channelKey: 'athkar_sabah',
        channelName: 'athkar',
        channelDescription: 'Tasabeeh reminders without sound',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: false,
      ),
      NotificationChannel(
        channelKey: 'athkar_masaa',
        channelName: 'athkar',
        channelDescription: 'Tasabeeh reminders without sound',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: false,
      ),
      NotificationChannel(
        channelKey: 'tasabeh_with_sound',
        channelName: 'Tasabeeh (Sound)',
        channelDescription: 'Tasabeeh reminders with sound',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: true,
        soundSource: 'resource://raw/tasbeeh_sound',
      ),
      NotificationChannel(
        channelKey: 'tasabeh_silent',
        channelName: 'Tasabeeh (Silent)',
        channelDescription: 'Tasabeeh reminders without sound',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: false,
      ),
      NotificationChannel(
        channelKey: 'prayer_with_sound',
        channelName: 'وقت الصلاة',
        channelDescription: 'حان الان موعد  ',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: true,
        soundSource: 'resource://raw/athan_islam_sobhi',
      ),
      NotificationChannel(
        // Add this for prayer notifications
        channelKey: 'prayer_silent',
        channelName: 'وقت الصلاة',
        channelDescription: 'حان الان موعد  ',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: false,
      ),
    ],
  );

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: onNotificationActionReceived,
  );

  checkForUpdate();

  // Load shared preferences BEFORE runApp
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('darkMode') ?? false;
  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, themeMode, _) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    ),
  );
}

Future<void> checkForUpdate() async {
  String currentVersion = await getAppVersion();
  String latestVersion = await getLatestVersion();

  if (latestVersion.compareTo(currentVersion) > 0) {
    // If there is an update available, show a dialog or prompt to update
    showUpdateDialog();
  }
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<String> getLatestVersion() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('app_version')
      .doc('latest')
      .get();
  return doc['latest_version'];
}

void showUpdateDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text("Update Available"),
      content: Text("A new version of the app is available. Please update."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Later"),
        ),
        TextButton(
          onPressed: () async {
            const url = ""; // Replace with your update URL
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Text("Update"),
        ),
      ],
    ),
  );
}
