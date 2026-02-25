import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranViewerScreen extends StatefulWidget {
  final String pdfPath;
  final int startPage;

  const QuranViewerScreen({
    Key? key,
    required this.pdfPath,
    this.startPage = 1,
  }) : super(key: key);

  @override
  _QuranViewerScreenState createState() => _QuranViewerScreenState();
}

class _QuranViewerScreenState extends State<QuranViewerScreen> {
  PDFViewController? _pdfViewController;

  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  bool isNightMode = false;
  bool isHorizontalScroll = true;

  final TextEditingController _pageController = TextEditingController();

  bool _isFabVisible = true;
  Timer? _fabTimer;

  @override
  void initState() {
    super.initState();
    currentPage = widget.startPage - 1;
    _pageController.text = widget.startPage.toString();
    _loadSettings();
    _startFabTimer();
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

  void toggleNightMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isNightMode = !isNightMode);
    await prefs.setBool('isNightMode', isNightMode);
  }

  void toggleScrollDirection() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isHorizontalScroll = !isHorizontalScroll);
    await prefs.setBool('isHorizontalScroll', isHorizontalScroll);
  }

  void goToPage(String pageNumber) {
    final page = int.tryParse(pageNumber);
    if (page != null && page >= 1 && page <= pages) {
      _pdfViewController?.setPage(page - 1);
      setState(() => currentPage = page - 1);
      _startFabTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid page (1-$pages)')),
      );
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

          /// ✅ RESTORED STYLED PAGE BOX
          Container(
            width: 60,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isNightMode ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isNightMode ? Colors.white24 : Colors.black12,
              ),
            ),
            child: TextField(
              controller: _pageController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: isNightMode ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'الصفحة',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 6),
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

      body: PDFView(
        key: ValueKey('pdf_${isNightMode}_${isHorizontalScroll}'),
        filePath: widget.pdfPath,
        defaultPage: currentPage,
        swipeHorizontal: isHorizontalScroll,
        nightMode: isNightMode,
        autoSpacing: true,
        pageSnap: true,
        fitEachPage: true,
        onRender: (pages) {
          setState(() {
            this.pages = pages!;
            isReady = true;
          });
        },
        onViewCreated: (controller) {
          _pdfViewController = controller;
          _pdfViewController!.setPage(currentPage);
        },
        onPageChanged: (page, total) async {
          setState(() {
            currentPage = page!;
            _pageController.text = (page + 1).toString();
          });

          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('lastPage', page!);

          _startFabTimer();
        },
      ),

      /// ✅ RESTORED SAVE BUTTON
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: _saveBookmark,
              child: const Icon(Icons.bookmark_rounded),
            )
          : null,
    );
  }
}