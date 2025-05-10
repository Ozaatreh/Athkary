import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:athkary/pages/home_page.dart';
import 'package:athkary/pages/masbahah_elc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Tasabeh extends StatefulWidget {
  const Tasabeh({super.key});

  @override
  State<Tasabeh> createState() => _TasabehState();
}

class _TasabehState extends State<Tasabeh> {
 
 final List<String> theker1 = [
    'سُبْحَانَ اللَّهِ', //1
    'لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ', //2
    'الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد', //3
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', //4
    'أستغفر الله', //5
    'سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ', //6
    'لَا إِلَهَ إِلَّا اللَّهُ ', //7
    'الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ', //8
    'الْلَّهُ أَكْبَرُ' //9
    'اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً' //10
    'للَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ'
  ];

  final List<String> thekinfo1 = [
    'ي كتب له ألف حسنة أو يحط عنه ألف خطيئة', //1
    'كنز من كنوز الجنة ', //2
    'من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.', //3
    'حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ', //4
    'غفر اللهُ له، وإن كان فرَّ من الزحف', //5
    'هن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات.',
    'أفضل الذكر لا إله إلاّ الله.', //7
    'قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ لَقَدْ رَأَيْتُ اثْنَيْ عَشَرَ مَلَكًا يَبْتَدِرُونَهَا، أَيُّهُمْ يَرْفَعُهَا"', //8
    'من قال الله أكبر كتبت له عشرون حسنة وحطت عنه عشرون سيئة. الله أكبر من كل شيء', //9
    'قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ "عَجِبْتُ لَهَا ، فُتِحَتْ لَهَا أَبْوَابُ السَّمَاءِ"',
    'في كل مره تحط عنه عشر خطايا ويرفع له عشر درجات ويصلي الله عليه عشرا وتعرض على الرسول صلى الله عليه وسلم'
  ];

  static final String icon1 = 'assets/icons/anniversary.png';

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
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

  void scheduleNotification() {
    DateTime now = DateTime.now();
    for (int i = 0; i < theker1.length; i++) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i,
          channelKey: 'tasabeh_channel',
          title: theker1[i],
          body: thekinfo1[i],
        ),
        schedule: NotificationCalendar(
          hour: (now.hour + i) % 24,
          minute: 0,
          second: 0,
          repeats: true,
          allowWhileIdle: true,
          timeZone: "Asia/Amman",
        ),
      );
    }
  }

  void cancelNotifications() {
    AwesomeNotifications().cancelAll();
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(135, 40),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.inversePrimary,
                    ),
                    onPressed: scheduleNotification,
                    child: Text(
                      'تفعيل التنبيهات',
                      style: GoogleFonts.tajawal(fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(135, 40),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.inversePrimary,
                    ),
                    onPressed: cancelNotifications,
                    child: Text(
                      'إيقاف التنبيهات',
                      style: GoogleFonts.tajawal(fontSize: 12),
                    ),
                  ),
                ],
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
                    style: GoogleFonts.amiri(
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
              textAlign: TextAlign.justify,
              style: GoogleFonts.amiri(
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
}
  