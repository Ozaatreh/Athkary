import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlnabi extends StatefulWidget {
  const AdyahAlnabi({super.key});

  @override
  State<AdyahAlnabi> createState() => _AdyahAlnabiState();
}

class _AdyahAlnabiState extends State<AdyahAlnabi> {
  
    // List of Prophet's supplications
    final List<Map<String, String>> adyahAlnabi = [
   {
    "text": "اللَّهُمَّ أنَْتَ رَبيِّ لَا إلِهََ إلَِّا أنَتَ، خَلَقْتنَيِ وَأنََا عَبدُْكَ، وَأنََا عَلَى عَهدِْكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أعَُوذُ بكَِ مِنْ شَرِّ مَا صَنَعْتُ، أبَوُءُ لكََ بنِعِْمَتكَِ عَلَيَّ وَأبَوُءُ بذَِنبِْي، فَاغْفِرْ ليِ فإَِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أنَتَ.",
    "reference": "رواه البخاري (6306) عن شداد بن أوس، وقد وصف النبي هذا الدعاء بأنه سيد الاستغفار."
  },
  {
    "text": "اللَّهُمَّ إِنِّي ظَلَمْتُ نَفْسِي ظُلْمًا كَثِيرًا، وَلَا يَغْفِرُ الذُّنُوبَ إِلَّا أنَتَ، فَاغْفِرْ ليِ مَغْفِرَةً مِنْ عِنْدِكَ، وَارْحَمْنِي، إِنَّكَ أنَتَ الْغَفُورُ الرَّحِيمُ.",
    "reference": "رواه البخاري (834) ومسلم (2705) عن أبي بكر الصديق."
  },
  {
    "text": "رَبِّ اغْفِرْ لِي خَطِيئَتِي وَجَهْلِي وَإِسْرَافِي فِي أمَْرِي وَمَا أنَتَ أعَْلَمُ بِهِ مِنِّي، اللَّهُمَّ اغْفِرْ ليِ جِدِّي وَهَزْلِي وَخَطَئِي وَعَمْدِي، وَكُلُّ ذَلكَِ عِنْدِي، اللَّهُمَّ اغْفِرْ ليِ مَا قَدَّمْتُ وَمَا أخََّرْتُ وَمَا أسَْرَرْتُ وَمَا أعَْلَنْتُ، وَمَا أنَتَ أعَْلَمُ بِهِ مِنِّي، أنَتَ الْمُقَدِّمُ وَأنَتَ الْمُؤَخِّرُ، وَأنَتَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.",
    "reference": "رواه البخاري (6398) ومسلم (2719) عن عبد الله بن عباس."
  },
  {
    "text": "اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ، وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ.",
    "reference": "رواه الترمذي (3563) عن علي بن أبي طالب، وحسنه الألباني."
  },
  {
    "text": "اللَّهُمَّ اهْدِنيِ وَسَدِّدْنِي.",
    "reference": "رواه مسلم (2725) عن علي بن أبي طالب."
  },
  {
    "text": "اللَّهُمَّ إِنِّي أسَْألَُكَ الْهُدَى وَالسَّدَادَ.",
    "reference": "رواه مسلم (2726) عن عبد الله بن عباس."
  },
  {
    "text": "اللَّهُمَّ إنِّي أسَْألَُكَ الهُدَى وَالتُّقَى وَالعَفَافَ وَالغِنَى.",
    "reference": "رواه مسلم (2721) عن عبد الله بن مسعود."
  },
  {
    "text": "اللَّهُمَّ اجْعَلْ فيِ قَلبِْي نوُرًا، وَفيِ لسَِانِي نوُرًا، وَفيِ سَمْعِي نوُرًا، وَفيِ بَصَرِي نوُرًا، وَمِنْ فوَْقِي نوُرًا، وَمِنْ تحَْتِي نوُرًا، وَعَنْ يَمِينِي نوُرًا، وَعَنْ شِمَالِي نوُرًا، وَمِنْ أمََامِي نوُرًا، وَمِنْ خَلْفِي نوُرًا، وَاجْعَلْ ليِ نوُرًا.",
    "reference": "رواه البخاري (6316) ومسلم (763) عن عبد الله بن عباس."
  },
  {
    "text": "اللَّهُمَّ إنِّي أعَُوذُ بكَِ مِنْ جَهْدِ البَلاَءِ، وَدَرَكِ الشَّقَاءِ، وَسُوءِ القَضَاءِ، وَشَمَاتَةِ الأعَْدَاءِ.",
    "reference": "رواه البخاري (6347) ومسلم (2707) عن أبي هريرة."
  },
  {
    "text": "اللَّهُمَّ إنِّي أعَُوذُ بكَِ مِنْ العَجْزِ، وَالكَسَلِ، وَالبُخْلِ، وَالهَرَمِ، وَعَذَابِ القَبْرِ، اللَّهُمَّ آتِ نفَْسِي تَقْوَاهَا، وَزَكِّهَا أنَتَ خَيْرُ مَنْ زَكَّاهَا، أنَتَ وَليُِّهَا وَمَوْلَاهَا، اللَّهُمَّ إِنِّي أعَُوذُ بكَِ مِنْ عِلْمٍ لَا يَنْفَعُ، وَمِنْ قَلْبٍ لَا يخَْشَعُ، وَمِنْ نَفْسٍ لَا تَشْبَعُ، وَمِنْ دَعْوَةٍ لَا يسُْتَجَابُ لَهَا.",
    "reference": "رواه مسلم (2722) عن زيد بن أرقم."
  },
  {
    "text": "اللَّهُمَّ إِنِّي أسَْألَُكَ مُوجِبَاتِ رَحْمَتِكَ، وَعَزَائِمَ مَغْفِرَتِكَ، وَالسَّلَامَةَ مِنْ كُلِّ إِثمٍْ، وَالغَنِيمَةَ مِنْ كُلِّ برٍِّ، وَالفَوْزَ بِالجَنَّةِ، وَالنَّجَاةَ مِنْ النَّارِ.",
    "reference": "رواه الحاكم في المستدرك (1/521) عن عبد الله بن عمر، وصححه الألباني."
  }
];




  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < adyahAlnabi.length; i++) {
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
          "أدعية النَبِي",
          style: GoogleFonts.tajawal(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : theme.colorScheme.inversePrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDarkMode ? Colors.white : theme.colorScheme.inversePrimary,
          ),
          onPressed: () => Navigator.pop(context),
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
        child: AnimatedList(
          key: _listKey,
          controller: _scrollController,
          initialItemCount: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          itemBuilder: (context, index, animation) {
            final dua = adyahAlnabi[index];
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
                child: _buildDuaCard(context, dua, index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDuaCard(BuildContext context, Map<String, String> dua, int index) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            dua["text"] ?? "لا يوجد دعاء",
            textAlign: TextAlign.start,
            style: GoogleFonts.tajawal(
              fontSize: 20,
              height: 1.4,
              color: isDarkMode ? Colors.white : theme.colorScheme.surface,
            ),
          ),
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.primary.withOpacity(0.1),
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                dua["reference"] ?? "",
                textAlign: TextAlign.right,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  height: 1.5,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
            ),
          ],
          iconColor: theme.colorScheme.primary,
          collapsedIconColor: theme.colorScheme.primary,
        ),
      ),
    );
  }
}