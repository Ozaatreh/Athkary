// lib/screens/quran_page_screen.dart
import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:athkary/pages/quranv2/app_theme.dart';
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
    _pageController = PageController(initialPage: provider.currentPage - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final gold = isDark ? AppTheme.goldPrimary : AppTheme.goldDark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: _buildAppBar(context, provider, isDark, gold),
      body: Stack(
        children: [
          _buildPageView(provider, isDark, gold),
          if (provider.isPageLoading) _buildLoadingOverlay(),
          _buildAudioBar(context, provider, isDark, gold),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, AppProvider provider, bool isDark, Color gold) {
    final surahName = provider.currentPageAyahs.isNotEmpty
        ? provider.currentPageAyahs.first.surahName ?? ''
        : '';

    return AppBar(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: gold),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        children: [
          Text(
            surahName,
            style: GoogleFonts.amiri(fontSize: 18, color: gold, fontWeight: FontWeight.bold),
          ),
          Text(
            'الصفحة ${provider.currentPage}',
            style: GoogleFonts.cormorantGaramond(fontSize: 12, color: gold.withOpacity(0.7), letterSpacing: 1),
          ),
        ],
      ),
      actions: [
        // Bookmark icon
        IconButton(
          icon: Icon(
            provider.isPageBookmarked(provider.currentPage)
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            color: gold,
          ),
          onPressed: () {
            provider.bookmarkCurrentPage();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم حفظ الصفحة ${provider.currentPage}', style: GoogleFonts.amiri()),
                backgroundColor: AppTheme.emeraldGreen,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        ),
        // Scroll direction toggle
        IconButton(
          icon: Icon(_isHorizontal ? Icons.swap_vert_rounded : Icons.swap_horiz_rounded, color: gold),
          onPressed: () => setState(() => _isHorizontal = !_isHorizontal),
          tooltip: 'تغيير اتجاه التمرير',
        ),
        // Settings
        IconButton(
          icon: Icon(Icons.settings_rounded, color: gold),
          onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => const SettingsScreen(),
          ),
        ),
        // Theme toggle
        IconButton(
          icon: Icon(provider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: gold),
          onPressed: provider.toggleTheme,
        ),
      ],
    );
  }

  Widget _buildPageView(AppProvider provider, bool isDark, Color gold) {
    return GestureDetector(
      onHorizontalDragEnd: _isHorizontal
          ? (details) {
              if (details.primaryVelocity! < -500) provider.goToNextPage();
              if (details.primaryVelocity! > 500) provider.goToPreviousPage();
            }
          : null,
      onVerticalDragEnd: !_isHorizontal
          ? (details) {
              if (details.primaryVelocity! < -500) provider.goToNextPage();
              if (details.primaryVelocity! > 500) provider.goToPreviousPage();
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: isDark
                ? const AssetImage('assets/dark_pattern.png')
                : const AssetImage('assets/light_pattern.png'),
            fit: BoxFit.cover,
            opacity: 0.03,
          ),
        ),
        child: _buildPageContent(provider, isDark, gold),
      ),
    );
  }

  Widget _buildPageContent(AppProvider provider, bool isDark, Color gold) {
    if (provider.currentPageAyahs.isEmpty && !provider.isPageLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: gold, size: 48),
            const SizedBox(height: 16),
            Text(
              provider.error ?? 'لم يتم تحميل البيانات',
              style: GoogleFonts.amiri(color: gold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => provider.loadPage(provider.currentPage),
              child: Text('إعادة المحاولة', style: GoogleFonts.amiri()),
            ),
          ],
        ),
      );
    }

    // Group ayahs
    final ayahs = provider.currentPageAyahs;
    final ayahsPerPage = provider.ayahsPerPage;

    return Column(
      children: [
        // Page header ornament
        _buildPageOrnament(provider.currentPage, gold, isDark),
        // Ayahs content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            child: Column(
              children: [
                // Bismillah if start of surah
                if (ayahs.isNotEmpty && ayahs.first.numberInSurah == 1 && ayahs.first.surahNumber != 9)
                  _buildBismillah(gold),
                // Ayahs as flowing text with selectable spans
                _buildAyahsText(ayahs, provider, isDark, gold),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageOrnament(int page, Color gold, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ornamentLine(gold),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: gold.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$page',
              style: GoogleFonts.cormorantGaramond(color: gold, fontSize: 13, letterSpacing: 1),
            ),
          ),
          const SizedBox(width: 12),
          _ornamentLine(gold),
        ],
      ),
    );
  }

  Widget _ornamentLine(Color gold) {
    return Row(
      children: [
        Container(width: 40, height: 1, color: gold.withOpacity(0.3)),
        const SizedBox(width: 4),
        Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: gold.withOpacity(0.5))),
        const SizedBox(width: 4),
        Container(width: 20, height: 1, color: gold.withOpacity(0.3)),
      ],
    );
  }

  Widget _buildBismillah(Color gold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
            style: GoogleFonts.amiri(
              fontSize: 22,
              color: gold,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: gold.withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _buildAyahsText(List ayahs, AppProvider provider, bool isDark, Color gold) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: ayahs.asMap().entries.map((entry) {
          final index = entry.key;
          final ayah = entry.value;
          final isHighlighted = provider.currentAyahIndex == index;
          final isSelected = provider.selectedAyahs.contains(index);

          return AyahWidget(
            ayah: ayah,
            index: index,
            isHighlighted: isHighlighted,
            isSelected: isSelected,
            fontSize: provider.ayahFontSize,
            isDark: isDark,
            gold: gold,
            onTap: () => provider.toggleAyahSelection(index),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black26,
      child: const Center(child: CircularProgressIndicator(color: AppTheme.goldPrimary)),
    );
  }

  Widget _buildAudioBar(BuildContext context, AppProvider provider, bool isDark, Color gold) {
    final hasSelection = provider.selectedAyahs.isNotEmpty;
    
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: (isDark ? AppTheme.darkSurface : AppTheme.lightSurface).withOpacity(0.95),
          border: Border(top: BorderSide(color: gold.withOpacity(0.2))),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, -4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous page
            _navButton(Icons.skip_previous_rounded, provider.goToPreviousPage, gold),
            // Selection info
            if (hasSelection)
              TextButton.icon(
                onPressed: provider.clearSelection,
                icon: Icon(Icons.close_rounded, size: 16, color: gold.withOpacity(0.7)),
                label: Text(
                  '${provider.selectedAyahs.length} آيات',
                  style: GoogleFonts.amiri(color: gold),
                ),
              ),
            // Play/Stop button
            GestureDetector(
              onTap: provider.playSelectedOrAll,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: provider.isPlaying
                        ? [AppTheme.emeraldGreen, AppTheme.emeraldGreen.withOpacity(0.7)]
                        : [gold, gold.withOpacity(0.7)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (provider.isPlaying ? AppTheme.emeraldGreen : gold).withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  provider.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                  color: isDark ? AppTheme.darkBg : Colors.white,
                  size: 32,
                ),
              ),
            ),
            // Next page
            _navButton(Icons.skip_next_rounded, provider.goToNextPage, gold),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap, Color gold) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: gold.withOpacity(0.3)),
        ),
        child: Icon(icon, color: gold, size: 22),
      ),
    );
  }
}
