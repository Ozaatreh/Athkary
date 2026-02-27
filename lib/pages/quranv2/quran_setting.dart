import 'package:athkary/pages/quranv2/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final gold = Theme.of(context).colorScheme.secondary;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B263B),
              Color(0xFF0D1B2A),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [

                const SizedBox(height: 14),

                /// Drag Indicator
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 20),

                /// Title
                Text(
                  "الإعدادات",
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                /// ===== FONT SIZE =====
                _sectionTitle("حجم الخط"),

                const SizedBox(height: 12),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: gold,
                    thumbColor: gold,
                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                    overlayColor: gold.withOpacity(0.15),
                  ),
                  child: Slider(
                    value: provider.ayahFontSize,
                    min: 16,
                    max: 36,
                    divisions: 10,
                    label: provider.ayahFontSize.toInt().toString(),
                    onChanged: provider.updateFontSize,
                  ),
                ),

                const SizedBox(height: 12),

                /// Preview
                _glassCard(
                  child: Text(
                    "قُلْ هُوَ ٱللَّهُ أَحَدٌ ﴿١﴾",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.amiri(
                      fontSize: provider.ayahFontSize,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                /// ===== AYAHS PER PAGE =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _sectionTitle("عدد الآيات في الصفحة"),
                    Text(
                      provider.ayahsPerPage.toString(),
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: gold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: gold,
                    thumbColor: gold,
                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                    overlayColor: gold.withOpacity(0.15),
                  ),
                  child: Slider(
                    value: provider.ayahsPerPage.toDouble(),
                    min: 5,
                    max: 30,
                    divisions: 25,
                    label: provider.ayahsPerPage.toString(),
                    onChanged: (v) => provider.updateAyahsPerPage(v.toInt()),
                  ),
                ),

                const SizedBox(height: 32),

                /// ===== THEME TOGGLE =====
                _glassCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            provider.isDarkMode
                                ? Icons.dark_mode_rounded
                                : Icons.light_mode_rounded,
                            color: gold,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            provider.isDarkMode
                                ? "المظهر الداكن"
                                : "المظهر الفاتح",
                            style: GoogleFonts.amiri(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: provider.isDarkMode,
                        onChanged: (_) => provider.toggleTheme(),
                        activeColor: Colors.white,
                        activeThumbColor: Colors.white,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: GoogleFonts.amiri(
          fontSize: 16,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: child,
    );
  }
}