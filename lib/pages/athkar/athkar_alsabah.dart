import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
class AthkarAlsabah extends StatefulWidget {
  const AthkarAlsabah({super.key});

  @override
  State<AthkarAlsabah> createState() => _AthkarAlsabahState();
}

class _AthkarAlsabahState extends State<AthkarAlsabah> {
  final List<String> athkarMorning = [
    'سُورَةُ الإِخْلَاصِ\nبسم ٱللهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ قُلْ هُوَ ٱللهُ أَحَدٌ * ٱللهُ ٱلصَّمَدُ * لَمْ يَلِدْ وَلَمْ يُولَدْ * وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌ *',
    'سُورَةُ الْفَلَقِ\nبِسْمِ ٱللهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ * مِن شَرِّ مَا خَلَقَ * وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ * وَمِن شَرِّ ٱلنَّفَّـٰثَـٰتِ فِى ٱلْعُقَدِ * وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ *',
    'سُورَةُ النَّاسِ\nبِسْمِ ٱللهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ * مَلِكِ ٱلنَّاسِ * إِلَـٰهِ ٱلنَّاسِ * مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ * ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ * مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ *',
    'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً، وَرِزْقاً طَيِّباً، وَعَمَلاً مُتَقَبَّلاً',
    'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
    'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الَْأرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّماوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
    'رَضِيتُ باللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَى اللَّهُ عَلِيهِ وَسَلَّمَ نَبِيَّاً',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'يَاحَيُّ، يَا قَيُّومُ، بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
    'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُمَّ إِنِّـي أَسْأَلُكَ خَـيْرَ هَذَا الْـيَوْمِ ، فَتْحَهُ، وَنَصْرَهُ، وَنُورَهُ وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ',
    'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ',
    'اللَّهُمَّ أَنْتَ رَبِّي لَّا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِر لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
    'اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
    'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
  ];

  final List<String> athkarInfo = [
    'يثبت العبودية والتوحيد',
    'شهادة على الإيمان بالله',
    ' يعظم الله ويعدد نعمه',
    'دعاء يعبر عن الرضا بالله والإسلام والنبي',
    'طلب العافية في البدن',
    'سورة الإخلاص فيها التوحيد الخالص',
    'سورة الفلق للحماية من الشرور',
    'سورة الناس للحماية من وسوسة الشيطان',
    'طلب العلم النافع والعمل المقبول',
    'طلب المغفرة والعودة إلى الله',
    'ذكر للحفظ من الأذى',
    'دعاء للحماية من النفس والشيطان',
    'ذكر يعظم الله بطرق متعددة',
    'الرضا بالله والإسلام والنبي محمد',
    'تسبيح لله بحمده',
    'طلب إصلاح كل شؤون العبد',
    'طلب الخير في اليوم والبركة',
    'شهادة على وحدانية الله ورسالة النبي',
    'دعاء للثبات على الوعد والاستغفار',
    'شكر الله على نعمه العظيمة',
    'ذكر عظيم يثبت التوحيد وقدرة الله',
  ];

    final List<int> maxCounts = [3, 3, 3, 1, 1, 3, 1, 3, 1, 100, 1, 1, 4, 1, 1, 100];
  late List<int> currentCounts;
  late String lastResetDate;
  late SharedPreferences _prefs;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeCounts();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  Future<void> _initializeCounts() async {
    _prefs = await SharedPreferences.getInstance();
    final today = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    // Load last reset date or set to today
    lastResetDate = _prefs.getString('lastResetDateMorning') ?? today;
    
    // Check if we need to reset (new day)
    if (lastResetDate != today) {
      await _resetCounts();
      await _prefs.setString('lastResetDateMorning', today);
    } else {
      // Load saved counts if available
      final savedCounts = _prefs.getStringList('morningCounts');
      if (savedCounts != null && savedCounts.length == maxCounts.length) {
        currentCounts = savedCounts.map((e) => int.parse(e)).toList();
      } else {
        currentCounts = List<int>.from(maxCounts);
      }
    }
    
    setState(() {});
  }

  Future<void> _resetCounts() async {
    currentCounts = List<int>.from(maxCounts);
    await _saveCounts();
  }

  Future<void> _saveCounts() async {
    await _prefs.setStringList(
      'morningCounts',
      currentCounts.map((e) => e.toString()).toList(),
    );
  }

  Future<void> _decrementCount(int index) async {
    final today = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (lastResetDate != today) {
      await _resetCounts();
      lastResetDate = today;
      await _prefs.setString('lastResetDateMorning', today);
    }

    if (currentCounts[index] > 0) {
      setState(() {
        currentCounts[index]--;
      });
      await _saveCounts();
    }
  }

  void _animateItems() async {
    for (int i = 0; i < athkarMorning.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
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
          "أذكار الصباح",
          style: GoogleFonts.tajawal(
            fontSize: 24,
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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.wb_sunny_rounded,
              color: theme.colorScheme.primary,
            ),
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
                  ],
                )
              : null,
          color: isDarkMode ? theme.colorScheme.surface : theme.colorScheme.surface,
        ),
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
    );
  }

  Widget _buildThikrCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _decrementCount(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  colors: [Color(0xFF2E2E2E), Color(0xFF1C1C1C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Color(0xFFEAF2F8), Color(0xFFDFECF2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.wb_sunny_rounded, color: isDarkMode ? theme.colorScheme.primary.withOpacity(0.65) : theme.colorScheme.surface),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: currentCounts[index] == 0 
                            ? Colors.green.withOpacity(0.65) 
                            : theme.colorScheme.primary.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        currentCounts[index] == 0
                            ? "تم"
                            : "${currentCounts[index]} ",
                        style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  athkarMorning[index],
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.8,
                    color: isDarkMode ? Colors.white : theme.colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  athkarInfo[index],
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                  ),
                ),
                Divider(height: 20, color: theme.colorScheme.primary.withOpacity(0.2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.volume_up_rounded, color: isDarkMode ? theme.colorScheme.primary.withOpacity(0.65) : theme.colorScheme.surface),
                      onPressed: () {
                        // TODO: Add audio feature
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}