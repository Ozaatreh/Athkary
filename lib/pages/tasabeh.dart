import 'dart:async';
import 'dart:math';
import 'package:athkary/pages/home_page.dart';
import 'package:flutter/material.dart';
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

  /// ------------------- VOICE SYSTEM -------------------
  late stt.SpeechToText _speech;
  bool isListening = false;
  Timer? silenceTimer;
  DateTime? lastSpeechTime;

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



  final List<int> tasbeehTargetCounts = const [
    100, // سبحان الله
    100, // لا حول ولا قوة إلا بالله
    10,  // الصلاة على النبي
    100, // سبحان الله وبحمده
    100, // أستغفر الله
    100, // التسبيح والتحميد والتهليل والتكبير
    100, // لا إله إلا الله
    10,  // الحمد لله حمداً كثيراً
    100, // الله أكبر
    10,  // الله أكبر كبيراً...
    10,  // الصلاة الإبراهيمية
  ];
  late List<int> _remainingTasbeehCounts;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _remainingTasbeehCounts = List<int>.from(tasbeehTargetCounts);
  }

  @override
  void dispose() {
    silenceTimer?.cancel();
    super.dispose();
  }

  /// ------------------- VOICE FUNCTIONS -------------------

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (!available) return;

    setState(() => isListening = true);
    lastSpeechTime = DateTime.now();

    _speech.listen(
      listenFor: const Duration(minutes: 10), // Increased listening time
      pauseFor: const Duration(minutes: 5),    // Auto pause if silence
      onResult: (result) {
        lastSpeechTime = DateTime.now();
      },
    );

    silenceTimer?.cancel();
    silenceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (lastSpeechTime != null &&
          DateTime.now().difference(lastSpeechTime!).inMinutes >= 5) {
        stopListening();
      }
    });
  }

  void stopListening() {
    silenceTimer?.cancel();
    _speech.stop();
    setState(() => isListening = false);
  }

  /// ------------------- TASBEEH LOGIC -------------------

  void _decrementTasbeeh(int index) {
    if (_remainingTasbeehCounts[index] > 0) {
      setState(() {
        _remainingTasbeehCounts[index]--;
      });
    }
  }

  void _resetAllTasbeehCounts() {
    setState(() {
      _remainingTasbeehCounts = List<int>.from(tasbeehTargetCounts);
    });
  }

  /// ------------------- UI -------------------

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
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: theme.colorScheme.primary),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          },
        ),
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

      /// -------- VOICE BUTTON --------
      floatingActionButton: FloatingActionButton(
        backgroundColor: isListening ? Colors.red : theme.colorScheme.primary,
        onPressed: isListening ? stopListening : startListening,
        child: Icon(isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}