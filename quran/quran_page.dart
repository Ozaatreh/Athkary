import 'dart:async';
import 'package:athkary/pages/home_page.dart';
import 'package:athkary/pages/quran/bookmark_view.dart';
import 'package:athkary/pages/quran/pdf_view.dart';
import 'package:athkary/pages/quran/quran_complete_duaa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';



class QuranPartsScreen extends StatefulWidget {
  @override
  _QuranPartsScreenState createState() => _QuranPartsScreenState();
}

class _QuranPartsScreenState extends State<QuranPartsScreen> {
  // Search-related variables
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  // Function to handle search
  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        isSearching = false;
        searchResults = [];
      } else {
        isSearching = true;
        searchResults = [];
        quranParts.forEach((part, surahs) {
          for (var surah in surahs) {
            if (surah['name'].contains(query)) {
              searchResults.add(surah);
            }
          }
        });
      }
    });
  }

 Future<void> _navigateToPage(BuildContext context, int pageNumber) async {
    // First verify the PDF exists
    try {
      await DefaultAssetBundle.of(context)
          .load('assets/pdfs/Quraan_v0.pdf');
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuranViewerScreen(
            pdfPath: 'assets/pdfs/Quraan_v0.pdff',
            startPage: pageNumber,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading Quran PDF: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> navigateToLastPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final lastPage = prefs.getInt('lastPage') ?? 1;
    _navigateToPage(context, lastPage);
  }

  Future<void> navigateToBookmarkPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final savedBookmarkPage = prefs.getInt('savedBookmarkPage') ?? 1;
    _navigateToPage(context, savedBookmarkPage);
  }
   // Define all 30 parts and their Surahs with starting page numbers
final Map<int, List<Map<String, dynamic>>> quranParts = {
  1: [
    {"name": "الفاتحة", "page": 1},
    {"name": "البقرة", "page": 2},
  ],
  2: [
    {"name": "البقرة", "page": 22},
  ],
  3: [
    {"name": "البقرة", "page": 42},
    {"name": "آل عمران", "page": 50},
  ],
  4: [
    {"name": "آل عمران", "page": 62},
    {"name": "النساء", "page": 77},
  ],
  5: [
    {"name": "النساء", "page": 82},
    // {"name": "المائدة", "page": 109},
  ],
  6: [
    {"name": "النساء", "page": 102},
    {"name": "المائدة", "page": 103},
    // {"name": "الأنعام", "page": 124},
  ],
  7: [
    {"name": "المائدة", "page": 103},
    {"name": "الأنعام", "page": 128},
    // {"name": "الأعراف", "page": 131},
  ],
  8: [
    {"name": "الأنعام", "page": 142},
    {"name": "الأعراف", "page": 151},
  ],
  9: [
    {"name": "الأعراف", "page": 162},
    {"name": "الأنفال", "page": 177},
  ],
  10: [
    {"name": "الأنفال", "page": 182},
    {"name": "التوبة", "page": 187},
    // {"name": "يونس", "page": 211},
  ],
  11: [
    {"name": "التوبة", "page": 202},
    {"name": "يونس", "page": 208},
    {"name": "هود", "page": 221},
  ],
  12: [
    {"name": "هود", "page": 222},
    {"name": "يوسف", "page": 235},
  ],
  13: [
    {"name": "يوسف", "page": 242},
    {"name": "الرعد", "page": 249},
    {"name": "إبراهيم", "page": 255},
  ],
  14: [
    // {"name": "إبراهيم", "page": 255},
    {"name": "الحجر", "page": 262},
    {"name": "النحل", "page": 267},
  ],
  15: [
    {"name": "الإسراء", "page": 282},
    {"name": "الكهف", "page": 293},
  ],
  16: [
    {"name": "الكهف", "page": 302},
    {"name": "مريم", "page": 305},
    {"name": "طه", "page": 312},
  ],
  17: [
     {"name": "الأنبياء", "page": 322},
     {"name": "الحج", "page": 332},
  ],
  18: [
     {"name": "الحج", "page": 332},
     {"name": "المؤمنون", "page": 342},
     {"name": "النور", "page": 350},
     {"name": "الفرقان", "page": 359},
  ],
  19: [
    {"name": "الفرقان", "page": 362},
    {"name": "الشعراء", "page": 367},
    {"name": "النمل", "page": 377},
  ],
  20: [
   {"name": "النمل", "page": 382},
   {"name": "القصص", "page": 385}, 
   {"name": "العنكبوت", "page": 396},
  ],
  21: [
   {"name": "العنكبوت", "page": 402},
   {"name": "الروم", "page": 404},
   {"name": "لقمان", "page": 411},
   {"name": "السجدة", "page": 415},
   {"name": "الأحزاب", "page": 418},
  ],
  22: [
   {"name": "الأحزاب", "page": 422},
    {"name": "سبأ", "page": 428},
    {"name": "فاطر", "page": 434},
    {"name": "يس", "page": 440},
  ],
  23: [
    {"name": "يس", "page": 442},
    {"name": "الصافات", "page": 446},
    {"name": "ص", "page": 453},
    {"name": "الزمر", "page": 458},
  ],

  24: [
    {"name": "الزمر", "page": 462},
    {"name": "غافر", "page": 467},
    {"name": "فصلت", "page": 477},

  ],
  25: [
    {"name": "فصلت", "page": 482},
    {"name": "الشورى", "page": 483},
    {"name": "الزخرف", "page": 489},
    {"name": "الدخان", "page": 496},
    {"name": "الجاثية", "page": 499},
   
  ],
  26: [
    {"name": "الجاثية", "page": 502},
    {"name": "الأحقاف", "page": 502},
    {"name": "محمد", "page": 507},
    {"name": "الفتح", "page": 511},
    {"name": "الحجرات", "page": 515},
    {"name": "ق", "page": 518},
    {"name": "الذاريات", "page": 520},
  ],
  27: [
    {"name": "الذاريات", "page": 522},
    {"name": "الطور", "page": 523},
    {"name": "النجم", "page": 526},
    {"name": "القمر", "page": 528},
    {"name": "الرحمن", "page": 531},
    {"name": "الواقعة", "page": 534},
    {"name": "الحديد", "page": 537},
  ],
  28: [
    {"name": "المجادلة", "page": 542},
    {"name": "الحشر", "page": 545},
    {"name": "الممتحنة", "page": 549},
    {"name": "الصف", "page": 551},
    {"name": "الجمعة", "page": 553},
    {"name": "المنافقون", "page": 554},
    {"name": "التغابن", "page": 556},
    {"name": "الطلاق", "page": 558},
    {"name": "التحريم", "page": 560},
  ],
  29: [
    
   {"name": "الملك", "page": 562},
   {"name": "القلم", "page": 564},
   {"name": "الحاقة", "page": 566},
   {"name": "المعارج", "page": 568},
   {"name": "نوح", "page": 570},
   {"name": "الجن", "page": 572},
   {"name": "المزمل", "page": 574},
   {"name": "المدثر", "page": 575},
   {"name": "القيامة", "page": 577},
   {"name": "الإنسان", "page": 578},
   {"name": "المرسلات", "page": 580},
  ],
  30: [
    {"name": "النبأ", "page": 582},
    {"name": "النازعات", "page": 583},
    {"name": "عبس", "page": 585},
    {"name": "التكوير", "page": 586},
    {"name": "الانفطار", "page": 587},
    {"name": "المطففين", "page": 587},
    {"name": "الانشقاق", "page": 589},
    {"name": "البروج", "page": 590},
    {"name": "الطارق", "page": 591},
    {"name": "الأعلى", "page": 591},
    {"name": "الغاشية", "page": 592},
    {"name": "الفجر", "page": 593},
    {"name": "البلد", "page": 594},
    {"name": "الشمس", "page": 595},
    {"name": "الليل", "page": 595},
    {"name": "الضحى", "page": 596},
    {"name": "الشرح", "page": 596},
    {"name": "التين", "page": 597},
    {"name": "العلق", "page": 597},
    {"name": "القدر", "page": 598},
    {"name": "البينة", "page": 598},
    {"name": "الزلزلة", "page": 599},
    {"name": "العاديات", "page": 599},
    {"name": "القارعة", "page": 600},
    {"name": "التكاثر", "page": 600},
    {"name": "العصر", "page": 601},
    {"name": "الهمزة", "page": 601},
    {"name": "الفيل", "page": 601},
    {"name": "قريش", "page": 602},
    {"name": "الماعون", "page": 602},
    {"name": "الكوثر", "page": 602},
    {"name": "الكافرون", "page": 603},
    {"name": "النصر", "page": 603},
    {"name": "المسد", "page": 603},
    {"name": "الإخلاص", "page": 604},
    {"name": "الفلق", "page": 604},
    {"name": "الناس", "page": 604}
    
    
  ],
  
  
};
 

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Typography styles
    final TextStyle partTitleStyle = GoogleFonts.tajawal(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.primary,
    );

    final TextStyle surahNameStyle = GoogleFonts.tajawal(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.primary,
    );

    final TextStyle pageNumberStyle = GoogleFonts.tajawal(
      fontSize: 14,
      color: theme.colorScheme.primary.withOpacity(0.9),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.primary),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(right: 90.0),
                child: Text(
                  'القرآن الكريم',
                  style: GoogleFonts.tajawal(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.surface.withOpacity(0.9),
                      theme.colorScheme.surface.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Lottie.asset(
                  'assets/animations/wired-lineal-19-magnifier-zoom-search-hover-spin.json',
                  width: 24,
                  height: 24,
                  // color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                    if (!isSearching) _searchController.clear();
                  });
                },
              ),
              IconButton(
                icon: Lottie.asset(
                  'assets/animations/wired-lineal-400-bookmark-hover-flutter.json',
                  width: 24,
                  height: 24,
                  // color: theme.colorScheme.primary,
                ),
                onPressed: () => navigateToBookmarkPage(context),
              ),
              IconButton(
                icon: Lottie.asset(
                  'assets/animations/wired-lineal-112-book-hover-flutter.json',
                  width: 24,
                  height: 24,
                  // color: theme.colorScheme.primary,
                ),
                onPressed: () => navigateToLastPage(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          if (isSearching)
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن سورة...',
                    prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                    ),
                  ),
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
            ),

          if (isSearching && searchResults.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final surah = searchResults[index];
                  return ListTile(
                    title: Text(surah['name'], style: surahNameStyle),
                    trailing: Text('صفحة ${surah['page']}', style: pageNumberStyle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuranViewerScreen(
                            pdfPath: 'assets/pdfs/Quraan_v0.pdf',
                            startPage: surah['page'],
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: searchResults.length,
              ),
            ),

          if (!isSearching)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final partNumber = index + 1;
                    final surahs = quranParts[partNumber]!;
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      child: ExpansionTile(
                        title: Text('الجزء $partNumber', style: partTitleStyle),
                        children: surahs.map((surah) {
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                            title: Text(surah['name'], style: surahNameStyle),
                            trailing: Text('صفحة ${surah['page']}', style: pageNumberStyle),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuranViewerScreen(
                                    pdfPath: 'assets/pdfs/Quraan_v0.pdf',
                                    startPage: surah['page'],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                  childCount: quranParts.length,
                ),
              ),
            ),

          // Quran Completion Supplication Card
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuranCompleteDuaa()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.surface,
                        theme.colorScheme.primary.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu_book, color: theme.colorScheme.primary),
                      TextButton(
                        
                       child: Text('دعاء ختم القرآن',
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        )), 
                        onPressed: () { Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => QuranCompleteDuaa(),)
                        ); },  
                      ),
                      SizedBox(width: 1,)
                      // Lottie.asset(
                        // 'assets/animations/wired-lineal-1763-bookmark-book.json',
                        // width: 24,
                        // height: 24,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
