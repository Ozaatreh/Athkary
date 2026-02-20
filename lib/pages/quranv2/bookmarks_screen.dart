// lib/screens/bookmarks_screen.dart
import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:athkary/pages/quranv2/app_theme.dart';
import 'package:athkary/pages/quranv2/quran_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
  

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final gold = isDark ? AppTheme.goldPrimary : AppTheme.goldDark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: gold),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'المفضلة',
          style: GoogleFonts.amiri(fontSize: 22, color: gold, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: provider.bookmarks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border_rounded, color: gold.withOpacity(0.3), size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد صفحات محفوظة',
                    style: GoogleFonts.amiri(color: gold.withOpacity(0.5), fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = provider.bookmarks[index];
                return Dismissible(
                  key: Key('bookmark_${bookmark.pageNumber}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.delete_rounded, color: Colors.red),
                  ),
                  onDismissed: (_) => provider.removeBookmark(bookmark.pageNumber),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [gold, gold.withOpacity(0.6)]),
                        ),
                        child: Center(
                          child: Text(
                            '${bookmark.pageNumber}',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppTheme.darkBg : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        bookmark.surahName,
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          color: isDark ? const Color(0xFFE6D5A7) : const Color(0xFF2C1810),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      subtitle: Text(
                        'الصفحة ${bookmark.pageNumber}',
                        style: GoogleFonts.cormorantGaramond(
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, color: gold.withOpacity(0.5), size: 14),
                      onTap: () async {
                        await provider.loadPage(bookmark.pageNumber);
                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const QuranPagev2()));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
