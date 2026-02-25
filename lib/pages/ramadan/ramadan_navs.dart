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

class _RamadanNavsState extends State<RamadanNavs> {
  bool _isPreparingPdfs = true;
  String? _pdfError;
  Map<String, String> _pdfPaths = {};

  @override
  void initState() {
    super.initState();
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
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'رمضان',
            style: GoogleFonts.amiri(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.12),
                    theme.colorScheme.primary.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.25),
                ),
              ),
              child: Row(
                children: [
                  Lottie.asset(
                    'assets/animations/wired-flat-1821-night-sky-moon-stars-hover-pinch.json',
                    width: 72,
                    height: 72,
                    repeat: true,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _isPreparingPdfs
                          ? 'جاري تجهيز ملفات رمضان للقراءة دون انتظار...'
                          : (_pdfError != null
                              ? 'تعذر تنزيل بعض الملفات: $_pdfError'
                              : 'تم تجهيز ملفات رمضان بنجاح.'),
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (_isPreparingPdfs)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _menuCard(context, 'سنن رمضانية', Icons.menu_book_rounded,
                RamadanSunnahsPage()),
            _menuCard(context, 'كيفية ختم القرآن', Icons.auto_stories_rounded,
                QuranCompletionMethodsScreen()),
            _menuCard(context, 'رمضان والصحة', Icons.health_and_safety_rounded,
                RamadanHealthBenefits()),
            _menuCard(context, 'أدعية رمضان', Icons.favorite_rounded,
                RamadanDuaa()),
            _menuCard(context, 'ليلة القدر', Icons.nights_stay_rounded,
                const LaylatAlQadrNav()),
            const SizedBox(height: 8),
            Text(
              'ملفات PDF من Supabase',
              style: GoogleFonts.amiri(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            _pdfCard(context, '100 دعاء', '100duaa.pdf'),
            _pdfCard(context, 'جوامع الدعاء', 'jawame_alduaa.pdf'),
            _pdfCard(context, 'ليلة القدر', 'layllat_alqader.pdf'),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, String title, IconData icon, Widget page) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primary,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.inversePrimary),
        title: Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: theme.colorScheme.inversePrimary, size: 16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }

  Widget _pdfCard(BuildContext context, String title, String fileName) {
    final theme = Theme.of(context);
    final localPath = _pdfPaths[fileName];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
          child: Icon(Icons.picture_as_pdf_rounded, color: theme.colorScheme.primary),
        ),
        title: Text(
          title,
          style: GoogleFonts.tajawal(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(localPath != null ? 'جاهز للقراءة' : 'جاري التحميل...'),
        trailing: localPath == null
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.open_in_new_rounded),
        onTap: localPath == null
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RamadanPdfViewer(
                      title: title,
                      localPath: localPath,
                    ),
                  ),
                ),
      ),
    );
  }
}