// lib/screens/settings_screen.dart

import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:athkary/pages/quranv2/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final gold = isDark ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.inversePrimary;
    final bgColor = isDark ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onPrimary;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: gold.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: gold.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'الإعدادات',
              style: GoogleFonts.amiri(fontSize: 22, color: gold, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Font size
                  Text(
                    'حجم الخط',
                    style: GoogleFonts.amiri(fontSize: 16, color: gold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.text_fields_rounded, color: gold.withOpacity(0.5), size: 18),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: gold,
                            thumbColor: gold,
                            inactiveTrackColor: gold.withOpacity(0.2),
                            overlayColor: gold.withOpacity(0.1),
                          ),
                          child: Slider(
                            value: provider.ayahFontSize,
                            min: 16,
                            max: 36,
                            divisions: 10,
                            label: '${provider.ayahFontSize.toInt()}',
                            onChanged: provider.updateFontSize,
                          ),
                        ),
                      ),
                      Icon(Icons.text_fields_rounded, color: gold, size: 28),
                    ],
                  ),
                  // Preview
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: gold.withOpacity(0.2)),
                    ),
                    child: Text(
                      'قُلْ هُوَ ٱللَّهُ أَحَدٌ ﴿١﴾',
                      style: GoogleFonts.amiri(
                        fontSize: provider.ayahFontSize,
                        color: isDark ? const Color(0xFFEAE0C8) : const Color(0xFF2C1810),
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Ayahs per page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عدد الآيات في الصفحة',
                        style: GoogleFonts.amiri(fontSize: 16, color: gold),
                      ),
                      Text(
                        '${provider.ayahsPerPage}',
                        style: GoogleFonts.cormorantGaramond(fontSize: 18, color: gold, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: gold,
                      thumbColor: gold,
                      inactiveTrackColor: gold.withOpacity(0.2),
                      overlayColor: gold.withOpacity(0.1),
                    ),
                    child: Slider(
                      value: provider.ayahsPerPage.toDouble(),
                      min: 5,
                      max: 30,
                      divisions: 25,
                      label: '${provider.ayahsPerPage}',
                      onChanged: (v) => provider.updateAyahsPerPage(v.toInt()),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Theme toggle
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: gold.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded, color: gold),
                            const SizedBox(width: 12),
                            Text(
                              isDark ? 'المظهر الداكن' : 'المظهر الفاتح',
                              style: GoogleFonts.amiri(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
                            ),
                          ],
                        ),
                        Switch(
                          value: isDark,
                          onChanged: (_) => provider.toggleTheme(),
                          activeColor: gold,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
