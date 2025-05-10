import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkPdfViewerScreen extends StatefulWidget {
  final String pdfPath;
  final int startPage;

  const BookmarkPdfViewerScreen({
    Key? key,
    required this.pdfPath,
    this.startPage = 1,
  }) : super(key: key);

  @override
  _BookmarkPdfViewerScreenState createState() => _BookmarkPdfViewerScreenState();
}

class _BookmarkPdfViewerScreenState extends State<BookmarkPdfViewerScreen> {
  late PDFViewController _pdfViewController;
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String? localPath;
  bool isNightMode = false;
  bool isReloading = false;
  bool isHorizontalScroll = true;
  final TextEditingController _pageController = TextEditingController();
  bool _isFabVisible = true;
  Timer? _fabTimer;

   @override
  void initState() {
    super.initState();
    currentPage = widget.startPage - 1; // Initialize currentPage to the startPage
    loadPdf();
    _loadSettings();
  }
  void _startFabTimer() {
    _fabTimer?.cancel();
    setState(() => _isFabVisible = true);
    _fabTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _isFabVisible = false);
    });
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isNightMode = prefs.getBool('isNightMode') ?? false;
      isHorizontalScroll = prefs.getBool('isHorizontalScroll') ?? true;
    });
  }

  @override
  void dispose() {
    _fabTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadPdf() async {
    setState(() => isReloading = true);
    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/Quraan_v0.pdf';
    final file = File(tempFilePath);

    if (!await file.exists()) {
      final bytes = await rootBundle.load(widget.pdfPath);
      await file.writeAsBytes(bytes.buffer.asUint8List());
    }

    setState(() {
      localPath = tempFilePath;
      isReloading = false;
    });
    _pdfViewController.setPage(currentPage);
  }

  void toggleNightMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isNightMode = !isNightMode;
      localPath = null;
    });
    await prefs.setBool('isNightMode', isNightMode);
    loadPdf();
  }

  void toggleScrollDirection() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isHorizontalScroll = !isHorizontalScroll);
    await prefs.setBool('isHorizontalScroll', isHorizontalScroll);
  }

  void goToPage(String pageNumber) {
    final page = int.tryParse(pageNumber);
    if (page != null && page >= 1 && page <= pages) {
      _pdfViewController.setPage(page - 1);
      setState(() => currentPage = page - 1);
      _startFabTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' (1-$pages) رقم صفحه خاطئ'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
        ),
      ),);
    }
  }

Future<void> _saveBookmark() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('savedBookmarkPage', currentPage);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text('تم حفظ الصفحه ${currentPage + 1}'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
  );
  _startFabTimer();
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isNightMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, 
              color: isNightMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'القرآن الكريم',
          style: TextStyle(
            color: isNightMode ? Colors.white : Colors.black,
            fontSize: 15,
            fontFamily: 'Amiri',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isHorizontalScroll ? Icons.swipe_vertical : Icons.swipe_left,
              color: isNightMode ? Colors.white : Colors.black,
            ),
            onPressed: toggleScrollDirection,
          ),
          Container(
            width: 60,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _pageController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 13,
                color: isNightMode ? Colors.black : Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: isNightMode ? Colors.black : Colors.white,
                ),
                hintText: 'الصفحة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isNightMode 
                    ? const Color.fromARGB(255, 201, 200, 200) 
                    : const Color.fromARGB(255, 157, 157, 157),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
              onSubmitted: goToPage,
            ),
          ),
          IconButton(
            color: isNightMode ? Colors.white : Colors.black,
            icon: isNightMode
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
            onPressed: toggleNightMode,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _startFabTimer,
        child: Stack(
          children: [
            if (isReloading)
              const Center(child: CircularProgressIndicator())
            else if (localPath != null)
              PDFView(
                key: ValueKey('pdfview_${isNightMode}_${isHorizontalScroll}'),
                filePath: localPath,
                defaultPage: currentPage,
                swipeHorizontal: isHorizontalScroll,
                nightMode: isNightMode,
                autoSpacing: true,
                pageSnap: true,
                fitEachPage: true,
                onRender: (pages) => setState(() {
                  this.pages = pages!;
                  isReady = true;
                }),
                onViewCreated: (controller) {
                  _pdfViewController = controller;
                  // _pdfViewController.setPage(currentPage);
                },
                onPageChanged: (page, total) async {
                setState(() {
                  currentPage = page!;
                  _pageController.text = (page + 1).toString();
                });
                _startFabTimer();
              },
                onError: (error) => print(error.toString()),
              ),
            Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  _saveBookmark();
                  _startFabTimer();
                },
                child: AnimatedOpacity(
                  opacity: _isFabVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: FloatingActionButton(
                    heroTag: 'bookmark_fab',
                    child: const Icon(Icons.bookmark_add),
                    onPressed: () {
                      _saveBookmark();
                      _startFabTimer();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 72, left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              opacity: _isFabVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: 'prev_fab',
                mini: true,
                child: const Icon(Icons.chevron_left),
                onPressed: currentPage > 0
                    ? () {
                        _pdfViewController.setPage(currentPage - 1);
                        _startFabTimer();
                      }
                    : null,
              ),
            ),
            const SizedBox(width: 20),
            AnimatedOpacity(
              opacity: _isFabVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: 'next_fab',
                mini: true,
                child: const Icon(Icons.chevron_right),
                onPressed: currentPage < pages - 1
                    ? () {
                        _pdfViewController.setPage(currentPage + 1);
                        _startFabTimer();
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}