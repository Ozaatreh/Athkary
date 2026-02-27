// lib/screens/home_screen.dart
import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:athkary/pages/quranv2/app_theme.dart';
import 'package:athkary/pages/quranv2/quran_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bookmarks_screen.dart';


class Quranv2hc extends StatefulWidget {
  const Quranv2hc({super.key});

  @override
  State<Quranv2hc> createState() => _Quranv2hcState();
}

class _Quranv2hcState extends State<Quranv2hc> {
  int? _expandedJuz;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final gold = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [Theme.of(context).colorScheme.surface, const Color(0xFF0A1628), Theme.of(context).colorScheme.surface]
                : [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context, provider, gold, isDark),
            if (provider.isLoading)
              const SliverFillRemaining(
                child: Center(child: _IslamicLoader()),
              )
            else ...[
              _buildLastReadBanner(context, provider, isDark, gold),
            
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: _buildJuzList(context, provider, isDark, gold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AppProvider provider, Color gold, bool isDark) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: isDark ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.secondary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF1A2744), const Color(0xFF0D1117)]
                  : [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.surface],
            ),
          ),
          child: Stack(
            children: [
              // Decorative pattern
              Positioned.fill(
                child: CustomPaint(painter: _IslamicPatternPainter(gold.withOpacity(0.05))),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '﷽',
                      style: GoogleFonts.amiri(
                        fontSize: 25,
                        color: gold,
                        height: 1.8,
                      ),
                    ),
                    Text(
                      'القرآن الكريم',
                      style: GoogleFonts.amiri(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: gold,
                      ),
                    ),
                    Text(
                      'Holy Quran',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 14,
                        color: gold.withOpacity(0.7),
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.access_time_rounded, color: gold),
        //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerTimesScreen())),
        //   tooltip: 'أوقات الصلاة',
        // ),
        IconButton(
          icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: gold),
          onPressed: provider.toggleTheme,
          tooltip: 'تبديل المظهر',
        ),
        IconButton(
          icon: Icon(Icons.bookmark_rounded, color: gold),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookmarksScreen())),
          tooltip: 'المفضلة',
        ),
      ],
    );
  }



  Widget _buildLastReadBanner(BuildContext context, AppProvider provider, bool isDark, Color gold) {
    if (provider.currentPage == 1 && provider.bookmarks.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuranPagev2())),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                 colors: [const Color(0xFF2E7D32).withOpacity(0.3), const Color(0xFF2E7D32).withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_stories_rounded, color: const Color(0xFF81C784), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'آخر قراءة',
                        style: GoogleFonts.amiri(
                          color: const Color(0xFF81C784),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'الصفحة ${provider.currentPage}',
                        style: GoogleFonts.amiri(
                          color: Colors.white ,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF81C784), size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJuzList(BuildContext context, AppProvider provider, bool isDark, Color gold) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final juzNumber = index + 1;
          final surahs = provider.juzSurahMap[juzNumber] ?? [];
          final isExpanded = _expandedJuz == juzNumber;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildJuzCard(context, provider, juzNumber, surahs, isExpanded, isDark, gold),
          );
        },
        childCount: 30,
      ),
    );
  }

  Widget _buildJuzCard(BuildContext context, AppProvider provider, int juzNumber, List surahs, bool isExpanded, bool isDark, Color gold) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.secondary.withOpacity(0.35) : Theme.of(context).colorScheme.secondary.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? gold.withOpacity(0.5) : Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: isExpanded ? 1.5 : 1,
        ),
        boxShadow: isExpanded
            ? [BoxShadow(color: gold.withOpacity(0.1), blurRadius: 12, spreadRadius: 2)]
            : [],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _expandedJuz = isExpanded ? null : juzNumber),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [gold, gold.withOpacity(0.6)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$juzNumber',
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Theme.of(context).primaryColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الجزء $juzNumber',
                          style: GoogleFonts.amiri(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: gold,
                          ),
                        ),
                        Text(
                          'Juz $juzNumber • ${surahs.length} سور',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.expand_more_rounded, color: gold),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded && surahs.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: isDark ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: surahs.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: isDark ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary,
                  indent: 16,
                  endIndent: 16,
                ),
                itemBuilder: (context, i) {
                  final surah = surahs[i];
                  return ListTile(
                    onTap: () async {
                    if (isExpanded) {
                      setState(() => _expandedJuz = null);
                    } else {
                      await provider.navigateToJuz(juzNumber);
                  
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const QuranPagev2()),
                        );
                      }
                    }
                  },
                    leading: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: gold.withOpacity(0.4)),
                      ),
                      child: Center(
                        child: Text(
                          '${surah.number}',
                          style: TextStyle(fontSize: 11, color: gold),
                        ),
                      ),
                    ),
                    title: Text(
                      surah.name,
                      style: GoogleFonts.amiri(
                        fontSize: 18,
                        color: isDark ? const Color(0xFFE6D5A7) : Theme.of(context).colorScheme.primary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    subtitle: Text(
                      '${surah.englishName} • ${surah.numberOfAyahs} آية',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 12,
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(Icons.arrow_back_ios_rounded, color: gold.withOpacity(0.5), size: 14),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _IslamicLoader extends StatefulWidget {
  const _IslamicLoader();

  @override
  State<_IslamicLoader> createState() => _IslamicLoaderState();
}

class _IslamicLoaderState extends State<_IslamicLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotationTransition(
          turns: _controller,
          child:  Icon(Icons.star_rounded, color: Theme.of(context).colorScheme.primary , size: 48),
        ),
        const SizedBox(height: 16),
        Text(
          'جاري التحميل...',
          style: GoogleFonts.amiri(color: Theme.of(context).colorScheme.primary, fontSize: 18),
        ),
      ],
    );
  }
}

class _IslamicPatternPainter extends CustomPainter {
  final Color color;
  _IslamicPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 1..style = PaintingStyle.stroke;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 2, paint..style = PaintingStyle.fill);
        canvas.drawCircle(Offset(x + spacing / 2, y + spacing / 2), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
