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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    // Accent color (gold)
    final gold = colors.secondary;

    // Proper text color
    final textColor = colors.onSurface;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: _buildAppBar(context, provider, isDark, gold, textColor),
      body: Stack(
        children: [
          _buildPageView(provider, isDark, gold, textColor),
          if (provider.isPageLoading) _buildLoadingOverlay(),
          _buildAudioBar(context, provider, isDark, gold, textColor),
        ],
      ),
    );
  }

  AppBar _buildAppBar(
      BuildContext context,
      AppProvider provider,
      bool isDark,
      Color gold,
      Color textColor) {
    final surahName = provider.currentPageAyahs.isNotEmpty
        ? provider.currentPageAyahs.first.surahName ?? ''
        : '';

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: textColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        children: [
          Text(
            surahName,
            style: GoogleFonts.amiri(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'الصفحة ${provider.currentPage}',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 12,
              color: textColor.withOpacity(0.7),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            provider.isPageBookmarked(provider.currentPage)
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            color: textColor,
          ),
          onPressed: () {
            provider.bookmarkCurrentPage();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تم حفظ الصفحة ${provider.currentPage}',
                  style: GoogleFonts.amiri(),
                ),
                backgroundColor: gold,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(
            _isHorizontal
                ? Icons.swap_vert_rounded
                : Icons.swap_horiz_rounded,
            color: textColor,
          ),
          onPressed: () =>
              setState(() => _isHorizontal = !_isHorizontal),
          tooltip: 'تغيير اتجاه التمرير',
        ),
        IconButton(
          icon: Icon(Icons.settings_rounded, color: textColor),
          onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => const SettingsScreen(),
          ),
        ),
        IconButton(
          icon: Icon(
            provider.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            color: textColor,
          ),
          onPressed: provider.toggleTheme,
        ),
      ],
    );
  }

  Widget _buildPageView(
      AppProvider provider,
      bool isDark,
      Color gold,
      Color textColor) {
    return GestureDetector(
      onHorizontalDragEnd: _isHorizontal
          ? (details) {
              if (details.primaryVelocity! < -500)
                provider.goToNextPage();
              if (details.primaryVelocity! > 500)
                provider.goToPreviousPage();
            }
          : null,
      onVerticalDragEnd: !_isHorizontal
          ? (details) {
              if (details.primaryVelocity! < -500)
                provider.goToNextPage();
              if (details.primaryVelocity! > 500)
                provider.goToPreviousPage();
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
        child: _buildPageContent(provider, isDark, gold, textColor),
      ),
    );
  }

  Widget _buildPageContent(
      AppProvider provider,
      bool isDark,
      Color gold,
      Color textColor) {
    if (provider.currentPageAyahs.isEmpty &&
        !provider.isPageLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                color: gold, size: 48),
            const SizedBox(height: 16),
            Text(
              provider.error ?? 'لم يتم تحميل البيانات',
              style: GoogleFonts.amiri(
                  color: textColor, fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  provider.loadPage(provider.currentPage),
              child:
                  Text('إعادة المحاولة', style: GoogleFonts.amiri()),
            ),
          ],
        ),
      );
    }

    final ayahs = provider.currentPageAyahs;

    return Column(
      children: [
        _buildPageOrnament(provider.currentPage, gold),
        Expanded(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.fromLTRB(16, 0, 16, 100),
            child: Column(
              children: [
                if (ayahs.isNotEmpty &&
                    ayahs.first.numberInSurah == 1 &&
                    ayahs.first.surahNumber != 9)
                  _buildBismillah(textColor),
                _buildAyahsText(
                    ayahs, provider, isDark, textColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageOrnament(int page, Color gold) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ornamentLine(gold),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border:
                  Border.all(color: gold.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$page',
              style: GoogleFonts.cormorantGaramond(
                  color: gold, fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          _ornamentLine(gold),
        ],
      ),
    );
  }

  Widget _ornamentLine(Color gold) {
    return Container(
        width: 40,
        height: 1,
        color: gold.withOpacity(0.3));
  }

  Widget _buildBismillah(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
        style: GoogleFonts.amiri(
          fontSize: 19,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildAyahsText(
      List ayahs,
      AppProvider provider,
      bool isDark,
      Color textColor) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Wrap(
        alignment: WrapAlignment.center,
        children:
            ayahs.asMap().entries.map((entry) {
          final index = entry.key;
          final ayah = entry.value;

          return AyahWidget(
            ayah: ayah,
            index: index,
            isHighlighted:
                provider.currentAyahIndex == index,
            isSelected:
                provider.selectedAyahs.contains(index),
            fontSize: provider.ayahFontSize,
            isDark: isDark,
            gold: textColor,
            onTap: () =>
                provider.toggleAyahSelection(index),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black26,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildAudioBar(
      BuildContext context,
      AppProvider provider,
      bool isDark,
      Color gold,
      Color textColor) {
    final hasSelection =
        provider.selectedAyahs.isNotEmpty;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface
              .withOpacity(0.95),
          border: Border(
              top: BorderSide(
                  color: gold.withOpacity(0.2))),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            _navButton(Icons.skip_previous_rounded,
                provider.goToPreviousPage, textColor),
            if (hasSelection)
              TextButton.icon(
                onPressed: provider.clearSelection,
                icon: Icon(Icons.close_rounded,
                    size: 16,
                    color: textColor.withOpacity(0.7)),
                label: Text(
                  '${provider.selectedAyahs.length} آيات',
                  style: GoogleFonts.amiri(
                      color: textColor),
                ),
              ),
            GestureDetector(
              onTap: provider.playSelectedOrAll,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: gold,
                ),
                child: Icon(
                  provider.isPlaying
                      ? Icons.stop_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            _navButton(Icons.skip_next_rounded,
                provider.goToNextPage, textColor),
          ],
        ),
      ),
    );
  }

  Widget _navButton(
      IconData icon,
      VoidCallback onTap,
      Color textColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: textColor.withOpacity(0.3)),
        ),
        child: Icon(icon,
            color: textColor, size: 22),
      ),
    );
  }
}