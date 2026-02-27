import 'dart:async';
import 'dart:io';
import 'package:athkary/pages/home_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class MasbahaElc extends StatefulWidget {
  const MasbahaElc({super.key});

  @override
  State<MasbahaElc> createState() => _MasbahaElcState();
}

class _MasbahaElcState extends State<MasbahaElc>
    with SingleTickerProviderStateMixin {
  int counter = 0;
  int tasabehcount = 0;
  int _targetCount = 100;
  String _selectedWerd = 'سبحان الله';

  final player = AudioPlayer();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  late stt.SpeechToText _speech;
  bool _isListening = false;

  final Duration _listeningDuration = const Duration(minutes: 10);
  final Duration _cooldownPeriod = const Duration(milliseconds: 800);

  Timer? _listeningTimer;
  Timer? _countdownTimer;
  Timer? _silenceTimer;

  int _secondsRemaining = 600;
  DateTime? _lastDhikrTime;
  DateTime? _lastSpeechTime;

  final Set<String> _processedTexts = {};

  final List<String> _dhikrPhrases = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'الله اكبر',
    'لا إله إلا الله',
    'لا اله الا الله',
    'أستغفر الله',
    'سبحان الله وبحمده',
    'سبحان الله العظيم',
    'لا حول ولا قوة إلا بالله',
    'الله أكبر كبيراً والحمد لله كثيراً وسبحان الله بكرة وأصيلاً',
    'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير',
    'اللهم صل على محمد',
    'اللهم صل وسلم على نبينا محمد',
    'رب اغفر لي',
    'حسبي الله ونعم الوكيل',
    'توكلت على الله',
    'ما شاء الله',
    'إنا لله وإنا إليه راجعون',
    'اللهم إني أسألك الجنة وأعوذ بك من النار',
    'اللهم أنت ربي لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء بذنبي فاغفر لي فإنه لا يغفر الذنوب إلا أنت',
    'اللهم إني أعوذ بك من الهم والحزن، والعجز والكسل، والجبن والبخل، وضلع الدين وغلبة الرجال',
    'سبحانك اللهم وبحمدك، أشهد أن لا إله إلا أنت، أستغفرك وأتوب إليك',
    'اللهم إني ظلمت نفسي ظلماً كثيراً، ولا يغفر الذنوب إلا أنت، فاغفر لي مغفرة من عندك، وارحمني إنك أنت الغفور الرحيم',
    'لا إله إلا أنت سبحانك إني كنت من الظالمين',
    'رضيت بالله رباً، وبالإسلام ديناً، وبمحمد صلى الله عليه وسلم نبياً',
    'اللهم إني أسألك علماً نافعاً، ورزقاً طيباً، وعملاً متقبلاً',
    'اللهم أنت السلام ومنك السلام تباركت يا ذا الجلال والإكرام',
    'أعوذ بكلمات الله التامات من شر ما خلق',
    'بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم',
    'حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم',
    'اللهم إني أعوذ بك من البرص والجنون والجذام ومن سيء الأسقام',
    'اللهم إني أعوذ بك من العجز والكسل، والجبن والهرم والبخل، وأعوذ بك من عذاب القبر، ومن فتنة المحيا والممات',
    'اللهم آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار',
    'اللهم إني أعوذ بك من زوال نعمتك، وتحول عافيتك، وفجاءة نقمتك، وجميع سخطك',
    'اللهم إني أعوذ بك من جهد البلاء، ودرك الشقاء، وسوء القضاء، وشماتة الأعداء',
    'يا حي يا قيوم برحمتك أستغيث أصلح لي شأني كله ولا تكلني إلى نفسي طرفة عين',
    'اللهم اهدني وسددني',
    'اللهم إني أعوذ بك من قلب لا يخشع، ومن دعاء لا يسمع، ومن نفس لا تشبع، ومن علم لا ينفع',
    'سبحان الله والحمد لله ولا إله إلا الله والله أكبر',
    'لا إله إلا الله الملك الحق المبين',
    'اللهم إني أعوذ بك من الشيطان الرجيم من همزه ونفخه ونفثه',
    'أعوذ بالله من الشيطان الرجيم',
    'بسم الله الرحمن الرحيم',
    'الحمد لله رب العالمين',
    'لا إله إلا الله إقراراً بربوبيته سبحانه',
    'الله أكبر الله أكبر لا إله إلا الله، الله أكبر الله أكبر ولله الحمد',
    'سبحان الله وبحمده عدد خلقه ورضا نفسه وزنة عرشه ومداد كلماته',
    'اللهم انفعني بما علمتني وعلمني ما ينفعني وزدني علماً',
    'اللهم إني أعوذ بك من علم لا ينفع، ومن قلب لا يخشع، ومن نفس لا تشبع، ومن دعاء لا يسمع',
    'اللهم إني أسألك الثبات في الأمر والعزيمة على الرشد',
    'اللهم مصرف القلوب صرف قلوبنا على طاعتك',
    'اللهم إني أسألك خشيتك في الغيب والشهادة، وأسألك كلمة الحق في الرضا والغضب، وأسألك القصد في الغنى والفقر، وأسألك نعيماً لا ينفد، وأسألك قرة عين لا تنقطع، وأسألك الرضا بعد القضاء، وأسألك برد العيش بعد الموت، وأسألك لذة النظر إلى وجهك والشوق إلى لقائك في غير ضراء مضرة ولا فتنة مضلة'
  ];

  @override
  void initState() {
    super.initState();
    _loadCounts();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);

    _speech = stt.SpeechToText();
  }

  /// ================= VOICE =================

  void _startListening() async {
    _processedTexts.clear();
    _secondsRemaining = 600;
    _lastSpeechTime = DateTime.now();
    _startCountdown();
    _startSilenceWatcher();

    bool available = await _speech.initialize();
    if (!available) return;

    setState(() => _isListening = true);

    _listeningTimer?.cancel();
    _listeningTimer = Timer(_listeningDuration, _stopListening);

    await _speech.listen(
      localeId: 'ar-SA',
      listenFor: _listeningDuration,
      pauseFor: const Duration(seconds: 30),
      partialResults: true,
      onResult: (result) {
        _lastSpeechTime = DateTime.now();
        _processDhikr(result.recognizedWords);
      },
    );
  }

  void _startSilenceWatcher() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_lastSpeechTime != null &&
          DateTime.now().difference(_lastSpeechTime!).inMinutes >= 5) {
        _stopListening();
      }
    });
  }

  void _stopListening() {
    _speech.stop();
    _listeningTimer?.cancel();
    _countdownTimer?.cancel();
    _silenceTimer?.cancel();

    setState(() {
      _isListening = false;
      _secondsRemaining = 600;
    });

    _processedTexts.clear();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  void _processDhikr(String text) {
    String cleaned = text.trim();

    if (_processedTexts.contains(cleaned)) return;

    bool canCount = _lastDhikrTime == null ||
        DateTime.now().difference(_lastDhikrTime!) > _cooldownPeriod;

    bool isDhikr = cleaned.contains(_selectedWerd) && canCount;

    if (isDhikr) {
      _processedTexts.add(cleaned);
      _lastDhikrTime = DateTime.now();
      incrementCounter();
    }
  }

  /// ================= COUNTER =================

  void incrementCounter() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    setState(() {
      counter++;
      if (counter == _targetCount) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('أحسنت! وصلت إلى $_targetCount',style: TextStyle(color:Theme.of(context).colorScheme.inversePrimary,),)),
        );
      }
    });

    _saveCounts();
  }

  void clear() {
    setState(() {
      tasabehcount += counter;
      counter = 0;
    });
    _saveCounts();
  }

  void clearAll() {
    setState(() {
      counter = 0;
      tasabehcount = 0;
    });
    _saveCounts();
  }

  /// ================= STORAGE =================

  Future<void> _loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
      tasabehcount = prefs.getInt('tasabehcount') ?? 0;
      _targetCount = prefs.getInt('targetCount') ?? 100;
      _selectedWerd = prefs.getString('selectedWerd') ?? 'سبحان الله';
    });
  }

  Future<void> _saveCounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
    await prefs.setInt('tasabehcount', tasabehcount);
    await prefs.setInt('targetCount', _targetCount);
    await prefs.setString('selectedWerd', _selectedWerd);
  }

  @override
  void dispose() {
    _animationController.dispose();
    player.dispose();
    _speech.stop();
    _listeningTimer?.cancel();
    _countdownTimer?.cancel();
    _silenceTimer?.cancel();
    super.dispose();
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    double circleSize = isPortrait ? screen.width * 0.5 : screen.height * 0.4;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title:  Text('المسبحة الالكترونية' ,style: TextStyle(color:Theme.of(context).colorScheme.primary,),),
        actions: [
          if (_isListening)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: Text(
                  '$_secondsRemaining',
                  style: TextStyle(fontSize: screen.width * 0.045),
                ),
              ),
            ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isListening ? _stopListening : _startListening,
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Styled Selection Container
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screen.width * 0.08),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true, // 🔥 VERY IMPORTANT
                        value: _selectedWerd,
                        decoration: InputDecoration(
                          labelText: 'الذكر الحالي',labelStyle: TextStyle(
                            color:Theme.of(context).colorScheme.primary,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.3),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                        items: _dhikrPhrases
                            .map(
                              (phrase) => DropdownMenuItem<String>(
                                value: phrase,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    style: TextStyle(color:Theme.of(context).colorScheme.primary,),
                                    phrase,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.rtl,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedWerd = v);
                          _saveCounts();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _selectedWerd,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'الهدف: $_targetCount',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w700,
                              color:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        DropdownButton<int>(
                          value: _targetCount,
                          items: [33, 66, 100, 200, 500]
                              .map((t) => DropdownMenuItem(
                                    value: t,
                                    child: Text('$t'),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _targetCount = v);
                            _saveCounts();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _targetCount == 0
                          ? 0.0
                          : (counter / _targetCount).clamp(0.0, 1.0).toDouble(),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Counter Capsule
            Container(
              margin: EdgeInsets.symmetric(vertical: screen.height * 0.02),
              padding: EdgeInsets.symmetric(
                  horizontal: screen.width * 0.1,
                  vertical: screen.height * 0.02),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '$counter',
                style: GoogleFonts.electrolize(
                  color:Theme.of(context).colorScheme.primary,
                  fontSize: screen.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Circle Button
            ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: incrementCounter,
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'اضغط',
                      style: TextStyle(
                        fontSize: screen.width * 0.06,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screen.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: clear,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screen.width * 0.03),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screen.width * 0.05,
                        vertical: screen.height * 0.015,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.restart_alt_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: screen.height * 0.02,
                        ),
                        SizedBox(width: screen.width * 0.02),
                        Text(
                          'إعادة',
                          style: GoogleFonts.robotoSlab(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: screen.height * 0.018,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("إعادة الضبط"),
                        content: Text("هل تريد إعادة الضبط الكلي؟"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("إلغاء")),
                          TextButton(
                              onPressed: () {
                                clearAll();
                                Navigator.pop(context);
                              },
                              child: Text("تأكيد",
                                  style: TextStyle(color: Colors.red))),
                        ],
                      ),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calculate,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'المجموع: $tasabehcount',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            if (_isListening)
              Text(
                'جاري الاستماع...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: screen.width * 0.045,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
