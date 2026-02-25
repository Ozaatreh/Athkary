// lib/providers/app_provider.dart
import 'dart:convert';
import 'package:athkary/main.dart';
import 'package:athkary/pages/quranv2/quran_models.dart';
import 'package:athkary/pages/quranv2/quran_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';


class AppProvider extends ChangeNotifier {
  final QuranService _quranService = QuranService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Theme
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  // Settings
  double _ayahFontSize = 24.0;
  int _ayahsPerPage = 15;
  double get ayahFontSize => _ayahFontSize;
  int get ayahsPerPage => _ayahsPerPage;

  // Navigation
  int _currentPage = 1;
  int get currentPage => _currentPage;

  // Data
  List<Surah> _surahs = [];
  List<Surah> get surahs => _surahs;

  Map<int, List<Surah>> _juzSurahMap = {};
  Map<int, List<Surah>> get juzSurahMap => _juzSurahMap;

  List<Ayah> _currentPageAyahs = [];
  List<Ayah> get currentPageAyahs => _currentPageAyahs;

  // Audio
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  int _currentAyahIndex = -1;
  int get currentAyahIndex => _currentAyahIndex;
  Set<int> _selectedAyahs = {};
  Set<int> get selectedAyahs => _selectedAyahs;

  // Bookmarks
  List<BookmarkedPage> _bookmarks = [];
  List<BookmarkedPage> get bookmarks => _bookmarks;

  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPageLoading = false;
  bool get isPageLoading => _isPageLoading;

  String? _error;
  String? get error => _error;

  AppProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadPreferences();
    await _loadSurahs();
    _setupAudioListeners();
    await loadPage(_currentPage);
  }

  void _setupAudioListeners() {
    _audioPlayer.onPlayerComplete.listen((_) async {
      if (_currentAyahIndex < _currentPageAyahs.length - 1) {
        // Check if next ayah should be played
        if (_selectedAyahs.isEmpty ||
            _selectedAyahs.contains(_currentAyahIndex + 1)) {
          await _playAyahAtIndex(_currentAyahIndex + 1);
        } else {
          _isPlaying = false;
          _currentAyahIndex = -1;
          notifyListeners();
        }
      } else {
        _isPlaying = false;
        _currentAyahIndex = -1;
        notifyListeners();
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = themeNotifier.value == ThemeMode.dark;
    _ayahFontSize = prefs.getDouble('ayahFontSize') ?? 24.0;
    _ayahsPerPage = prefs.getInt('ayahsPerPage') ?? 15;
    _currentPage = prefs.getInt('lastPage') ?? 1;

    final bookmarksJson = prefs.getStringList('bookmarks') ?? [];
    _bookmarks = bookmarksJson
        .map((j) => BookmarkedPage.fromJson(json.decode(j)))
        .toList();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setDouble('ayahFontSize', _ayahFontSize);
    await prefs.setInt('ayahsPerPage', _ayahsPerPage);
    await prefs.setInt('lastPage', _currentPage);
    await prefs.setStringList(
        'bookmarks', _bookmarks.map((b) => json.encode(b.toJson())).toList());
  }

  Future<void> _loadSurahs() async {
    try {
      _isLoading = true;
      notifyListeners();
      _surahs = await _quranService.getSurahs();

      // Build static juz-surah mapping
      _juzSurahMap = _buildJuzMap();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<int, List<Surah>> _buildJuzMap() {
    // Static juz-surah mapping based on Quran structure
    const juzSurahRanges = {
      1: [1, 2], 2: [2, 3], 3: [3, 4], 4: [4, 5], 5: [5, 6],
      6: [6, 7], 7: [7, 8, 9], 8: [9, 10], 9: [10, 11, 12],
      10: [12, 13, 14, 15], 11: [15, 16, 17], 12: [17, 18, 19],
      13: [19, 20, 21, 22], 14: [22, 23, 24, 25], 15: [25, 26, 27],
      16: [27, 28, 29, 30, 31, 32, 33], 17: [33, 34, 35, 36, 37, 38, 39],
      18: [39, 40, 41, 42, 43, 44, 45, 46], 19: [46, 47, 48, 49, 50, 51],
      20: [51, 52, 53, 54, 55, 56, 57], 21: [57, 58, 59, 60, 61, 62, 63, 64, 65, 66],
      22: [66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77],
      23: [77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      24: [98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      25: [98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      26: [98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      27: [98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      28: [98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      29: [98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
      30: [78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
    };

    // Better approach: use proper juz-surah mapping
    final Map<int, List<int>> properJuzMap = {
      1: [1, 2], 2: [2, 3], 3: [3, 4], 4: [4, 5], 5: [5, 6],
      6: [6, 7], 7: [7, 8, 9], 8: [9, 10], 9: [10, 11, 12],
      10: [12, 13, 14, 15], 11: [15, 16, 17], 12: [17, 18, 19],
      13: [19, 20, 21, 22], 14: [22, 23, 24, 25], 15: [25, 26, 27],
      16: [27, 28, 29, 30, 31, 32, 33], 17: [33, 34, 35, 36, 37, 38, 39],
      18: [39, 40, 41, 42, 43, 44, 45, 46], 19: [46, 47, 48, 49, 50, 51],
      20: [51, 52, 53, 54, 55, 56, 57], 21: [57, 58, 59, 60, 61, 62, 63, 64, 65, 66],
      22: [66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77],
      23: [77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97],
      24: [97, 98, 99, 100, 101, 102, 103, 104, 105, 106],
      25: [106, 107, 108, 109, 110, 111, 112, 113, 114],
      26: [107, 108, 109, 110, 111, 112, 113, 114],
      27: [107, 108, 109, 110, 111, 112, 113, 114],
      28: [107, 108, 109, 110, 111, 112, 113, 114],
      29: [107, 108, 109, 110, 111, 112, 113, 114],
      30: [78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114],
    };

    Map<int, List<Surah>> result = {};
    for (int juz = 1; juz <= 30; juz++) {
      final surahNums = properJuzMap[juz] ?? [];
      result[juz] = _surahs
          .where((s) => surahNums.contains(s.number))
          .toList();
    }
    return result;
  }

  Future<void> loadPage(int page) async {
    if (page < 1 || page > 604) return;
    await stopAudio();
    _selectedAyahs.clear();
    _isPageLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentPageAyahs = await _quranService.getAyahsByPage(page);
      _currentPage = page;
      await _savePreferences();
    } catch (e) {
      _error = 'فشل تحميل الصفحة: ${e.toString()}';
    } finally {
      _isPageLoading = false;
      notifyListeners();
    }
  }

  Future<void> goToNextPage() async {
    if (_currentPage < 604) await loadPage(_currentPage + 1);
  }

  Future<void> goToPreviousPage() async {
    if (_currentPage > 1) await loadPage(_currentPage - 1);
  }

  Future<void> navigateToSurah(int surahNumber) async {
    // Find the page of first ayah in this surah
    try {
      final detail = await _quranService.getSurahDetail(surahNumber);
      if (detail.ayahs.isNotEmpty) {
        await loadPage(detail.ayahs.first.page);
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void toggleAyahSelection(int index) {
    if (_selectedAyahs.contains(index)) {
      _selectedAyahs.remove(index);
    } else {
      _selectedAyahs.add(index);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAyahs.clear();
    notifyListeners();
  }

  Future<void> playSelectedOrAll() async {
    if (_isPlaying) {
      await stopAudio();
      return;
    }

    List<int> indicesToPlay;
    if (_selectedAyahs.isNotEmpty) {
      indicesToPlay = _selectedAyahs.toList()..sort();
    } else {
      indicesToPlay = List.generate(_currentPageAyahs.length, (i) => i);
    }

    if (indicesToPlay.isNotEmpty) {
      await _playAyahAtIndex(indicesToPlay.first);
    }
  }

  Future<void> _playAyahAtIndex(int index) async {
    if (index >= _currentPageAyahs.length) return;
    _currentAyahIndex = index;
    notifyListeners();
    final ayah = _currentPageAyahs[index];
    await _audioPlayer.play(UrlSource(ayah.audioUrl));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentAyahIndex = -1;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
     themeNotifier.value = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool('darkMode', _isDarkMode),
    );
  }

  void updateFontSize(double size) {
    _ayahFontSize = size;
    _savePreferences();
    notifyListeners();
  }

  void updateAyahsPerPage(int count) {
    _ayahsPerPage = count;
    _savePreferences();
    notifyListeners();
  }

  void bookmarkCurrentPage() {
    final surahName = _currentPageAyahs.isNotEmpty
        ? (_currentPageAyahs.first.surahName ?? 'غير معروف')
        : 'غير معروف';
    
    final exists = _bookmarks.any((b) => b.pageNumber == _currentPage);
    if (!exists) {
      _bookmarks.add(BookmarkedPage(
        pageNumber: _currentPage,
        surahName: surahName,
        savedAt: DateTime.now(),
      ));
      _savePreferences();
      notifyListeners();
    }
  }

  void removeBookmark(int pageNumber) {
    _bookmarks.removeWhere((b) => b.pageNumber == pageNumber);
    _savePreferences();
    notifyListeners();
  }

  bool isPageBookmarked(int page) => _bookmarks.any((b) => b.pageNumber == page);

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
