
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlanbiaa extends StatefulWidget {
  const AdyahAlanbiaa({super.key});

  @override
  State<AdyahAlanbiaa> createState() => _AdyahAlanbiaaState();
}

class _AdyahAlanbiaaState extends State<AdyahAlanbiaa>
    with TickerProviderStateMixin {
  late AnimationController _controller;
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
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D1B2A),
                Color(0xFF1B263B),
                Color(0xFF2C3E50),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [

                /// ===== HEADER =====
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Center(
                          child: Text(
                            "أدعية الأنبياء",
                            style: GoogleFonts.amiri(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withOpacity(0.1),
                ),

                const SizedBox(height: 16),

                /// ===== CONTENT =====
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: adyahAlanbiaa.length,
                    itemBuilder: (context, index) {
                      final dua = adyahAlanbiaa[index];

                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / adyahAlanbiaa.length),
                          1.0,
                          curve: Curves.easeOut,
                        ),
                      );

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(animation),
                          child: _buildTile(dua),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(Map<String, String> dua) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white70,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dua["name"] ?? "غير معروف",
                style: GoogleFonts.amiri(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 4),
              Text(
                dua["reference"] ?? "",
                style: GoogleFonts.amiri(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          children: [
            Text(
              dua["ayah"] ?? "لا يوجد دعاء",
              style: GoogleFonts.amiri(
                fontSize: 22,
                height: 1.9,
                color: Colors.white.withOpacity(0.95),
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}