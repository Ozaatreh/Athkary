import 'package:athkary/pages/quranv2/quran_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AyahWidget extends StatelessWidget {
  final Ayah ayah;
  final int index;
  final bool isHighlighted;
  final bool isSelected;
  final double fontSize;
  final Color gold;
  final VoidCallback onTap;

  const AyahWidget({
    super.key,
    required this.ayah,
    required this.index,
    required this.isHighlighted,
    required this.isSelected,
    required this.fontSize,
    required this.gold,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;
    Color borderColor = Colors.transparent;

    if (isHighlighted) {
      bgColor = Colors.white.withOpacity(0.12);
      borderColor = gold.withOpacity(0.5);
    } else if (isSelected) {
      bgColor = gold.withOpacity(0.12);
      borderColor = gold.withOpacity(0.4);
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: borderColor == Colors.transparent
              ? null
              : Border.all(color: borderColor, width: 1),
        ),
        child: RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            children: [
              TextSpan(
                text: ayah.text,
                style: GoogleFonts.amiri(
                  fontSize: fontSize,
                  color: Colors.white.withOpacity(0.95),
                  height: 2.1,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6),
                  child: _AyahNumberBadge(
                    number: ayah.numberInSurah,
                    gold: gold,
                  ),
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

  const _AyahNumberBadge({
    required this.number,
    required this.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: gold.withOpacity(0.7),
          width: 1.2,
        ),
      ),
      child: Center(
        child: Text(
          _toArabicNumber(number),
          style: GoogleFonts.amiri(
            fontSize: 12,
            color: gold,
          ),
        ),
      ),
    );
  }

  String _toArabicNumber(int n) {
    const arabicDigits = [
      '٠', '١', '٢', '٣', '٤',
      '٥', '٦', '٧', '٨', '٩'
    ];
    return n
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join();
  }
}