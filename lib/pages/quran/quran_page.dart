import 'dart:async';
import 'dart:io';
import 'package:athkary/pages/home_page.dart';
import 'package:athkary/pages/quran/bookmark_view.dart';
import 'package:athkary/pages/quran/pdf_view.dart';
import 'package:athkary/pages/quran/quran_complete_duaa.dart';
import 'package:athkary/services/pdf_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranPartsScreen extends StatefulWidget {
  @override
  _QuranPartsScreenState createState() => _QuranPartsScreenState();
}

class _QuranPartsScreenState extends State<QuranPartsScreen> {

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    /// Show popup after page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowPopup();
    });
  }
  
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
  /// Popup + download logic
  Future<void> _checkAndShowPopup() async {

    final downloaded = await PdfCacheService.isDownloaded();
    if (downloaded) return;

    bool shouldDownload = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تحميل القرآن"),
        content: const Text(
          "القرآن غير محمّل على جهازك.\nهل تريد تحميله الآن؟",
        ),
        actions: [
          TextButton(
            child: const Text("إلغاء"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("تحميل"),
            onPressed: () {
              shouldDownload = true;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    if (!shouldDownload) return;

    /// Loader while downloading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await PdfCacheService.downloadPdf();
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل تحميل القرآن: $e")),
      );
    }
  }

  /// Navigate safely
  Future<void> _navigateToPage(BuildContext context, int pageNumber) async {

    final file = await PdfCacheService.getIfExists();

    if (file == null) {
      await _checkAndShowPopup();

      final after = await PdfCacheService.getIfExists();
      if (after == null) return;

      _openPdf(after, pageNumber);
    } else {
      _openPdf(file, pageNumber);
    }
  }

  void _openPdf(File file, int page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuranViewerScreen(
          pdfPath: file.path,
          startPage: page,
        ),
      ),
    );
  }

  Future<void> navigateToLastPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final lastPage = prefs.getInt('lastPage') ?? 1;
    _navigateToPage(context, lastPage);
  }

  Future<void> navigateToBookmarkPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final savedBookmarkPage = prefs.getInt('savedBookmarkPage') ?? 0;

    final file = await PdfCacheService.getIfExists();
    if (file == null) {
      await _checkAndShowPopup();
      final after = await PdfCacheService.getIfExists();
      if (after == null) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BookmarkPdfViewerScreen(
            pdfPath: after.path,
            startPage: savedBookmarkPage + 1,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BookmarkPdfViewerScreen(
            pdfPath: file.path,
            startPage: savedBookmarkPage + 1,
          ),
        ),
      );
    }
  }
