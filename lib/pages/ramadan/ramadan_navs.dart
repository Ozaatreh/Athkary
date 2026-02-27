import 'dart:ui';
import 'package:athkary/pages/ramadan/laylat_alqader_navs.dart';
import 'package:athkary/pages/ramadan/ramadan_duaa.dart';
import 'package:athkary/pages/ramadan/ramadan_health.dart';
import 'package:athkary/pages/ramadan/ramadan_pdf_viewr.dart';
import 'package:athkary/pages/ramadan/ramdan_quran_ketmah.dart';
import 'package:athkary/pages/ramadan/ramdan_sonan.dart';
import 'package:athkary/services/ramadan_pdf_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RamadanNavs extends StatefulWidget {
  const RamadanNavs({super.key});

  @override
  State<RamadanNavs> createState() => _RamadanNavsState();
}

class _RamadanNavsState extends State<RamadanNavs>
    with TickerProviderStateMixin {
  bool _isPreparingPdfs = true;
  String? _pdfError;
  Map<String, String> _pdfPaths = {};
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
          ..forward();
    _prepareRamadanPdfs();
  }

  Future<void> _prepareRamadanPdfs() async {
    try {
      final map = await RamadanPdfService.prefetchAll();
      if (!mounted) return;
      setState(() {
        _pdfPaths = map;
        _isPreparingPdfs = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pdfError = e.toString();
        _isPreparingPdfs = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [

                /// ===== HEADER =====
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "رمضان",
                    style: GoogleFonts.amiri(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                /// ===== STATUS BOX =====
                _buildStatusBox(),

                const SizedBox(height: 24),

                /// ===== MENU SECTION =====
                _buildSectionTitle("الأقسام"),

                _buildMenuCard("سنن رمضانية", Icons.menu_book_rounded,
                    RamadanSunnahsPage()),
                _buildMenuCard("كيفية ختم القرآن",
                    Icons.auto_stories_rounded, QuranCompletionMethodsScreen()),
                _buildMenuCard(
                    "رمضان والصحة", Icons.health_and_safety_rounded,
                    RamadanHealthBenefits()),
                _buildMenuCard(
                    "أدعية رمضان", Icons.favorite_rounded, RamadanDuaa()),
                _buildMenuCard(
                    "ليلة القدر", Icons.nights_stay_rounded,
                    const LaylatAlQadrNav()),

                const SizedBox(height: 24),

                /// ===== PDF SECTION =====
                _buildSectionTitle("ملفات PDF"),

                _buildPdfCard("100 دعاء", "100duaa.pdf"),
                _buildPdfCard("جوامع الدعاء", "jawame_alduaa.pdf"),
                _buildPdfCard("ليلة القدر", "layllat_alqader.pdf"),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.amiri(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatusBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Lottie.asset(
            'assets/animations/wired-flat-1821-night-sky-moon-stars-hover-pinch.json',
            width: 60,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _isPreparingPdfs
                  ? "جاري تجهيز الملفات..."
                  : (_pdfError != null
                      ? "حدث خطأ أثناء التحميل"
                      : "تم تجهيز الملفات بنجاح"),
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (_isPreparingPdfs)
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Widget page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 16, color: Colors.white70),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }

  Widget _buildPdfCard(String title, String fileName) {
    final localPath = _pdfPaths[fileName];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf_rounded,
            color: Colors.redAccent),
        title: Text(
          title,
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          localPath != null ? "جاهز للقراءة" : "جاري التحميل...",
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: localPath == null
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.open_in_new_rounded,
                color: Colors.white70),
        onTap: localPath == null
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RamadanPdfViewer(title: title, localPath: localPath),
                  ),
                ),
      ),
    );
  }
}