import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlanbiaa extends StatefulWidget {
  const AdyahAlanbiaa({super.key});

  @override
  State<AdyahAlanbiaa> createState() => _AdyahAlanbiaaState();
}

class _AdyahAlanbiaaState extends State<AdyahAlanbiaa> {
   
   // List of Quranic verses
  List<Map<String, String>> adyahAlanbiaa = [
           {
    "name": "آدم عليه السلام",
    "id": "1",
    "ayah": "رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ",
    "reference": "[الأعراف - 23]"
  },
  {
    "name": "نوح عليه السلام",
    "id": "2",
    "ayah": "رَّبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَلِمَن دَخَلَ بَيْتِيَ مُؤْمِنًا وَلِلْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ وَلَا تَزِدِ الظَّالِمِينَ إِلَّا تَبَارًا",
    "reference": "[نوح - 28]"
  },
  {
    "name": "نوح عليه السلام",
    "id": "2",
    "ayah": "رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ وَإِلاَّ تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ",
    "reference": "[هود - 47]"
  },
  {
    "name": "نوح عليه السلام",
    "id": "2",
    "ayah": "رَّبِّ أَنزِلْنِي مُنزَلاً مُّبَارَكاً وَأَنتَ خَيْرُ الْمُنزِلِينَ",
    "reference": "[المؤمنون - 29]"
  },
  {
    "name": "إبراهيم عليه السلام",
    "id": "3",
    "ayah": "رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ (127) رَبَّنَا وَاجْعَلْنَا مُسْلِمَيْنِ لَكَ وَمِنْ ذُرِّيَّتِنَا أُمَّةً مُسْلِمَةً لَكَ وَأَرِنَا مَنَاسِكَنَا وَتُبْ عَلَيْنَا إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ (128)",
    "reference": "[البقرة - 127-128]"
  },
  {
    "name": "إبراهيم عليه السلام",
    "id": "3",
    "ayah": "رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ (40) رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ الْحِسَابُ (41)",
    "reference": "[إبراهيم - 40-41]"
  },
  {
    "name": "إبراهيم عليه السلام",
    "id": "3",
    "ayah": "رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ (83) وَاجْعَل لِّي لِسَانَ صِدْقٍ فِي الْآخِرِينَ (84) وَاجْعَلْنِي مِن وَارِثَةِ جَنَّةِ النَّعِيمِ (85)",
    "reference": "[الشعراء - 83-85]"
  },
  {
    "name": "إبراهيم عليه السلام",
    "id": "3",
    "ayah": "رَّبَّنَا عَلَيْكَ تَوَكَّلْنَا وَإِلَيْكَ أَنَبْنَا وَإِلَيْكَ الْمَصِيرُ (4) رَبَّنَا لَا تَجْعَلْنَا فِتْنَةً لِّلَّذِينَ كَفَرُوا وَاغْفِرْ لَنَا رَبَّنَا ۖ إِنَّكَ أَنتَ الْعَزِيزُ الْحَكِيمُ (5)",
    "reference": "[الممتحنة - 4-5]"
  },
  {
    "name": "هود عليه السلام",
    "id": "4",
    "ayah": "إِنِّي تَوَكَّلْتُ عَلَى اللَّهِ رَبِّي وَرَبِّكُم ۚ مَّا مِن دَابَّةٍ إِلَّا هُوَ آخِذٌ بِنَاصِيَتِهَا ۚ إِنَّ رَبِّي عَلَىٰ صِرَاطٍ مُّسْتَقِيمٍ",
    "reference": "[هود - 56]"
  },
  {
    "name": "لوط عليه السلام",
    "id": "5",
    "ayah": "رَبِّ انْصُرْنِي عَلَى الْقَوْمِ الْمُفْسِدِينَ",
    "reference": "[العنكبوت - 30]"
  },
  {
    "name": "يوسف عليه السلام",
    "id": "6",
    "ayah": "فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ أَنتَ وَلِيِّي فِي الدُّنْيَا وَالْآخِرَةِ ۖ تَوَفَّنِي مُسْلِمًا وَأَلْحِقْنِي بِالصَّالِحِينَ",
    "reference": "[يوسف - 101]"
  },
  {
    "name": "موسى عليه السلام",
    "id": "8",
    "ayah": "رَبِّ اشْرَحْ لِي صَدْرِي (25) وَيَسِّرْ لِي أَمْرِي (26) وَاحْلُلْ عُقْدَةً مِّن لِّسَانِي (27) يَفْقَهُوا قَوْلِي (28)",
    "reference": "[طه - 25-28]"
  },
  {
    "name": "أيوب عليه السلام",
    "id": "9",
    "ayah": "أَنِّي مَسَّنِيَ الضُّرُّ وَأَنتَ أَرْحَمُ الرَّاحِمِينَ",
    "reference": "[الأنبياء - 83]"
  },
  {
    "name": "يونس عليه السلام",
    "id": "11",
    "ayah": "لَّا إِلَهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ",
    "reference": "[الأنبياء - 87]"
  },
  {
    "name": "زكريا عليه السلام",
    "id": "12",
    "ayah": "رَبِّ لَا تَذَرْنِي فَرْداً وَأَنتَ خَيْرُ الْوَارِثِينَ",
    "reference": "[الأنبياء - 89]"
  },
  {
    "name": "يعقوب عليه السلام",
    "id": "13",
    "ayah": "إِنَّمَا أَشْكُو بَثِّي وَحُزْنِي إِلَى اللَّهِ",
    "reference": "[يوسف - 86]"
  },
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < adyahAlanbiaa.length; i++) {
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
          "أدعية الأنبياء",
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
            final dua = adyahAlanbiaa[index];
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
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              dua["name"] ?? "غير معروف",
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : theme.colorScheme.surface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dua["reference"] ?? "",
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ],
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
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                dua["ayah"] ?? "لا يوجد دعاء",
                textAlign: TextAlign.justify,
                style: GoogleFonts.tajawal(
                  fontSize: 20,
                  height: 1.6,
                  color: isDarkMode ? Colors.white : theme.colorScheme.surface,
                ),
              ),
            ),
          ),
        ],
        iconColor: theme.colorScheme.primary,
        collapsedIconColor: theme.colorScheme.primary,
      ),
    );
  }
}