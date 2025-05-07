import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuranCompleteDuaa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Typography styles
    final TextStyle titleStyle = GoogleFonts.tajawal(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.primary,
    );
    
    final TextStyle duaStyle = GoogleFonts.tajawal(
      fontSize: 18,
      height: 2.2,
      color: theme.colorScheme.primary,
    );
    
    final TextStyle dividerStyle = GoogleFonts.tajawal(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary.withOpacity(0.7),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.inverseSurface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.inverseSurface,
        elevation: 0,
        title: Text(
          "دعاء ختم القرآن",
          style: titleStyle,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.inverseSurface,
              theme.colorScheme.inverseSurface.withOpacity(0.9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: isDarkMode ? Color.lerp(
                        theme.colorScheme.surface, const Color.fromARGB(255, 219, 218, 218), 0.3)!
                        :Color.lerp(
                        theme.colorScheme.surface, const Color.fromRGBO(128, 108, 73, 1), 0.3)!,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildDuaSection(
                      context,
                      "اللَّهُمَّ ارْحَمْنِي بالقُرْءَانِ وَاجْعَلهُ لِي إِمَاماً وَنُوراً وَهُدًى وَرَحْمَةً",
                      duaStyle,
                      dividerStyle,
                    ),
                    _buildDuaSection(
                      context,
                      "اللَّهُمَّ ذَكِّرْنِي مِنْهُ مَانَسِيتُ وَعَلِّمْنِي مِنْهُ مَاجَهِلْتُ وَارْزُقْنِي تِلاَوَتَهُ آنَاءَ اللَّيْلِ وَأَطْرَافَ النَّهَارِ وَاجْعَلْهُ لِي حُجَّةً يَارَبَّ العَالَمِينَ",
                      duaStyle,
                      dividerStyle,
                    ),
                    _buildDuaSection(
                      context,
                      "اللَّهُمَّ أَصْلِحْ لِي دِينِي الَّذِي هُوَ عِصْمَةُ أَمْرِي وَأَصْلِحْ لِي دُنْيَايَ الَّتِي فِيهَا مَعَاشِي وَأَصْلِحْ لِي آخِرَتِي الَّتِي فِيهَا مَعَادِي وَاجْعَلِ الحَيَاةَ زِيَادَةً لِي فِي كُلِّ خَيْرٍ وَاجْعَلِ المَوْتَ رَاحَةً لِي مِنْ كُلِّ شَرٍّ",
                      duaStyle,
                      dividerStyle,
                    ),
                    // Continue with all other dua sections...
                    _buildDuaSection(
                      context,
                      "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ وَصَلَّى اللهُ عَلَى سَيِّدِنَا وَنَبِيِّنَا مُحَمَّدٍ وَعَلَى آلِهِ وَأَصْحَابِهِ الأَخْيَارِ وَسَلَّمَ تَسْلِيمًا كَثِيراً",
                      duaStyle,
                      dividerStyle,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "آمين يا رب العالمين",
                        style: GoogleFonts.tajawal(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDuaSection(
      BuildContext context, String dua, TextStyle duaStyle, TextStyle dividerStyle) {
    return Column(
      children: [
        Text(
          dua,
          textAlign: TextAlign.center,
          style: duaStyle,
        ),
        const SizedBox(height: 16),
        Text(
          "۞",
          style: dividerStyle,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}