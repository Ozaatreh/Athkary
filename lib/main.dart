import 'package:athkary/Component/splash_screen.dart';
import 'package:athkary/Component/notification.dart';
import 'package:athkary/theme/dark_mode.dart';
import 'package:athkary/theme/light_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  // AwesomeNotifications().

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  CustomNotificationState().initState();

  await Firebase.initializeApp();
   // Initialize Awesome Notifications
  AwesomeNotifications().initialize(
    'resource://drawable/atkary_ramadanv2', // Set null to use the default icon for notifications
    [
      NotificationChannel(
        channelKey: 'tasabeh_channel',
        channelName: 'Tasabeeh',
        channelDescription: 'Hourly notifications for Tasabeh reminders',
        // defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        ),

      NotificationChannel( // Add this for prayer notifications
      channelKey: 'prayer_channel',
      channelName:  'وقت الصلاة',
      channelDescription: 'حان الان موعد  ',
      ledColor: Colors.white,
      importance: NotificationImportance.High,
    ),
    ],
    

    
    
  );
  checkForUpdate();

  runApp(
   MaterialApp(
      navigatorKey: navigatorKey,  // Use the global navigator key
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
      //  HomePage() 
      )
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

