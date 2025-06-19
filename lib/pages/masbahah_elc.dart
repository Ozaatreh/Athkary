import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class MasbahaElc extends StatefulWidget {
  const MasbahaElc({super.key});

  @override
  _MasbahaElcState createState() => _MasbahaElcState();
}

class _MasbahaElcState extends State<MasbahaElc> with SingleTickerProviderStateMixin {
  int counter = 0;
  int tasabehcount = 0;
  final player = AudioPlayer();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  // Voice recognition
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _lastWords = '';

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

  // Voice counting control
  Timer? _listeningTimer;
  final Duration _listeningDuration = Duration(minutes: 1); // 1 minute listening
  final Duration _cooldownPeriod = Duration(milliseconds: 800);
  DateTime? _lastDhikrTime;
  Set<String> _processedTexts = Set();
  int _secondsRemaining = 60;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _loadCounts();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _speech = stt.SpeechToText();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSpeech();
    });
  }

  void _initSpeech() async {
    try {
      var status = await Permission.microphone.status;
      
      if (status.isDenied) {
        if (Platform.isAndroid) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Microphone Permission'),
              content: Text('This app needs microphone access to recognize thekir'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await Permission.microphone.request();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          await Permission.microphone.request();
        }
        
        status = await Permission.microphone.status;
      }
      
      if (status.isPermanentlyDenied) {
        await openAppSettings();
        return;
      }
      
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission required')),
        );
        return;
      }

      bool available = await _speech.initialize(
        onStatus: (status) => setState(() => _isListening = status == 'listening'),
        onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.errorMsg}')),
        ),
      );
      
      if (!available) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _startListening() async {
    try {
      _processedTexts.clear();
      _secondsRemaining = 60;
      _startCountdown();
      
      bool available = await _speech.initialize();
      if (!available) return;

      _listeningTimer = Timer(_listeningDuration, _stopListening);
      
      await _speech.listen(
        onResult: (result) => _processDhikr(result.recognizedWords),
        localeId: 'ar-SA',
        listenFor: _listeningDuration,
        pauseFor: Duration(seconds: 3),
        partialResults: true,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  void _processDhikr(String text) {
    String cleanedText = text.trim();
    
    if (_processedTexts.contains(cleanedText)) return;
    
    bool canCount = _lastDhikrTime == null || 
        DateTime.now().difference(_lastDhikrTime!) > _cooldownPeriod;

    bool isDhikr = _dhikrPhrases.any((phrase) => 
        cleanedText.contains(phrase) && canCount);

    if (isDhikr) {
      _processedTexts.add(cleanedText);
      _lastDhikrTime = DateTime.now();
      incrementCounter();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
          content: Center(
            child: Text('تم تسجيل الذكر: ${_getMatchedPhrase(cleanedText)}',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),)),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  String _getMatchedPhrase(String text) {
    return _dhikrPhrases.firstWhere((phrase) => text.contains(phrase),
        orElse: () => 'ذكر');
  }

  void _stopListening() {
    try {
      _speech.stop();
      _listeningTimer?.cancel();
      _countdownTimer?.cancel();
      setState(() {
        _isListening = false;
        _secondsRemaining = 60;
      });
      _processedTexts.clear();
    } catch (e) {
      print('Error stopping: $e');
    }
  }

  Future<void> _loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
      tasabehcount = prefs.getInt('tasabehcount') ?? 0;
    });
  }

  Future<void> _saveCounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
    await prefs.setInt('tasabehcount', tasabehcount);
  }

  Future<void> _playSound() async {
    await player.play(AssetSource('audios/counter100.m4a'), volume: 100);
  }

  void incrementCounter() {
    _animationController.forward().then((_) => _animationController.reverse());
    
    setState(() {
      counter++;
      if (counter % 100 == 0) {
        _playSound();
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
      tasabehcount = 0;
      counter = 0;
    });
    _saveCounts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    player.dispose();
    _speech.stop();
    _listeningTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded ,
          color: Theme.of(context).colorScheme.primary,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          
          'المسبحة الالكترونية',
          style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,),
        ),
        actions: [
          if (_isListening)
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: Text(
                  '$_secondsRemaining',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isListening ? _stopListening : _startListening,
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                ),
                child: Text(
                  '$counter',
                  style: GoogleFonts.electrolize(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
                ),
              ),
              
              SizedBox(height: 30),
              
              ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: incrementCounter,
                  child: Container(
                    width: isPortrait ? screenSize.width * 0.5 : screenSize.height * 0.5,
                    height: isPortrait ? screenSize.width * 0.5 : screenSize.height * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: Offset(0, 5)),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'اضغط',
                        style: GoogleFonts.robotoSlab(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 40),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     ElevatedButton(
                            onPressed: clear,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenSize.width * 0.03),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.05,
                                vertical: screenSize.height * 0.015,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.restart_alt_rounded, 
                                  color: Theme.of(context).colorScheme.inversePrimary, 
                                  size: screenSize.height * 0.02,
                                ),
                                SizedBox(width: screenSize.width * 0.02),
                                Text(
                                  'إعادة',
                                  style: GoogleFonts.robotoSlab(
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                    fontSize: screenSize.height * 0.018,
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
                              child: Text("تأكيد", style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calculate ,color: Theme.of(context).colorScheme.primary,),
                            SizedBox(width: 8),
                            Text('المجموع: $tasabehcount',style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              if (_isListening)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'جاري الاستماع...',
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}