final Map<int, List<Map<String, dynamic>>> quranParts = {
  1: [
    {"name": "الفاتحة", "page": 1},
    {"name": "البقرة", "page": 1},
  ],
  2: [
    {"name": "البقرة", "page": 21},
  ],
  3: [
    {"name": "البقرة", "page": 41},
    {"name": "آل عمران", "page": 49},
  ],
  4: [
    {"name": "آل عمران", "page": 61},
    {"name": "النساء", "page": 76},
  ],
  5: [
    {"name": "النساء", "page": 81},
  ],
  6: [
    {"name": "النساء", "page": 101},
    {"name": "المائدة", "page": 105},
  ],
  7: [
    {"name": "المائدة", "page": 121},
    {"name": "الأنعام", "page": 127},
  ],
  8: [
    {"name": "الأنعام", "page": 141},
    {"name": "الأعراف", "page": 150},
  ],
  9: [
    {"name": "الأعراف", "page": 161},
    {"name": "الأنفال", "page": 176},
  ],
  10: [
    {"name": "الأنفال", "page": 181},
    {"name": "التوبة", "page": 186},
  ],
  11: [
    {"name": "التوبة", "page": 201},
    {"name": "يونس", "page": 207},
    {"name": "هود", "page": 220},
  ],
  12: [
    {"name": "هود", "page": 221},
    {"name": "يوسف", "page": 234},
  ],
  13: [
    {"name": "يوسف", "page": 241},
    {"name": "الرعد", "page": 248},
    {"name": "إبراهيم", "page": 254},
  ],
  14: [
    {"name": "الحجر", "page": 261},
    {"name": "النحل", "page": 266},
  ],
  15: [
    {"name": "الإسراء", "page": 281},
    {"name": "الكهف", "page": 292},
  ],
  16: [
    {"name": "الكهف", "page": 301},
    {"name": "مريم", "page": 304},
    {"name": "طه", "page": 311},
  ],
  17: [
     {"name": "الأنبياء", "page": 321},
     {"name": "الحج", "page": 331},
  ],
  18: [
     {"name": "الحج", "page": 331},
     {"name": "المؤمنون", "page": 341},
     {"name": "النور", "page": 349},
     {"name": "الفرقان", "page": 358},
  ],
  19: [
    {"name": "الفرقان", "page": 361},
    {"name": "الشعراء", "page": 366},
    {"name": "النمل", "page": 376},
  ],
  20: [
   {"name": "النمل", "page": 381},
   {"name": "القصص", "page": 384}, 
   {"name": "العنكبوت", "page": 395},
  ],
  21: [
   {"name": "العنكبوت", "page": 401},
   {"name": "الروم", "page": 403},
   {"name": "لقمان", "page": 410},
   {"name": "السجدة", "page": 414},
   {"name": "الأحزاب", "page": 417},
  ],
  22: [
   {"name": "الأحزاب", "page": 421},
    {"name": "سبأ", "page": 427},
    {"name": "فاطر", "page": 433},
    {"name": "يس", "page": 439},
  ],
  23: [
    {"name": "يس", "page": 441},
    {"name": "الصافات", "page": 445},
    {"name": "ص", "page": 452},
    {"name": "الزمر", "page": 457},
  ],
  24: [
    {"name": "الزمر", "page": 461},
    {"name": "غافر", "page": 466},
    {"name": "فصلت", "page": 476},
  ],
  25: [
    {"name": "فصلت", "page": 481},
    {"name": "الشورى", "page": 482},
    {"name": "الزخرف", "page": 488},
    {"name": "الدخان", "page": 495},
    {"name": "الجاثية", "page": 498},
  ],
  26: [
    {"name": "الجاثية", "page": 501},
    {"name": "الأحقاف", "page": 501},
    {"name": "محمد", "page": 506},
    {"name": "الفتح", "page": 510},
    {"name": "الحجرات", "page": 514},
    {"name": "ق", "page": 517},
    {"name": "الذاريات", "page": 519},
  ],
  27: [
    {"name": "الذاريات", "page": 521},
    {"name": "الطور", "page": 522},
    {"name": "النجم", "page": 525},
    {"name": "القمر", "page": 527},
    {"name": "الرحمن", "page": 530},
    {"name": "الواقعة", "page": 533},
    {"name": "الحديد", "page": 536},
  ],
  28: [
    {"name": "المجادلة", "page": 541},
    {"name": "الحشر", "page": 544},
    {"name": "الممتحنة", "page": 548},
    {"name": "الصف", "page": 550},
    {"name": "الجمعة", "page": 552},
    {"name": "المنافقون", "page": 553},
    {"name": "التغابن", "page": 555},
    {"name": "الطلاق", "page": 557},
    {"name": "التحريم", "page": 559},
  ],
  29: [
   {"name": "الملك", "page": 561},
   {"name": "القلم", "page": 563},
   {"name": "الحاقة", "page": 565},
   {"name": "المعارج", "page": 567},
   {"name": "نوح", "page": 569},
   {"name": "الجن", "page": 571},
   {"name": "المزمل", "page": 573},
   {"name": "المدثر", "page": 574},
   {"name": "القيامة", "page": 576},
   {"name": "الإنسان", "page": 577},
   {"name": "المرسلات", "page": 579},
  ],
  30: [
    {"name": "النبأ", "page": 581},
    {"name": "النازعات", "page": 582},
    {"name": "عبس", "page": 584},
    {"name": "التكوير", "page": 585},
    {"name": "الانفطار", "page": 586},
    {"name": "المطففين", "page": 586},
    {"name": "الانشقاق", "page": 588},
    {"name": "البروج", "page": 589},
    {"name": "الطارق", "page": 590},
    {"name": "الأعلى", "page": 590},
    {"name": "الغاشية", "page": 591},
    {"name": "الفجر", "page": 592},
    {"name": "البلد", "page": 593},
    {"name": "الشمس", "page": 594},
    {"name": "الليل", "page": 594},
    {"name": "الضحى", "page": 595},
    {"name": "الشرح", "page": 595},
    {"name": "التين", "page": 596},
    {"name": "العلق", "page": 596},
    {"name": "القدر", "page": 597},
    {"name": "البينة", "page": 597},
    {"name": "الزلزلة", "page": 598},
    {"name": "العاديات", "page": 598},
    {"name": "القارعة", "page": 599},
    {"name": "التكاثر", "page": 599},
    {"name": "العصر", "page": 600},
    {"name": "الهمزة", "page": 600},
    {"name": "الفيل", "page": 600},
    {"name": "قريش", "page": 601},
    {"name": "الماعون", "page": 601},
    {"name": "الكوثر", "page": 601},
    {"name": "الكافرون", "page": 602},
    {"name": "النصر", "page": 602},
    {"name": "المسد", "page": 602},
    {"name": "الإخلاص", "page": 603},
    {"name": "الفلق", "page": 603},
    {"name": "الناس", "page": 603}
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
                    onTap: () => _navigateToPage(context, surah['page']),
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
                           onTap: () => _navigateToPage(context, surah['page']),
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
