import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:athkary/pages/quranv2/ayah_widget.dart';
import 'package:athkary/pages/quranv2/quran_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class QuranPagev2 extends StatefulWidget {
  const QuranPagev2({super.key});

  @override
  State<QuranPagev2> createState() => _QuranPagev2State();
}

class _QuranPagev2State extends State<QuranPagev2> {
  late PageController _pageController;
  bool _isHorizontal = true;

  @override
  void initState() {
    super.initState();
    final provider = context.read<AppProvider>();
    _pageController = PageController(
      initialPage: provider.currentPage - 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final gold = Theme.of(context).colorScheme.secondary;

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
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(context, provider, gold),
                    Expanded(child: _buildPageContent(provider, gold)),
                  ],
                ),
                if (provider.isPageLoading) _buildLoadingOverlay(),
                _buildAudioBar(context, provider, gold),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(BuildContext context, AppProvider provider, Color gold) {
    final surahName = provider.currentPageAyahs.isNotEmpty
        ? provider.currentPageAyahs.first.surahName ?? ''
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            child: Column(
              children: [
                Text(
                  surahName,
                  style: GoogleFonts.amiri(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "الصفحة ${provider.currentPage}",
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              provider.isPageBookmarked(provider.currentPage)
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: gold,
            ),
            onPressed: () {
              final alreadySaved =
                  provider.isPageBookmarked(provider.currentPage);

              provider.bookmarkCurrentPage();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    alreadySaved
                        ? "تم إزالة الصفحة من المفضلة"
                        : "تم حفظ الصفحة في المفضلة",
                    style: GoogleFonts.amiri(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => const SettingsScreen(),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PAGE CONTENT =================

  Widget _buildPageContent(AppProvider provider, Color gold) {
    if (provider.currentPageAyahs.isEmpty && !provider.isPageLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: gold, size: 48),
            const SizedBox(height: 16),
            Text(
              provider.error ?? 'لم يتم تحميل البيانات',
              style: GoogleFonts.amiri(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
              ),
              onPressed: () => provider.loadPage(provider.currentPage),
              child: Text(
                'إعادة المحاولة',
                style: GoogleFonts.amiri(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

   final allAyahs = provider.currentPageAyahs;
   final ayahs = allAyahs.take(provider.ayahsPerPage).toList();

    return Column(
      children: [
        _buildPageOrnament(provider.currentPage, gold),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
            child: Column(
              children: [
                if (ayahs.isNotEmpty &&
                    ayahs.first.numberInSurah == 1 &&
                    ayahs.first.surahNumber != 9)
                  _buildBismillah(),
                _buildAyahsText(ayahs, provider),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageOrnament(int page, Color gold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 40, height: 1, color: gold.withOpacity(0.3)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: gold.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$page',
              style: GoogleFonts.cormorantGaramond(
                color: gold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(width: 40, height: 1, color: gold.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _buildBismillah() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
        textAlign: TextAlign.center,
        style: GoogleFonts.amiri(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAyahsText(List ayahs, AppProvider provider) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: ayahs.asMap().entries.map((entry) {
          final index = entry.key;
          final ayah = entry.value;

          return AyahWidget(
            ayah: ayah,
            index: index,
            isHighlighted: provider.currentAyahIndex == index,
            isSelected: provider.selectedAyahs.contains(index),
            fontSize: provider.ayahFontSize,
            // isDark: true,
            gold: Colors.white,
            onTap: () => provider.toggleAyahSelection(index),
          );
        }).toList(),
      ),
    );
  }

  // ================= LOADING =================

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  // ================= AUDIO BAR =================

  Widget _buildAudioBar(
      BuildContext context, AppProvider provider, Color gold) {
    final hasSelection = provider.selectedAyahs.isNotEmpty;

    return Positioned(
      bottom: 0,
      left: 16,
      right: 16,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white.withOpacity(0.08),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navButton(Icons.skip_previous_rounded, provider.goToPreviousPage),
            if (hasSelection)
              Text(
                "${provider.selectedAyahs.length} آيات",
                style: GoogleFonts.amiri(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            GestureDetector(
              onTap: provider.playSelectedOrAll,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: gold,
                ),
                child: Icon(
                  provider.isPlaying
                      ? Icons.stop_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            _navButton(Icons.skip_next_rounded, provider.goToNextPage),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
