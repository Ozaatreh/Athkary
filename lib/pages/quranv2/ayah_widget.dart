// lib/widgets/ayah_widget.dart
import 'package:athkary/pages/quranv2/app_theme.dart';
import 'package:athkary/pages/quranv2/quran_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AyahWidget extends StatelessWidget {
  final Ayah ayah;
  final int index;
  final bool isHighlighted;
  final bool isSelected;
  final double fontSize;
  final bool isDark;
  final Color gold;
  final VoidCallback onTap;

  const AyahWidget({
    super.key,
    required this.ayah,
    required this.index,
    required this.isHighlighted,
    required this.isSelected,
    required this.fontSize,
    required this.isDark,
    required this.gold,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;
    if (isHighlighted) {
      bgColor = const Color(0xFF66BB6A).withOpacity(0.25);
    } else if (isSelected) {
      bgColor = gold.withOpacity(0.15);
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: gold.withOpacity(0.4), width: 1)
              : isHighlighted
                   ? Border.all(color: const Color(0xFF66BB6A).withOpacity(0.6), width: 1)
                  : null,
        ),
        child: RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            children: [
              TextSpan(
                text: ayah.text,
                style: GoogleFonts.amiri(
                  fontSize: fontSize,
                  color: isHighlighted
                      ? const Color(0xFF81C784)
                      : isDark
                          ? const Color(0xFFEAE0C8)
                          : const Color(0xFF2C1810),
                  height: 2.0,
                ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _AyahNumberBadge(number: ayah.numberInSurah, gold: gold, isDark: isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AyahNumberBadge extends StatelessWidget {
  final int number;
  final Color gold;
  final bool isDark;

  const _AyahNumberBadge({required this.number, required this.gold, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: gold.withOpacity(0.5), width: 1),
      ),
      child: Center(
        child: Text(
          _toArabicNumber(number),
          style: TextStyle(
            fontSize: 10,
            color: gold,
            fontFamily: 'Amiri',
          ),
        ),
      ),
    );
  }

  String _toArabicNumber(int n) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return n.toString().split('').map((d) => arabicDigits[int.parse(d)]).join();
  }
}
