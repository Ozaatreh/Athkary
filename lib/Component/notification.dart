import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget {
   const CustomNotification({super.key});

  @override
  State<CustomNotification> createState() => CustomNotificationState();
}

class CustomNotificationState extends State<CustomNotification> {
 
  void notificationfunc (){
    AwesomeNotifications().initialize(
      // null,
      'resource://drawable/atkary_ramadanv2',
      [
        NotificationChannel(
            channelKey: 'test',
            channelName: 'String tex ',
            channelDescription: 'يارب',
            // icon: 'resource://drawable/athkary_icon',
            ),
        NotificationChannel(
            channelKey: 'test1', channelName: 'ذكر ', channelDescription: 'sb')
      ],
      debug: true);
  }

  int notid = 0;

  void trigerNotification(String titl, disc) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notid,
        channelKey: 'test',
        title: '$titl',
        body: '$disc',
        // icon: 'resource://drawable/athkary_notificon.png',
      ),
      // schedule: NotificationAndroidCrontab.minutely(referenceDateTime: DateTime(1)),
    );
    // AwesomeNotifications().createNotification(content: NotificationContent(id: 5, channelKey: 'test',title: '$titl',body: '$disc' ),);
    notid++;
  }

    @override
  void initState() {
    notificationfunc();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Row(
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            trigerNotification('theker',
                                'يكتب له ألف حسنة أو يحط عنه ألف خطيئة.');
                          },
                          child: Text('b1')),
                      ElevatedButton(
                          onPressed: () {
                            trigerNotification('سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
                                'حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.');
                          },
                          child: Text('b2')),
                      ElevatedButton(
                          onPressed: () {
                            trigerNotification(
                                'الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد',
                                'من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة');
                          },
                          child: Text('b3')),
                    ],
                  );
  }
}